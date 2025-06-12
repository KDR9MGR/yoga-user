import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/haptic_utils.dart';

/// Habits screen for tracking healthy routines
class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Habit Tracker'),
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
          IconButton(
            icon: const Icon(Ionicons.add),
            onPressed: () {
              HapticUtils.lightImpact();
              // Add new habit
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: AppTheme.spacingL),
            _buildTodayProgress(context),
            const SizedBox(height: AppTheme.spacingL),
            _buildHabitsList(context),
            const SizedBox(height: AppTheme.spacingL),
            _buildWeeklyStreak(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusL),
            ),
            child: const Icon(
              Ionicons.checkmark_circle,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Build Healthy Habits',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  'Track your daily wellness routines',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayProgress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Progress',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        Container(
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
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryColor.withOpacity(0.1),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        '75%',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingM),
              Text(
                '3 of 4 habits completed',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacingS),
              Text(
                'Great job! Keep it up!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHabitsList(BuildContext context) {
    final habits = [
      {
        'name': 'Morning Meditation',
        'icon': Ionicons.leaf,
        'completed': true,
        'streak': 7,
        'time': '5 min',
      },
      {
        'name': 'Drink 8 Glasses of Water',
        'icon': Ionicons.water,
        'completed': true,
        'streak': 12,
        'time': 'Throughout day',
      },
      {
        'name': 'Evening Yoga',
        'icon': Ionicons.body,
        'completed': true,
        'streak': 5,
        'time': '20 min',
      },
      {
        'name': 'Read for 30 minutes',
        'icon': Ionicons.book,
        'completed': false,
        'streak': 3,
        'time': '30 min',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Habits',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        ...habits.map((habit) => _buildHabitCard(context, habit)),
      ],
    );
  }

  Widget _buildHabitCard(BuildContext context, Map<String, dynamic> habit) {
    final isCompleted = habit['completed'] as bool;
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        border: Border.all(
          color: isCompleted 
              ? AppTheme.primaryColor.withOpacity(0.3)
              : AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HapticUtils.mediumImpact();
              // Toggle habit completion
            },
            child: Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                color: isCompleted 
                    ? AppTheme.primaryColor 
                    : AppTheme.borderColor,
                borderRadius: BorderRadius.circular(AppTheme.radiusL),
              ),
              child: Icon(
                isCompleted 
                    ? Ionicons.checkmark 
                    : habit['icon'] as IconData,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit['name'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                    decoration: isCompleted 
                        ? TextDecoration.lineThrough 
                        : null,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Row(
                  children: [
                    Icon(
                      Ionicons.time_outline,
                      size: 16,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(width: AppTheme.spacingXS),
                    Text(
                      habit['time'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingM),
                    Icon(
                      Ionicons.flame,
                      size: 16,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: AppTheme.spacingXS),
                    Text(
                      '${habit['streak']} days',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyStreak(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Ionicons.trophy,
                color: AppTheme.primaryColor,
                size: 24,
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(
                'Weekly Overview',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              final isCompleted = index < 5; // Mock data
              return Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted 
                          ? AppTheme.primaryColor 
                          : AppTheme.borderColor,
                    ),
                    child: Center(
                      child: Text(
                        ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXS),
                  if (isCompleted)
                    Icon(
                      Ionicons.checkmark,
                      size: 16,
                      color: AppTheme.primaryColor,
                    )
                  else
                    const SizedBox(height: 16),
                ],
              );
            }),
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'You\'re on a 5-day streak! Keep going!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
} 