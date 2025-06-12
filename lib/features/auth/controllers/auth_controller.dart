import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/supabase_service.dart';

/// Authentication state
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? user;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.error,
    this.user,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
    Map<String, dynamic>? user,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
    );
  }
}

/// Authentication controller
class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState()) {
    _checkInitialAuthState();
  }

  /// Check if user is already authenticated on app start
  Future<void> _checkInitialAuthState() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final user = await SupabaseService.getCurrentUser();
      state = state.copyWith(
        isAuthenticated: user != null,
        user: user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  /// Sign in with email and password
  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await SupabaseService.signInWithEmail(
        email: email,
        password: password,
      );
      
      if (response != null) {
        state = state.copyWith(
          isAuthenticated: true,
          user: response['user'],
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          error: 'Invalid email or password',
          isLoading: false,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
      return false;
    }
  }

  /// Sign up with email and password
  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    String? fullName,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await SupabaseService.signUpWithEmail(
        email: email,
        password: password,
        metadata: fullName != null ? {'name': fullName} : null,
      );
      
      if (response != null) {
        state = state.copyWith(
          isAuthenticated: true,
          user: response['user'],
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          error: 'Failed to create account',
          isLoading: false,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
      return false;
    }
  }

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await SupabaseService.signInWithGoogle();
      
      state = state.copyWith(
        isAuthenticated: true,
        user: response['user'],
        isLoading: false,
      );
      return true;
        } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
      return false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    
    try {
      await SupabaseService.signOut();
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Auth controller provider
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController();
}); 