import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/haptic_utils.dart';

/// Notifications screen for managing app notifications
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppTheme.surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back),
          onPressed: () {
            HapticUtils.lightImpact();
            context.pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              HapticUtils.lightImpact();
              // Mark all as read
            },
            child: Text(
              'Mark all read',
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotificationSettings(context),
            const SizedBox(height: AppTheme.spacingL),
            _buildRecentNotifications(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSettings(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        border: Border.all(
          color: AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Ionicons.settings,
                color: AppTheme.primaryColor,
                size: 24,
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(
                'Notification Settings',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildSettingToggle(
            context,
            'Class Reminders',
            'Get notified 30 minutes before your class',
            true,
          ),
          _buildSettingToggle(
            context,
            'Habit Reminders',
            'Daily reminders for your wellness habits',
            true,
          ),
          _buildSettingToggle(
            context,
            'New Classes',
            'Notifications about new available classes',
            false,
          ),
          _buildSettingToggle(
            context,
            'Wellness Tips',
            'Daily motivation and wellness tips',
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingToggle(
    BuildContext context,
    String title,
    String subtitle,
    bool enabled,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingS),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: enabled,
            onChanged: (value) {
              HapticUtils.lightImpact();
              // Toggle setting
            },
            activeColor: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentNotifications(BuildContext context) {
    final notifications = [
      {
        'title': 'Class Reminder',
        'message': 'Your Morning Hatha Flow class starts in 30 minutes',
        'time': '30 min ago',
        'icon': Ionicons.time,
        'color': AppTheme.primaryColor,
        'unread': true,
      },
      {
        'title': 'Habit Completed!',
        'message': 'Great job completing your morning meditation',
        'time': '2 hours ago',
        'icon': Ionicons.checkmark_circle,
        'color': AppTheme.secondaryColor,
        'unread': true,
      },
      {
        'title': 'New Class Available',
        'message': 'Restorative Yoga with Sarah Johnson is now available',
        'time': '1 day ago',
        'icon': Ionicons.add_circle,
        'color': AppTheme.primaryColor,
        'unread': false,
      },
      {
        'title': 'Weekly Progress',
        'message': 'You completed 85% of your wellness goals this week!',
        'time': '2 days ago',
        'icon': Ionicons.trophy,
        'color': AppTheme.secondaryColor,
        'unread': false,
      },
      {
        'title': 'Wellness Tip',
        'message': 'Remember to stay hydrated throughout your yoga practice',
        'time': '3 days ago',
        'icon': Ionicons.water,
        'color': AppTheme.primaryColor,
        'unread': false,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Notifications',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        ...notifications.map((notification) => 
          _buildNotificationCard(context, notification)),
      ],
    );
  }

  Widget _buildNotificationCard(
    BuildContext context, 
    Map<String, dynamic> notification,
  ) {
    final isUnread = notification['unread'] as bool;
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: isUnread 
            ? AppTheme.primaryColor.withOpacity(0.05)
            : AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        border: Border.all(
          color: isUnread 
              ? AppTheme.primaryColor.withOpacity(0.2)
              : AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            decoration: BoxDecoration(
              color: notification['color'] as Color,
              borderRadius: BorderRadius.circular(AppTheme.radiusL),
            ),
            child: Icon(
              notification['icon'] as IconData,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification['title'],
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  notification['message'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingS),
                Text(
                  notification['time'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 