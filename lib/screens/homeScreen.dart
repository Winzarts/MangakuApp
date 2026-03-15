import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mangaku/providers/homeProvider.dart';
import 'package:mangaku/themes/zenThemes.dart';
import 'package:mangaku/widgets/mangaCard.dart';
import 'package:mangaku/widgets/shimmerCard.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().fetchPopularManga();
      context.read<HomeProvider>().fetchLatestManga();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          if (homeProvider.isLoading && homeProvider.popularManga.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (homeProvider.errorMessage.isNotEmpty &&
              homeProvider.popularManga.isEmpty) {
            return Center(child: Text(homeProvider.errorMessage));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await homeProvider.fetchPopularManga();
              await homeProvider.fetchLatestManga();
            },
            child: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  floating: true,
                  title: Text(
                    '📖 Mangaku 📖',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: ZenTheme.primary,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: ZenTheme.background,
                ),
                // Hero Banner
                SliverToBoxAdapter(child: _buildHeroBanner(homeProvider)),
                // Popular Section
                SliverToBoxAdapter(
                  child: _buildSectionHeader('Popular Now', () {}),
                ),
                SliverToBoxAdapter(
                  child: _buildHorizontalList(
                    homeProvider.popularManga,
                    (manga) => MangaCard.popular(manga as dynamic),
                    homeProvider.isLoading,
                  ),
                ),
                // Latest Updates
                SliverToBoxAdapter(
                  child: _buildSectionHeader('Latest Updates', () {}),
                ),
                SliverToBoxAdapter(
                  child: _buildHorizontalList(
                    homeProvider.latestManga,
                    (manga) => MangaCard.latest(manga as dynamic),
                    homeProvider.isLoading,
                  ),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroBanner(HomeProvider provider) {
    if (provider.popularManga.isEmpty) return const SizedBox.shrink();

    final featured = provider.popularManga.take(5).toList();

    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: PageView.builder(
        itemCount: featured.length,
        itemBuilder: (context, index) {
          final manga = featured[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: CachedNetworkImageProvider(manga.thumbnail),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ZenTheme.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'FEATURED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    manga.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    manga.genre,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ZenTheme.textPrimary,
            ),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: const Text(
              'See All',
              style: TextStyle(color: ZenTheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList(
    List<dynamic> items,
    Widget Function(dynamic) builder,
    bool isLoading,
  ) {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        cacheExtent: 320, // Prevents loading too many off-screen cards
        itemCount: isLoading ? 5 : items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          if (isLoading) {
            return const SizedBox(width: 160, child: ShimmerCard());
          }
          return SizedBox(width: 160, child: builder(items[index]));
        },
      ),
    );
  }
}
