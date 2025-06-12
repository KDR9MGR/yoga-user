-- Sample Data Migration
-- This file contains sample data for testing the yoga app

-- Instructions for setting up the database
-- 1. First, create users through Supabase Auth Dashboard or your app's signup
-- 2. Get the user IDs from auth.users table
-- 3. Use the seed_sample_data() function after creating auth users

-- Function to seed data with actual user IDs (call this after users are created)
CREATE OR REPLACE FUNCTION public.seed_sample_data()
RETURNS void AS $$
DECLARE
    admin_id UUID;
    trainer1_id UUID;
    trainer2_id UUID;
    trainer3_id UUID;
    trainer1_profile_id UUID;
    trainer2_profile_id UUID;
    trainer3_profile_id UUID;
BEGIN
    -- Get user IDs from auth.users (update emails as needed)
    SELECT id INTO admin_id FROM auth.users WHERE email = 'admin@yoga.com';
    SELECT id INTO trainer1_id FROM auth.users WHERE email = 'sarah.johnson@yoga.com';
    SELECT id INTO trainer2_id FROM auth.users WHERE email = 'mike.chen@yoga.com';
    SELECT id INTO trainer3_id FROM auth.users WHERE email = 'emma.wilson@yoga.com';
    
    -- Update user roles if users exist
    IF admin_id IS NOT NULL THEN
        UPDATE public.users SET role = 'admin', full_name = 'Admin User' WHERE id = admin_id;
    END IF;
    
    IF trainer1_id IS NOT NULL THEN
        UPDATE public.users SET role = 'trainer', full_name = 'Sarah Johnson' WHERE id = trainer1_id;
        
        -- Insert trainer profile
        INSERT INTO public.trainer_profiles (
            user_id, bio, specializations, experience_years, 
            hourly_rate, location, is_verified, availability
        ) VALUES (
            trainer1_id,
            'Certified yoga instructor with 5+ years of experience in Hatha and Vinyasa yoga.',
            ARRAY['Hatha Yoga', 'Vinyasa', 'Meditation'],
            5,
            50.00,
            'New York, NY',
            true,
            '{"monday": ["09:00-12:00", "14:00-18:00"], "tuesday": ["09:00-12:00"], "wednesday": ["09:00-12:00", "14:00-18:00"]}'::jsonb
        ) ON CONFLICT (user_id) DO NOTHING
        RETURNING id INTO trainer1_profile_id;
    END IF;
    
    IF trainer2_id IS NOT NULL THEN
        UPDATE public.users SET role = 'trainer', full_name = 'Mike Chen' WHERE id = trainer2_id;
        
        -- Insert trainer profile
        INSERT INTO public.trainer_profiles (
            user_id, bio, specializations, experience_years, 
            hourly_rate, location, is_verified, availability
        ) VALUES (
            trainer2_id,
            'Expert in Power Yoga and strength-building practices. 8 years of experience.',
            ARRAY['Power Yoga', 'Ashtanga', 'Strength Training'],
            8,
            65.00,
            'Los Angeles, CA',
            true,
            '{"monday": ["06:00-09:00", "17:00-20:00"], "tuesday": ["06:00-09:00", "17:00-20:00"]}'::jsonb
        ) ON CONFLICT (user_id) DO NOTHING
        RETURNING id INTO trainer2_profile_id;
    END IF;
    
    IF trainer3_id IS NOT NULL THEN
        UPDATE public.users SET role = 'trainer', full_name = 'Emma Wilson' WHERE id = trainer3_id;
        
        -- Insert trainer profile
        INSERT INTO public.trainer_profiles (
            user_id, bio, specializations, experience_years, 
            hourly_rate, location, is_verified, availability
        ) VALUES (
            trainer3_id,
            'Specializes in gentle, restorative yoga practices for relaxation.',
            ARRAY['Restorative Yoga', 'Yin Yoga', 'Mindfulness'],
            3,
            45.00,
            'Austin, TX',
            true,
            '{"monday": ["10:00-14:00"], "tuesday": ["10:00-14:00"], "friday": ["10:00-14:00"]}'::jsonb
        ) ON CONFLICT (user_id) DO NOTHING
        RETURNING id INTO trainer3_profile_id;
    END IF;
    
    -- Get trainer profile IDs if not from INSERT
    IF trainer1_profile_id IS NULL THEN
        SELECT id INTO trainer1_profile_id FROM public.trainer_profiles WHERE user_id = trainer1_id;
    END IF;
    IF trainer2_profile_id IS NULL THEN
        SELECT id INTO trainer2_profile_id FROM public.trainer_profiles WHERE user_id = trainer2_id;
    END IF;
    IF trainer3_profile_id IS NULL THEN
        SELECT id INTO trainer3_profile_id FROM public.trainer_profiles WHERE user_id = trainer3_id;
    END IF;
    
    -- Insert sample classes
    IF trainer1_profile_id IS NOT NULL THEN
        INSERT INTO public.classes (
            trainer_id, title, description, duration_minutes, 
            difficulty, max_participants, price, scheduled_at, 
            is_online, tags
        ) VALUES (
            trainer1_profile_id,
            'Morning Hatha Flow',
            'Start your day with gentle Hatha yoga movements that will energize your body and calm your mind.',
            60,
            'beginner',
            15,
            25.00,
            NOW() + INTERVAL '2 days',
            true,
            ARRAY['morning', 'beginner-friendly', 'energizing']
        ) ON CONFLICT DO NOTHING;
    END IF;
    
    IF trainer2_profile_id IS NOT NULL THEN
        INSERT INTO public.classes (
            trainer_id, title, description, duration_minutes, 
            difficulty, max_participants, price, scheduled_at, 
            is_online, tags
        ) VALUES (
            trainer2_profile_id,
            'Power Yoga Challenge',
            'High-intensity power yoga session for experienced practitioners.',
            75,
            'advanced',
            12,
            35.00,
            NOW() + INTERVAL '3 days',
            true,
            ARRAY['strength', 'advanced', 'challenging']
        ) ON CONFLICT DO NOTHING;
    END IF;
    
    IF trainer3_profile_id IS NOT NULL THEN
        INSERT INTO public.classes (
            trainer_id, title, description, duration_minutes, 
            difficulty, max_participants, price, scheduled_at, 
            is_online, tags
        ) VALUES (
            trainer3_profile_id,
            'Evening Restorative Session',
            'Wind down with gentle restorative poses and deep breathing exercises.',
            90,
            'beginner',
            20,
            30.00,
            NOW() + INTERVAL '1 day',
            true,
            ARRAY['evening', 'relaxation', 'stress-relief']
        ) ON CONFLICT DO NOTHING;
    END IF;
    
    -- Insert sample diet plans
    IF trainer1_profile_id IS NOT NULL THEN
        INSERT INTO public.diet_plans (
            trainer_id, title, description, duration_weeks, 
            price, dietary_restrictions, meal_plans, nutritional_info
        ) VALUES (
            trainer1_profile_id,
            'Beginner Wellness Plan',
            'A gentle introduction to healthy eating for yoga practitioners.',
            4,
            99.00,
            ARRAY['vegetarian-friendly'],
            '{"focus": "Building healthy habits", "meals_per_day": 3}'::jsonb,
            '{"calories_per_day": "1800-2000", "macros": {"protein": "20%", "carbs": "50%", "fat": "30%"}}'::jsonb
        ) ON CONFLICT DO NOTHING;
    END IF;
    
    RAISE NOTICE 'Sample data seeding completed successfully!';
END;
$$ LANGUAGE plpgsql; 