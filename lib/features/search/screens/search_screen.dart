import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

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
        title: const Text('Search'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search classes, trainers, or styles...',
                  prefixIcon: const Icon(Ionicons.search_outline),
                  suffixIcon: IconButton(
                    icon: const Icon(Ionicons.options_outline),
                    onPressed: () {
                      // TODO: Show filters
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              
              const SizedBox(height: AppTheme.spacingL),
              
              // Categories
              Text(
                'Categories',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingM),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
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
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        backgroundColor: AppTheme.surfaceColor,
                        selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                        checkmarkColor: AppTheme.primaryColor,
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
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        Wrap(
          spacing: AppTheme.spacingS,
          runSpacing: AppTheme.spacingS,
          children: [
            'Morning Yoga',
            'Power Yoga',
            'Beginner Classes',
            'Meditation',
            'Flexibility',
            'Core Strength',
          ].map((search) {
            return ActionChip(
              label: Text(search),
              onPressed: () {
                _searchController.text = search;
                setState(() {});
              },
              backgroundColor: AppTheme.surfaceColor,
            );
          }).toList(),
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
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        Expanded(
          child: ListView.builder(
            itemCount: 5, // Mock results
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: const Icon(
                      Ionicons.fitness,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  title: Text('Yoga Class ${index + 1}'),
                  subtitle: const Text('Instructor Name • 60 min'),
                  trailing: const Icon(Ionicons.chevron_forward),
                  onTap: () {
                    // TODO: Navigate to details
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
} 