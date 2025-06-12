-- Enable Row Level Security on all tables
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.trainer_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.classes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.class_bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.diet_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.diet_subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- Helper function to get current user's role
CREATE OR REPLACE FUNCTION public.get_user_role()
RETURNS user_role AS $$
BEGIN
    RETURN (
        SELECT role 
        FROM public.users 
        WHERE id = auth.uid()
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function to check if user is admin
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN AS $$
BEGIN
    RETURN get_user_role() = 'admin';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function to check if user is trainer
CREATE OR REPLACE FUNCTION public.is_trainer()
RETURNS BOOLEAN AS $$
BEGIN
    RETURN get_user_role() = 'trainer';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Users table policies
CREATE POLICY "Users can view their own profile" ON public.users
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" ON public.users
    FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Anyone can insert their user profile on signup" ON public.users
    FOR INSERT WITH CHECK (auth.uid() = id);

CREATE POLICY "Admins can view all users" ON public.users
    FOR SELECT USING (is_admin());

CREATE POLICY "Admins can update any user" ON public.users
    FOR UPDATE USING (is_admin());

CREATE POLICY "Trainers can view basic user info for their bookings" ON public.users
    FOR SELECT USING (
        is_trainer() AND 
        id IN (
            SELECT cb.user_id 
            FROM public.class_bookings cb
            JOIN public.classes c ON c.id = cb.class_id
            JOIN public.trainer_profiles tp ON tp.id = c.trainer_id
            WHERE tp.user_id = auth.uid()
        )
    );

-- Trainer profiles policies
CREATE POLICY "Anyone can view trainer profiles" ON public.trainer_profiles
    FOR SELECT USING (true);

CREATE POLICY "Trainers can insert their own profile" ON public.trainer_profiles
    FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "Trainers can update their own profile" ON public.trainer_profiles
    FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY "Admins can manage all trainer profiles" ON public.trainer_profiles
    FOR ALL USING (is_admin());

-- Classes policies
CREATE POLICY "Anyone can view active classes" ON public.classes
    FOR SELECT USING (status != 'cancelled');

CREATE POLICY "Trainers can manage their own classes" ON public.classes
    FOR ALL USING (
        trainer_id IN (
            SELECT id FROM public.trainer_profiles WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Admins can manage all classes" ON public.classes
    FOR ALL USING (is_admin());

-- Class bookings policies
CREATE POLICY "Users can view their own bookings" ON public.class_bookings
    FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "Users can create their own bookings" ON public.class_bookings
    FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own bookings" ON public.class_bookings
    FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY "Trainers can view bookings for their classes" ON public.class_bookings
    FOR SELECT USING (
        class_id IN (
            SELECT c.id 
            FROM public.classes c
            JOIN public.trainer_profiles tp ON tp.id = c.trainer_id
            WHERE tp.user_id = auth.uid()
        )
    );

CREATE POLICY "Trainers can update bookings for their classes" ON public.class_bookings
    FOR UPDATE USING (
        class_id IN (
            SELECT c.id 
            FROM public.classes c
            JOIN public.trainer_profiles tp ON tp.id = c.trainer_id
            WHERE tp.user_id = auth.uid()
        )
    );

CREATE POLICY "Admins can manage all bookings" ON public.class_bookings
    FOR ALL USING (is_admin());

-- User progress policies
CREATE POLICY "Users can manage their own progress" ON public.user_progress
    FOR ALL USING (user_id = auth.uid());

CREATE POLICY "Trainers can view progress of their students" ON public.user_progress
    FOR SELECT USING (
        user_id IN (
            SELECT cb.user_id 
            FROM public.class_bookings cb
            JOIN public.classes c ON c.id = cb.class_id
            JOIN public.trainer_profiles tp ON tp.id = c.trainer_id
            WHERE tp.user_id = auth.uid()
        )
    );

CREATE POLICY "Admins can view all progress" ON public.user_progress
    FOR SELECT USING (is_admin());

-- Diet plans policies
CREATE POLICY "Anyone can view active diet plans" ON public.diet_plans
    FOR SELECT USING (is_active = true);

CREATE POLICY "Trainers can manage their own diet plans" ON public.diet_plans
    FOR ALL USING (
        trainer_id IN (
            SELECT id FROM public.trainer_profiles WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Admins can manage all diet plans" ON public.diet_plans
    FOR ALL USING (is_admin());

-- Diet subscriptions policies
CREATE POLICY "Users can view their own diet subscriptions" ON public.diet_subscriptions
    FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "Users can create their own diet subscriptions" ON public.diet_subscriptions
    FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own diet subscriptions" ON public.diet_subscriptions
    FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY "Trainers can view subscriptions to their diet plans" ON public.diet_subscriptions
    FOR SELECT USING (
        diet_plan_id IN (
            SELECT dp.id 
            FROM public.diet_plans dp
            JOIN public.trainer_profiles tp ON tp.id = dp.trainer_id
            WHERE tp.user_id = auth.uid()
        )
    );

CREATE POLICY "Admins can manage all diet subscriptions" ON public.diet_subscriptions
    FOR ALL USING (is_admin());

-- Reviews policies
CREATE POLICY "Anyone can view verified reviews" ON public.reviews
    FOR SELECT USING (is_verified = true);

CREATE POLICY "Users can create reviews" ON public.reviews
    FOR INSERT WITH CHECK (reviewer_id = auth.uid());

CREATE POLICY "Users can view their own reviews" ON public.reviews
    FOR SELECT USING (reviewer_id = auth.uid());

CREATE POLICY "Users can update their own unverified reviews" ON public.reviews
    FOR UPDATE USING (reviewer_id = auth.uid() AND is_verified = false);

CREATE POLICY "Trainers can view reviews for their services" ON public.reviews
    FOR SELECT USING (
        trainer_id IN (
            SELECT id FROM public.trainer_profiles WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Admins can manage all reviews" ON public.reviews
    FOR ALL USING (is_admin());

-- Notifications policies
CREATE POLICY "Users can view their own notifications" ON public.notifications
    FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "Users can update their own notifications" ON public.notifications
    FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY "System can insert notifications" ON public.notifications
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Admins can manage all notifications" ON public.notifications
    FOR ALL USING (is_admin());

-- Function to handle user creation from auth.users
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.users (id, email, full_name, avatar_url)
    VALUES (
        NEW.id,
        NEW.email,
        NEW.raw_user_meta_data->>'full_name',
        NEW.raw_user_meta_data->>'avatar_url'
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to automatically create user profile
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Function to update trainer rating when new review is added
CREATE OR REPLACE FUNCTION public.update_trainer_rating()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.trainer_id IS NOT NULL THEN
        UPDATE public.trainer_profiles
        SET 
            rating = (
                SELECT AVG(rating)::DECIMAL(3,2) 
                FROM public.reviews 
                WHERE trainer_id = NEW.trainer_id AND is_verified = true
            ),
            total_reviews = (
                SELECT COUNT(*) 
                FROM public.reviews 
                WHERE trainer_id = NEW.trainer_id AND is_verified = true
            )
        WHERE id = NEW.trainer_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to update trainer rating
CREATE TRIGGER on_review_verified
    AFTER INSERT OR UPDATE ON public.reviews
    FOR EACH ROW 
    WHEN (NEW.is_verified = true AND NEW.trainer_id IS NOT NULL)
    EXECUTE FUNCTION public.update_trainer_rating(); 