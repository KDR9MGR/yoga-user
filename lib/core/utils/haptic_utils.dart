import 'package:flutter/services.dart';

/// Utility class for haptic feedback using Flutter's built-in capabilities
class HapticUtils {
  /// Light haptic feedback for button taps and selections
  static void lightImpact() {
    HapticFeedback.lightImpact();
  }

  /// Medium haptic feedback for notifications and confirmations
  static void mediumImpact() {
    HapticFeedback.mediumImpact();
  }

  /// Heavy haptic feedback for important actions and errors
  static void heavyImpact() {
    HapticFeedback.heavyImpact();
  }

  /// Selection feedback for toggles, switches, and list selections
  static void selectionClick() {
    HapticFeedback.selectionClick();
  }

  /// Success feedback - light impact for positive actions
  static void success() {
    HapticFeedback.lightImpact();
  }

  /// Error feedback - heavy impact for errors or important warnings
  static void error() {
    HapticFeedback.heavyImpact();
  }

  /// Warning feedback - medium impact for warnings
  static void warning() {
    HapticFeedback.mediumImpact();
  }

  /// Button tap feedback - light impact for general button presses
  static void buttonTap() {
    HapticFeedback.lightImpact();
  }

  /// Toggle feedback - selection click for switches and toggles
  static void toggle() {
    HapticFeedback.selectionClick();
  }

  /// Navigation feedback - light impact for navigation actions
  static void navigation() {
    HapticFeedback.lightImpact();
  }

  /// Refresh feedback - medium impact for refresh actions
  static void refresh() {
    HapticFeedback.mediumImpact();
  }
} 