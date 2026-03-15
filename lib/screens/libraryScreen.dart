import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mangaku/providers/libraryProvider.dart';
import 'package:mangaku/themes/zenThemes.dart';
import 'package:mangaku/widgets/mangaCard.dart';
import 'package:mangaku/widgets/shimmerCard.dart';
import 'package:mangaku/models/popularModel.dart';
import 'package:mangaku/models/latestModel.dart';
import 'package:mangaku/models/listModel.dart';
import 'package:mangaku/models/genresModel.dart';

class LibraryScreen extends StatefulWidget {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LibraryProvider>().fetchGenres();
      context.read<LibraryProvider>().fetchLibrary();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<LibraryProvider>().fetchLibrary(isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZenTheme.background,
      appBar: AppBar(
        title: const Text('Library'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: Consumer<LibraryProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              _buildTypeTabs(provider),
              Expanded(
                child: provider.isLoading && provider.mangas.isEmpty
                    ? _buildLoadingGrid()
                    : provider.errorMessage.isNotEmpty
                    ? Center(child: Text(provider.errorMessage))
                    : _buildMangaGrid(provider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTypeTabs(LibraryProvider provider) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: LibraryType.values.map((type) {
          final isSelected = provider.selectedType == type;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(type.name.toUpperCase()),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) provider.setType(type);
              },
              selectedColor: ZenTheme.primary,
              backgroundColor: ZenTheme.surface,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : ZenTheme.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMangaGrid(LibraryProvider provider) {
    if (provider.mangas.isEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(color: ZenTheme.textSecondary),
        ),
      );
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: provider.mangas.length + (provider.hasMore ? 2 : 0),
      itemBuilder: (context, index) {
        if (index >= provider.mangas.length) {
          return const ShimmerCard();
        }
        final manga = provider.mangas[index];
        if (manga is PopularModel) return MangaCard.popular(manga);
        if (manga is LatestModel) return MangaCard.latest(manga);
        if (manga is ListMangaModel) return MangaCard.listManga(manga);
        if (manga is ByGenreModel) return MangaCard.byGenre(manga);
        return const SizedBox.shrink();
      },
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

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ZenTheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Consumer<LibraryProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sort By',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ZenTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: LibrarySort.values.map((sort) {
                      final isSelected = provider.selectedSort == sort;
                      return ChoiceChip(
                        label: Text(sort.name.toUpperCase()),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) provider.setSort(sort);
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Genres',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ZenTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 150,
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8,
                        children: provider.genres.map((genre) {
                          final isSelected = provider.selectedGenre == genre;
                          return ChoiceChip(
                            label: Text(genre.genre),
                            selected: isSelected,
                            onSelected: (selected) {
                              provider.setGenre(selected ? genre : null);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
