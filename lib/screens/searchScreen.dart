import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangaku/providers/searchProvider.dart';
import 'package:mangaku/themes/app_colors.dart';
import 'package:mangaku/themes/app_theme.dart';
import 'package:mangaku/widgets/MangaCard.dart';
import 'package:mangaku/providers/libraryProvider.dart';
import 'package:mangaku/models/genreModel.dart';
import 'package:provider/provider.dart';

class Searchscreen extends StatefulWidget {

  static const routename = "/search-screen";

  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  final List<Map<String, dynamic>> _genres = [
    {
      'name': 'Action',
      'slug': 'action',
      'icon': Icons.bolt,
      'colors': [const Color(0xFFE52D27), const Color(0xFFB31217)],
    },
    {
      'name': 'Fantasy',
      'slug': 'fantasy',
      'icon': Icons.auto_fix_high,
      'colors': [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)],
    },
    {
      'name': 'Comedy',
      'slug': 'comedy',
      'icon': Icons.sentiment_very_satisfied,
      'colors': [const Color(0xFFF2994A), const Color(0xFFF2C94C)],
    },
    {
      'name': 'Romance',
      'slug': 'romance',
      'icon': Icons.favorite,
      'colors': [const Color(0xFFF06292), const Color(0xFFE91E63)],
    },
    {
      'name': 'Sci-Fi',
      'slug': 'sci-fi',
      'icon': Icons.rocket_launch,
      'colors': [const Color(0xFF2196F3), const Color(0xFF21CBF3)],
    },
    {
      'name': 'Horror',
      'slug': 'horror',
      'icon': Icons.nightlight,
      'colors': [const Color(0xFF2C3E50), const Color(0xFF000000)],
    },
  ];

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
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
    final searchProvider = context.watch<SearchProvider>();

    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Explore More',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search manga...",
                  hintStyle: const TextStyle(color: Colors.white38),
                  prefixIcon: const Icon(Icons.search, color: Colors.white38),
                  filled: true,
                  fillColor: AppColors.darkSurfaceVariant,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: searchProvider.results.isNotEmpty
                    ? _buildSearchResults(searchProvider)
                    : Column(
                        children: [
                          _buildGenreSection(),
                          _buildRecentSearches(searchProvider),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(SearchProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
          childAspectRatio: 0.20,
        ),
        itemCount: provider.results.length,
        itemBuilder: (context, index) {
          return MangaCard.search(provider.results[index]);
        },
      ),
    );
  }

  Widget _buildGenreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Browse by Genre',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextPrimary,
                ),
              ),
              TextButton(
                onPressed: () {
                   Navigator.pushNamed(context, "/library-screen");
                },
                child: Text(
                  'See All',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _genres.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              final genre = _genres[index];
              return _buildGenreCard(genre);
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildRecentSearches(SearchProvider provider) {
    if (provider.recentSearches.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextPrimary,
                ),
              ),
              TextButton(
                onPressed: () {
                  provider.clearRecentSearches();
                },
                child: Text(
                  'Clear',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.recentSearches.length,
          itemBuilder: (context, index) {
            final query = provider.recentSearches[index];
            return ListTile(
              leading: const Icon(Icons.history, color: AppColors.darkTextSecondary),
              title: Text(
                query,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  color: AppColors.darkTextPrimary,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.close, color: AppColors.darkTextSecondary, size: 20),
                onPressed: () {
                  provider.removeRecentSearch(query);
                },
              ),
              onTap: () {
                _searchController.text = query;
                provider.searchManga(query);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildGenreCard(Map<String, dynamic> genre) {
    return InkWell(
      onTap: () {
        final libProvider = context.read<LibraryProvider>();
        libProvider.setGenre(GenresModel(
          genre: genre['name'],
          url: '/genre/${genre['slug']}/',
        ));
        Navigator.pushNamed(context, "/library-screen");
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: genre['colors'],
          ),
          boxShadow: [
            BoxShadow(
              color: (genre['colors'][0] as Color).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              genre['icon'] as IconData? ?? Icons.category,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              genre['name'],
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
