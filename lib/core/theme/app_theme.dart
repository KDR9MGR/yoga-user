import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App theme configuration with natural color palette
class AppTheme {
  AppTheme._();

  // Natural Color Palette
  static const Color softWhite = Color(0xFFF9F9F6);         // Very light white-cream blend
  static const Color linenWhite = Color(0xFFF5F3EF);        // Warm white, organic paper feel
  static const Color mossGreen = Color(0xFFA3B18A);         // Calm green, earthy
  static const Color sageGreen = Color(0xFFBCCAB3);         // Muted, relaxing green
  static const Color oliveMist = Color(0xFFDDE4D0);         // Pale greenish neutral
  static const Color stoneBeige = Color(0xFFD8CAB8);        // Soft neutral beige
  static const Color clayBrown = Color(0xFFA89F91);         // Earthy muted brown
  static const Color sand = Color(0xFFE6DFD5);              // Neutral soft sand color
  static const Color charcoalFog = Color(0xFF4A4A4A);       // For text / contrast

  // Primary app colors using natural palette
  static const Color primaryColor = mossGreen;              // Main brand color
  static const Color secondaryColor = sageGreen;            // Secondary actions
  static const Color accentColor = oliveMist;               // Highlights and accents
  static const Color backgroundColor = softWhite;           // Main background
  static const Color surfaceColor = linenWhite;             // Cards and surfaces
  static const Color dividerColor = Color(0xFFEEE9E0);      // Lighter dividers
  static const Color borderColor = Color(0xFFE0D7C8);       // Lighter borders
  
  // Text colors
  static const Color textPrimary = charcoalFog;             // Primary text
  static const Color textSecondary = Color(0xFF6B6B6B);     // Secondary text
  static const Color textTertiary = Color(0xFF9B9B9B);      // Tertiary text
  static const Color textInverse = softWhite;               // Text on dark backgrounds
  
  // Status colors (keeping these functional but natural)
  static const Color successColor = mossGreen;              // Success states
  static const Color warningColor = clayBrown;              // Warning states
  static const Color errorColor = Color(0xFFB8735A);        // Error states (muted red-brown)
  static const Color infoColor = sageGreen;                 // Info states

  /// Light theme configuration
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.inter().fontFamily,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
      surface: surfaceColor,
      error: errorColor,
      onPrimary: textInverse,
      onSecondary: textPrimary,
      onTertiary: textPrimary,
      onSurface: textPrimary,
      onError: textInverse,
    ),
    
    // Typography using Google Fonts
    textTheme: GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textSecondary,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textPrimary,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textPrimary,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: textSecondary,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textSecondary,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: textTertiary,
      ),
    ),
    
    // App bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceColor,
      foregroundColor: textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
    ),
    
    // Enhanced elevated button theme - bigger and more rounded
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: textInverse,
        elevation: 3,
        shadowColor: primaryColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // More rounded
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Bigger
        minimumSize: const Size(120, 48), // Minimum size
        textStyle: GoogleFonts.inter(
          fontSize: 16, // Larger text
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Enhanced text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Outlined button theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: borderColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        minimumSize: const Size(120, 48),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Enhanced input decoration theme with lighter borders
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), // More rounded
        borderSide: const BorderSide(color: borderColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: errorColor, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // More padding
      hintStyle: GoogleFonts.inter(
        color: textTertiary,
        fontSize: 14,
      ),
    ),
    
    // Enhanced card theme
    cardTheme: CardTheme(
      elevation: 2,
      shadowColor: primaryColor.withOpacity(0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // More rounded
      ),
      color: surfaceColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // Divider theme with lighter color
    dividerTheme: const DividerThemeData(
      color: dividerColor,
      thickness: 1,
      space: 20,
    ),
    
    // Bottom navigation bar theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: textTertiary,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
    
    // Floating action button theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: textInverse,
      elevation: 4,
      shape: CircleBorder(),
    ),
    
    // Scaffold background
    scaffoldBackgroundColor: backgroundColor,
  );
  
  /// Custom spacing constants
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  
  /// Custom radius constants
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusXXL = 32.0;
} 