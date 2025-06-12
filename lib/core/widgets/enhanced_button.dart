import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/haptic_utils.dart';

/// Enhanced button widget with haptic feedback and natural styling
class EnhancedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final ButtonVariant variant;
  final ButtonSize size;
  final IconData? icon;
  final bool hapticEnabled;

  const EnhancedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.large,
    this.icon,
    this.hapticEnabled = true,
  });

  const EnhancedButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = ButtonSize.large,
    this.icon,
    this.hapticEnabled = true,
  }) : variant = ButtonVariant.primary;

  const EnhancedButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = ButtonSize.large,
    this.icon,
    this.hapticEnabled = true,
  }) : variant = ButtonVariant.secondary;

  const EnhancedButton.outline({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = ButtonSize.large,
    this.icon,
    this.hapticEnabled = true,
  }) : variant = ButtonVariant.outline;

  const EnhancedButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = ButtonSize.medium,
    this.icon,
    this.hapticEnabled = true,
  }) : variant = ButtonVariant.text;

  @override
  Widget build(BuildContext context) {
    final isEnabled = !isDisabled && !isLoading && onPressed != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: _buildButton(context, isEnabled),
    );
  }

  Widget _buildButton(BuildContext context, bool isEnabled) {
    switch (variant) {
      case ButtonVariant.primary:
        return _buildElevatedButton(context, isEnabled);
      case ButtonVariant.secondary:
        return _buildSecondaryButton(context, isEnabled);
      case ButtonVariant.outline:
        return _buildOutlinedButton(context, isEnabled);
      case ButtonVariant.text:
        return _buildTextButton(context, isEnabled);
    }
  }

  Widget _buildElevatedButton(BuildContext context, bool isEnabled) {
    return ElevatedButton(
      onPressed: isEnabled ? _handlePress : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? AppTheme.primaryColor : AppTheme.textTertiary,
        foregroundColor: AppTheme.textInverse,
        elevation: isEnabled ? 3 : 1,
        shadowColor: AppTheme.primaryColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
        padding: _getPadding(),
        minimumSize: _getMinimumSize(),
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildSecondaryButton(BuildContext context, bool isEnabled) {
    return ElevatedButton(
      onPressed: isEnabled ? _handlePress : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? AppTheme.secondaryColor : AppTheme.textTertiary,
        foregroundColor: AppTheme.textPrimary,
        elevation: isEnabled ? 2 : 1,
        shadowColor: AppTheme.secondaryColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
        padding: _getPadding(),
        minimumSize: _getMinimumSize(),
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildOutlinedButton(BuildContext context, bool isEnabled) {
    return OutlinedButton(
      onPressed: isEnabled ? _handlePress : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: isEnabled ? AppTheme.primaryColor : AppTheme.textTertiary,
        side: BorderSide(
          color: isEnabled ? AppTheme.primaryColor : AppTheme.borderColor,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
        padding: _getPadding(),
        minimumSize: _getMinimumSize(),
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildTextButton(BuildContext context, bool isEnabled) {
    return TextButton(
      onPressed: isEnabled ? _handlePress : null,
      style: TextButton.styleFrom(
        foregroundColor: isEnabled ? AppTheme.primaryColor : AppTheme.textTertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
        padding: _getPadding(),
        minimumSize: _getMinimumSize(),
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: _getTextSize(),
        width: _getTextSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            variant == ButtonVariant.primary ? AppTheme.textInverse : AppTheme.primaryColor,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _getIconSize()),
          SizedBox(width: AppTheme.spacingS),
          Text(
            text,
            style: _getTextStyle(context),
          ),
        ],
      );
    }

    return Text(
      text,
      style: _getTextStyle(context),
    );
  }

  void _handlePress() {
    if (hapticEnabled) {
      HapticUtils.lightImpact();
    }
    onPressed?.call();
  }

  double _getBorderRadius() {
    switch (size) {
      case ButtonSize.small:
        return 12;
      case ButtonSize.medium:
        return 16;
      case ButtonSize.large:
        return 20;
      case ButtonSize.extraLarge:
        return 24;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
      case ButtonSize.extraLarge:
        return const EdgeInsets.symmetric(horizontal: 40, vertical: 20);
    }
  }

  Size _getMinimumSize() {
    switch (size) {
      case ButtonSize.small:
        return const Size(80, 36);
      case ButtonSize.medium:
        return const Size(100, 44);
      case ButtonSize.large:
        return const Size(120, 52);
      case ButtonSize.extraLarge:
        return const Size(140, 60);
    }
  }

  double _getTextSize() {
    switch (size) {
      case ButtonSize.small:
        return 14;
      case ButtonSize.medium:
        return 15;
      case ButtonSize.large:
        return 16;
      case ButtonSize.extraLarge:
        return 18;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 18;
      case ButtonSize.large:
        return 20;
      case ButtonSize.extraLarge:
        return 22;
    }
  }

  TextStyle _getTextStyle(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.labelLarge;
    return baseStyle?.copyWith(
      fontSize: _getTextSize(),
      fontWeight: FontWeight.w600,
    ) ?? TextStyle(
      fontSize: _getTextSize(),
      fontWeight: FontWeight.w600,
    );
  }
}

enum ButtonVariant {
  primary,
  secondary,
  outline,
  text,
}

enum ButtonSize {
  small,
  medium,
  large,
  extraLarge,
} 