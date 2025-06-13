import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../core/theme/app_theme.dart';

/// Search screen for finding classes and trainers
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.backgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(AppTheme.radiusL),
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search classes, trainers, or styles...',
                    hintStyle: TextStyle(
                      color: AppTheme.textSecondary.withOpacity(0.5),
                    ),
                    prefixIcon: Icon(
                      Ionicons.search_outline,
                      color: AppTheme.primaryColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Ionicons.options_outline,
                        color: AppTheme.primaryColor,
                      ),
                      onPressed: () {
                        // TODO: Show filters
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingM,
                      vertical: AppTheme.spacingM,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingL),
              
              // Categories
              Text(
                'Categories',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingM),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    'All',
                    'Hatha Yoga',
                    'Vinyasa',
                    'Power Yoga',
                    'Restorative',
                    'Meditation',
                  ].map((category) {
                    final isSelected = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: AppTheme.spacingS),
                      child: FilterChip(
                        label: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        backgroundColor: AppTheme.surfaceColor,
                        selectedColor: AppTheme.primaryColor.withOpacity(0.15),
                        checkmarkColor: AppTheme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusL),
                          side: BorderSide(
                            color: isSelected 
                              ? AppTheme.primaryColor 
                              : AppTheme.primaryColor.withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingM,
                          vertical: AppTheme.spacingS,
                        ),
                        showCheckmark: false,
                      ),
                    );
                  }).toList(),
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingL),
              
              // Results section
              Expanded(
                child: _searchController.text.isEmpty
                    ? _buildRecentSearches()
                    : _buildSearchResults(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Searches',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        AnimationLimiter(
          child: Wrap(
            spacing: AppTheme.spacingS,
            runSpacing: AppTheme.spacingS,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                'Morning Yoga',
                'Power Yoga',
                'Beginner Classes',
                'Meditation',
                'Flexibility',
                'Core Strength',
              ].map((search) {
                return ActionChip(
                  label: Text(
                    search,
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  onPressed: () {
                    _searchController.text = search;
                    setState(() {});
                  },
                  backgroundColor: AppTheme.surfaceColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusL),
                    side: BorderSide(
                      color: AppTheme.primaryColor.withOpacity(0.15),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingM,
                    vertical: AppTheme.spacingS,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Results',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        Expanded(
          child: AnimationLimiter(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 5, // Mock results
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Card(
                        margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusL),
                          side: BorderSide(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        elevation: 0,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(AppTheme.spacingM),
                          leading: Container(
                            padding: const EdgeInsets.all(AppTheme.spacingM),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radiusL),
                            ),
                            child: Icon(
                              Ionicons.fitness,
                              color: AppTheme.primaryColor,
                              size: 24,
                            ),
                          ),
                          title: Text(
                            'Yoga Class ${index + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: AppTheme.spacingXS),
                            child: Text(
                              'Instructor Name • 60 min',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.all(AppTheme.spacingS),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radiusM),
                            ),
                            child: Icon(
                              Ionicons.chevron_forward,
                              color: AppTheme.primaryColor,
                              size: 18,
                            ),
                          ),
                          onTap: () {
                            // TODO: Navigate to details
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
} 