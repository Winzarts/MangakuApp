import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangaku/providers/libraryProvider.dart';
import 'package:mangaku/themes/app_colors.dart';
import 'package:mangaku/themes/app_theme.dart';
import 'package:mangaku/widgets/MangaCard.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  static const routename = "/library-screen";

  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(() {
      context.read<LibraryProvider>().fetchLibrary(reset: true);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      context.read<LibraryProvider>().fetchLibraryMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Library',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: () => Navigator.pushNamed(context, "/search-screen"),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 28),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildTabs(),
          _buildFilters(),
          Expanded(
            child: Consumer<LibraryProvider>(
              builder: (context, libProvider, child) {
                if (libProvider.isLoading && libProvider.mangaList.isEmpty) {
                  return _buildShimmerGrid();
                }

                final list = libProvider.mangaList;

                return GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: libProvider.isGridView ? 2 : 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 20,
                    childAspectRatio: libProvider.isGridView ? 0.53 : 2.5,
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final manga = list[index];
                    return MangaCard.library(manga);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Consumer<LibraryProvider>(
      builder: (context, provider, child) {
        final tabs = ['All', 'Manga', 'Manhwa', 'Manhua'];
        return Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: tabs.map((tab) {
              final isSelected = provider.selectedTab == tab;
              return GestureDetector(
                onTap: () {
                  provider.setSelectedTab(tab);
                  // Map tab to LibraryType
                  LibraryType type = LibraryType.all;
                  if (tab == 'Manga') type = LibraryType.manga;
                  if (tab == 'Manhwa') type = LibraryType.manhwa;
                  if (tab == 'Manhua') type = LibraryType.manhua;
                  provider.setType(type);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tab,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? Colors.blueAccent : Colors.white60,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (isSelected)
                      Container(
                        height: 2,
                        width: 24,
                        color: Colors.blueAccent,
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildFilters() {
    return Consumer<LibraryProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              _buildDropdown(
                icon: Icons.sort_by_alpha,
                label: 'A-Z',
                onTap: () {},
              ),
              const SizedBox(width: 12),
              _buildDropdown(
                icon: Icons.access_time,
                label: 'Latest',
                onTap: () {},
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.grid_view_rounded,
                      color: provider.isGridView ? Colors.blueAccent : Colors.white24,
                      size: 22,
                    ),
                    onPressed: () { if (!provider.isGridView) provider.toggleView(); },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.view_list_rounded,
                      color: !provider.isGridView ? Colors.blueAccent : Colors.white24,
                      size: 24,
                    ),
                    onPressed: () { if (provider.isGridView) provider.toggleView(); },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDropdown({required IconData icon, required String label, required VoidCallback onTap}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.darkSurfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, color: Colors.white38, size: 16),
        ],
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
        childAspectRatio: 0.53,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => MangaCard.shimmer(),
    );
  }
}
