import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mangaku/providers/searchProvider.dart';
import 'package:mangaku/themes/zenThemes.dart';
import 'package:mangaku/widgets/mangaCard.dart';
import 'package:mangaku/widgets/shimmerCard.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  final List<String> _trendingTags = [
    'Action',
    'Adventure',
    'Romance',
    'School Life',
    'Supernatural',
    'Fantasy',
  ];

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<SearchProvider>().searchManga(query);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZenTheme.background,
      appBar: AppBar(
        title: const Text('Search'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Smart Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: const TextStyle(color: ZenTheme.textPrimary),
              decoration: InputDecoration(
                hintText: 'Search manga, manhwa...',
                prefixIcon: const Icon(Icons.search, color: ZenTheme.primary),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: ZenTheme.textSecondary,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          context.read<SearchProvider>().searchManga('');
                          setState(() {});
                        },
                      )
                    : null,
                filled: true,
                fillColor: ZenTheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Search Content
          Expanded(
            child: Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
                if (_searchController.text.isEmpty) {
                  return _buildTrendingSection();
                }

                if (searchProvider.isLoading) {
                  return _buildLoadingGrid();
                }

                if (searchProvider.errorMessage.isNotEmpty) {
                  return Center(child: Text(searchProvider.errorMessage));
                }

                if (searchProvider.results.isEmpty) {
                  return const Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(color: ZenTheme.textSecondary),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: searchProvider.results.length,
                  itemBuilder: (context, index) {
                    final manga = searchProvider.results[index];
                    return MangaCard.search(manga);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Trending Tags',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ZenTheme.textPrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              spacing: 8,
              children: _trendingTags
                  .map(
                    (tag) => ActionChip(
                      label: Text(tag),
                      backgroundColor: ZenTheme.surface,
                      labelStyle: const TextStyle(color: ZenTheme.textPrimary),
                      onPressed: () {
                        _searchController.text = tag;
                        context.read<SearchProvider>().searchManga(tag);
                        setState(() {});
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => const ShimmerCard(),
    );
  }
}
