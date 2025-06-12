import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/enhanced_button.dart';
import '../../../core/utils/haptic_utils.dart';

/// Live classes screen showing upcoming and live yoga classes
class LiveClassesScreen extends ConsumerStatefulWidget {
  const LiveClassesScreen({super.key});

  @override
  ConsumerState<LiveClassesScreen> createState() => _LiveClassesScreenState();
}

class _LiveClassesScreenState extends ConsumerState<LiveClassesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Live Classes'),
        backgroundColor: AppTheme.surfaceColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Ionicons.calendar_outline),
            onPressed: () => HapticUtils.lightImpact(),
          ),
          IconButton(
            icon: const Icon(Ionicons.filter_outline),
            onPressed: () => HapticUtils.lightImpact(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Live Now'),
            Tab(text: 'My Classes'),
          ],
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.textSecondary,
          indicatorColor: AppTheme.primaryColor,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingClasses(),
          _buildLiveClasses(),
          _buildMyClasses(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => HapticUtils.mediumImpact(),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: AppTheme.textInverse,
        icon: const Icon(Ionicons.add),
        label: const Text('Create Class'),
      ),
    );
  }

  Widget _buildUpcomingClasses() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      itemCount: 3,
      itemBuilder: (context, index) {
        return _buildClassCard(
          'Morning Vinyasa Flow',
          'Sarah Johnson',
          'Today 9:00 AM',
          'Vinyasa • Intermediate',
          false,
        );
      },
    );
  }

  Widget _buildLiveClasses() {
    return const Center(
      child: Text('No live classes right now'),
    );
  }

  Widget _buildMyClasses() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      itemCount: 2,
      itemBuilder: (context, index) {
        return _buildClassCard(
          'Power Yoga Workshop',
          'You',
          'Tomorrow 10:00 AM',
          'Power • Advanced',
          true,
        );
      },
    );
  }

  Widget _buildClassCard(String title, String trainer, String time, String details, bool isOwn) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusL),
                ),
                child: const Icon(
                  Ionicons.fitness,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'with $trainer',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (isOwn)
                Icon(
                  Ionicons.settings_outline,
                  color: AppTheme.textTertiary,
                ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          Row(
            children: [
              Icon(
                Ionicons.time_outline,
                size: 16,
                color: AppTheme.textSecondary,
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(
                time,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Icon(
                Ionicons.barbell_outline,
                size: 16,
                color: AppTheme.textSecondary,
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(
                details,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingL),
          Row(
            children: [
              Expanded(
                child: EnhancedButton.outline(
                  text: 'View Details',
                  size: ButtonSize.medium,
                  onPressed: () => HapticUtils.lightImpact(),
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: EnhancedButton.primary(
                  text: isOwn ? 'Manage' : 'Book Class',
                  size: ButtonSize.medium,
                  onPressed: () => HapticUtils.mediumImpact(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 