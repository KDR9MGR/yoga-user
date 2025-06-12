import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/enhanced_button.dart';
import '../../../core/utils/haptic_utils.dart';

/// Help and support screen
class HelpSupportScreen extends ConsumerWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: AppTheme.surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back),
          onPressed: () {
            HapticUtils.lightImpact();
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: AppTheme.spacingL),
            _buildQuickActions(context),
            const SizedBox(height: AppTheme.spacingL),
            _buildFAQ(context),
            const SizedBox(height: AppTheme.spacingL),
            _buildContactSupport(context),
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
              Ionicons.help_circle,
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
                  'We\'re Here to Help',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  'Find answers or get in touch with our support team',
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

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: AppTheme.spacingM,
          mainAxisSpacing: AppTheme.spacingM,
          childAspectRatio: 1.2,
          children: [
            _buildQuickActionCard(
              context,
              icon: Ionicons.chatbubble,
              title: 'Live Chat',
              subtitle: 'Chat with support',
              onTap: () => _showLiveChat(context),
            ),
            _buildQuickActionCard(
              context,
              icon: Ionicons.mail,
              title: 'Email Us',
              subtitle: 'Send an email',
              onTap: () => _showEmailForm(context),
            ),
            _buildQuickActionCard(
              context,
              icon: Ionicons.call,
              title: 'Call Support',
              subtitle: '+1 (555) 123-4567',
              onTap: () => _makePhoneCall(context),
            ),
            _buildQuickActionCard(
              context,
              icon: Ionicons.document_text,
              title: 'User Guide',
              subtitle: 'Getting started',
              onTap: () => _showUserGuide(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticUtils.lightImpact();
        onTap();
      },
      child: Container(
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
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(AppTheme.radiusL),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: AppTheme.spacingM),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildFAQ(BuildContext context) {
    final faqs = [
      {
        'question': 'How do I book a yoga class?',
        'answer': 'You can book a class by browsing our trainers, selecting a time slot that works for you, and confirming your booking. You\'ll receive a confirmation email with the class details.',
      },
      {
        'question': 'Can I cancel a booked class?',
        'answer': 'Yes, you can cancel a class up to 2 hours before the scheduled time. Go to your profile, find the booked class, and select cancel.',
      },
      {
        'question': 'How do I access my diet plan?',
        'answer': 'Your personalized diet plan is available in the Diet Plans section. You can view weekly menus, nutrition tips, and track your progress.',
      },
      {
        'question': 'What if I have technical issues during a live class?',
        'answer': 'If you experience technical difficulties, try refreshing the app or checking your internet connection. You can also contact support for immediate assistance.',
      },
      {
        'question': 'How do I update my profile information?',
        'answer': 'Go to your profile, tap Edit Profile, and update your information. Don\'t forget to save your changes.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Frequently Asked Questions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        ...faqs.map((faq) => _buildFAQCard(context, faq)),
      ],
    );
  }

  Widget _buildFAQCard(BuildContext context, Map<String, String> faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        border: Border.all(
          color: AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: ExpansionTile(
        title: Text(
          faq['question']!,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppTheme.spacingL,
              0,
              AppTheme.spacingL,
              AppTheme.spacingL,
            ),
            child: Text(
              faq['answer']!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSupport(BuildContext context) {
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
                Ionicons.headset,
                color: AppTheme.primaryColor,
                size: 24,
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(
                'Still Need Help?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'Our support team is available 24/7 to help you with any questions or issues you may have.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          SizedBox(
            width: double.infinity,
            child: EnhancedButton(
              text: 'Contact Support',
              variant: ButtonVariant.primary,
              size: ButtonSize.large,
              onPressed: () {
                HapticUtils.mediumImpact();
                _showContactOptions(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods for actions
  void _showLiveChat(BuildContext context) {
    // Implement live chat functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Live chat will be available soon!')),
    );
  }

  void _showEmailForm(BuildContext context) {
    // Implement email form
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email form will be available soon!')),
    );
  }

  void _makePhoneCall(BuildContext context) {
    // Implement phone call functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Phone call feature will be available soon!')),
    );
  }

  void _showUserGuide(BuildContext context) {
    // Implement user guide
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User guide will be available soon!')),
    );
  }

  void _showContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Contact Support',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingL),
            ListTile(
              leading: Icon(Ionicons.mail, color: AppTheme.primaryColor),
              title: const Text('Email'),
              subtitle: const Text('support@yogaapp.com'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Ionicons.call, color: AppTheme.primaryColor),
              title: const Text('Phone'),
              subtitle: const Text('+1 (555) 123-4567'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Ionicons.chatbubble, color: AppTheme.primaryColor),
              title: const Text('Live Chat'),
              subtitle: const Text('Available 24/7'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
} 