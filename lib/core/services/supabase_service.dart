import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/app_config.dart';

/// Service for managing Supabase connection and operations
class SupabaseService {
  static SupabaseClient? _client;
  
  /// Initialize Supabase client
  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: AppConfig.supabaseUrl,
        anonKey: AppConfig.supabaseAnonKey,
        authOptions: const FlutterAuthClientOptions(
          authFlowType: AuthFlowType.pkce,
        ),
        debug: true,
      );
      _client = Supabase.instance.client;
      print('Supabase initialized successfully');
    } catch (e) {
      print('Supabase initialization error: $e');
      // In production, use proper logging instead of print
    }
  }
  
  /// Get Supabase client instance
  static SupabaseClient? get client => _client;
  
  /// Check if Supabase is properly initialized
  static bool get isInitialized => _client != null;
  
  /// Get current user
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final user = _client?.auth.currentUser;
      return user?.toJson();
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }
  
  /// Sign in with email and password
  static Future<Map<String, dynamic>?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client?.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return {
        'user': response?.user?.toJson(),
        'session': response?.session?.toJson(),
      };
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }
  
  /// Sign up with email and password
  static Future<Map<String, dynamic>?> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await _client?.auth.signUp(
        email: email,
        password: password,
        data: metadata,
      );
      return {
        'user': response?.user?.toJson(),
        'session': response?.session?.toJson(),
      };
    } catch (e) {
      print('Error signing up: $e');
      return null;
    }
  }
  
  /// Sign in with Google
  static Future<bool> signInWithGoogle() async {
    try {
      final result = await _client?.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.flutterquickstart://login-callback/',
      );
      return result ?? false;
    } catch (e) {
      print('Error signing in with Google: $e');
      return false;
    }
  }
  
  /// Sign out
  static Future<void> signOut() async {
    try {
      await _client?.auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
  
  /// Get all records from a table
  static Future<List<Map<String, dynamic>>> getAll(String table) async {
    try {
      final response = await _client?.from(table).select();
      return List<Map<String, dynamic>>.from(response ?? []);
    } catch (e) {
      print('Error getting data from $table: $e');
      return [];
    }
  }
  
  /// Get records with filters
  static Future<List<Map<String, dynamic>>> getWithFilter({
    required String table,
    required String column,
    required dynamic value,
  }) async {
    try {
      final response = await _client?.from(table).select().eq(column, value);
      return List<Map<String, dynamic>>.from(response ?? []);
    } catch (e) {
      print('Error getting filtered data from $table: $e');
      return [];
    }
  }
  
  /// Insert data into table
  static Future<Map<String, dynamic>?> insert({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _client?.from(table).insert(data).select().single();
      return response;
    } catch (e) {
      print('Error inserting data: $e');
      return null;
    }
  }
  
  /// Update data in table
  static Future<Map<String, dynamic>?> update({
    required String table,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _client?.from(table).update(data).eq('id', id).select().single();
      return response;
    } catch (e) {
      print('Error updating data: $e');
      return null;
    }
  }
  
  /// Delete data from table
  static Future<bool> delete({
    required String table,
    required String id,
  }) async {
    try {
      await _client?.from(table).delete().eq('id', id);
      return true;
    } catch (e) {
      print('Error deleting data: $e');
      return false;
    }
  }
} 