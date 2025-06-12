import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../core/theme/app_theme.dart';

/// Trainer list screen showing available yoga instructors
class TrainerListScreen extends ConsumerWidget {
  const TrainerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Find Trainers'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Ionicons.filter_outline),
            onPressed: () {
              // TODO: Show filter options
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          itemCount: 6, // Mock data count
          itemBuilder: (context, index) {
            return _TrainerCard(
              name: 'Trainer ${index + 1}',
              specialization: ['Hatha Yoga', 'Vinyasa', 'Power Yoga'][index % 3],
              experience: '${(index + 1) * 2} years',
              rating: 4.5 + (index * 0.1),
              pricePerSession: 45 + (index * 5),
              imageUrl: 'https://via.placeholder.com/80x80',
              onTap: () {
                context.go('/trainers/${index + 1}');
              },
            );
          },
        ),
      ),
    );
  }
}

class _TrainerCard extends StatelessWidget {
  final String name;
  final String specialization;
  final String experience;
  final double rating;
  final int pricePerSession;
  final String imageUrl;
  final VoidCallback onTap;

  const _TrainerCard({
    required this.name,
    required this.specialization,
    required this.experience,
    required this.rating,
    required this.pricePerSession,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          child: Row(
            children: [
              // Trainer image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
                child: const Icon(
                  Ionicons.person,
                  color: AppTheme.primaryColor,
                  size: 40,
                ),
              ),
              
              const SizedBox(width: AppTheme.spacingM),
              
              // Trainer details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      specialization,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      experience,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingS),
                    Row(
                      children: [
                        Icon(
                          Ionicons.star,
                          size: 16,
                          color: AppTheme.warningColor,
                        ),
                        const SizedBox(width: AppTheme.spacingXS),
                        Text(
                          rating.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacingM),
                        Text(
                          '\$$pricePerSession/session',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Arrow icon
              Icon(
                Ionicons.chevron_forward,
                color: AppTheme.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 