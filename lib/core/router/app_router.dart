import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth screens
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';

// Main screens
import '../../features/home/screens/main_navigation_screen.dart';
import '../../features/home/screens/home_dashboard_screen.dart';
import '../../features/search/screens/search_screen.dart';
import '../../features/trainer/screens/trainer_list_screen.dart';
import '../../features/trainer/screens/trainer_detail_screen.dart';
import '../../features/progress/screens/progress_tracker_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';
import '../../features/classes/screens/class_booking_screen.dart';
import '../../features/classes/screens/live_classes_screen.dart';

// New screens
import '../../features/profile/screens/diet_plans_screen.dart';
import '../../features/profile/screens/habits_screen.dart';
import '../../features/profile/screens/notifications_screen.dart';
import '../../features/profile/screens/privacy_policy_screen.dart';
import '../../features/profile/screens/help_support_screen.dart';

// Controllers
import '../../features/auth/controllers/auth_controller.dart';

/// App router configuration using GoRouter
final appRouterProvider = Provider<GoRouter>((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  
  return GoRouter(
    initialLocation: '/onboarding',
    redirect: (context, state) {
      final isAuthenticated = ref.read(authControllerProvider).isAuthenticated;
      final currentPath = state.uri.path;
      final isOnboarding = currentPath == '/onboarding';
      final isAuthPage = currentPath.startsWith('/login') || 
                        currentPath.startsWith('/register');

      // If not authenticated and not on auth pages, redirect to onboarding
      if (!isAuthenticated && !isOnboarding && !isAuthPage) {
        return '/onboarding';
      }

      // If authenticated and on auth pages, redirect to home
      if (isAuthenticated && (isOnboarding || isAuthPage)) {
        return '/home';
      }

      return null;
    },
    routes: [
      // Authentication routes
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Main application shell
      ShellRoute(
        builder: (context, state, child) => MainNavigationScreen(child: child),
        routes: [
          // Home - Fixed route
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeDashboardScreen(),
          ),
          GoRoute(
            path: '/',
            redirect: (context, state) => '/home',
          ),
          
          // Search
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchScreen(),
          ),
          
          // Trainers
          GoRoute(
            path: '/trainers',
            builder: (context, state) => const TrainerListScreen(),
          ),
          GoRoute(
            path: '/trainer/:id',
            builder: (context, state) => TrainerDetailScreen(
              trainerId: state.pathParameters['id']!,
            ),
          ),
          
          // Progress
          GoRoute(
            path: '/progress',
            builder: (context, state) => const ProgressTrackerScreen(),
          ),
          
          // Profile
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/profile/edit',
            builder: (context, state) => const EditProfileScreen(),
          ),
          
          // Diet Plans
          GoRoute(
            path: '/diet-plans',
            builder: (context, state) => const DietPlansScreen(),
          ),
          
          // Habits
          GoRoute(
            path: '/habits',
            builder: (context, state) => const HabitsScreen(),
          ),
          
          // Notifications
          GoRoute(
            path: '/notifications',
            builder: (context, state) => const NotificationsScreen(),
          ),
          
          // Privacy Policy
          GoRoute(
            path: '/privacy-policy',
            builder: (context, state) => const PrivacyPolicyScreen(),
          ),
          
          // Help & Support
          GoRoute(
            path: '/help-support',
            builder: (context, state) => const HelpSupportScreen(),
          ),
          
          // Class booking
          GoRoute(
            path: '/book-class/:classId',
            builder: (context, state) => ClassBookingScreen(
              classId: state.pathParameters['classId']!,
            ),
          ),
          
          // Live classes
          GoRoute(
            path: '/live-classes',
            builder: (context, state) => const LiveClassesScreen(),
          ),
        ],
      ),
    ],
  );
});

/// Navigation helper class with route constants
class AppRoutes {
  // Authentication routes
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  
  // Main navigation routes
  static const String home = '/home';
  static const String search = '/search';
  static const String trainers = '/trainers';
  static const String progress = '/progress';
  static const String profile = '/profile';
  
  // Sub-routes
  static const String editProfile = '/profile/edit';
  static const String dietPlans = '/diet-plans';
  static const String habits = '/habits';
  static const String notifications = '/notifications';
  static const String privacyPolicy = '/privacy-policy';
  static const String helpSupport = '/help-support';
  static const String liveClasses = '/live-classes';
  static const String trainerDashboard = '/trainer-dashboard';
  
  // Dynamic routes helpers
  static String trainerDetail(String trainerId) => '/trainers/$trainerId';
  static String bookClass(String classId) => '/class/book/$classId';
  static String liveClass(String classId) => '/class/live/$classId';
  static String dietPlanDetail(String planId) => '/diet-plans/$planId';
} 