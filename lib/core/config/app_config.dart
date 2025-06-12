/// Application configuration constants and settings
class AppConfig {
  /// Application name
  static const String appName = 'Yoga';
  
  /// Version information
  static const String version = '1.0.0';
  
  /// Supabase configuration
  static const String supabaseUrl = 'https://kgafxrxylfjiabqrjyya.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtnYWZ4cnh5bGZqaWFicXJqeXlhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk3MTE2MzUsImV4cCI6MjA2NTI4NzYzNX0.7uvpHutQkonN87ROwmY0YyFetM3AZXvWXs2KNH26_8U';
  
  /// App colors
  static const int primaryColorValue = 0xFF6B7280;
  static const int accentColorValue = 0xFF10B981;
  
  /// Feature flags
  static const bool enableMockData = false;
  static const bool enableLogging = true;
  
  /// Pagination settings
  static const int defaultPageSize = 20;
  static const int maxTrainersPerPage = 10;
  
  /// Session settings
  static const int sessionTimeout = 30; // minutes
  static const int maxClassDuration = 120; // minutes
  
  /// Media settings
  static const int maxImageSize = 5; // MB
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png'];
} 