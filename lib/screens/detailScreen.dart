import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import 'package:mangaku/databases/appDB.dart';
import 'package:provider/provider.dart';
import 'package:mangaku/providers/detailProvider.dart';
import 'package:mangaku/providers/activityProviders.dart';
import 'package:mangaku/themes/app_colors.dart';
import 'package:mangaku/themes/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mangaku/screens/readScreen.dart';
import 'package:shimmer/shimmer.dart';

class DetailScreen extends StatefulWidget {

  static const routename = "/detail-screen";

  final String slug;
  const DetailScreen({super.key, required this.slug});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isSynopsisExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Detailprovider>().fetchMangaDetail(widget.slug);
      context.read<Activityproviders>().loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      body: Consumer<Detailprovider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.mangaDetail == null) {
            return _buildShimmer();
          }

          final manga = provider.mangaDetail;
          if (manga == null) {
            return Center(
              child: Text(
                provider.errorMessage.isEmpty
                    ? 'Manga not found'
                    : provider.errorMessage,
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              // Full-bleed Cover Art
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: manga.image_url,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppTheme.darkTheme.scaffoldBackgroundColor.withOpacity(0.8),
                              AppTheme.darkTheme.scaffoldBackgroundColor,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Consumer<Activityproviders>(
                      builder: (context, activity, _) {
                        return FutureBuilder<bool>(
                          future: activity.isBookmarked(widget.slug),
                          builder: (context, snapshot) {
                            final isBookmarked = snapshot.data ?? false;
                            return Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: isBookmarked
                                  ? AppColors.darkAccent
                                  : Colors.white,
                            );
                          },
                        );
                      },
                    ),
                    onPressed: () async {
                      final activity = context.read<Activityproviders>();
                      if (await activity.isBookmarked(widget.slug)) {
                        await activity.removeBookmark(widget.slug);
                      } else {
                        await activity.addBookmark(
                          BookmarksCompanion(
                            slug: Value(widget.slug),
                            title: Value(manga.title),
                            url: Value(manga.image_url), // Required field, using image_url as placeholder or link
                            thumbnail: Value(manga.image_url),
                            type: Value(
                              'Manga',
                            ), // Default since DetailMangaModel lacks type
                            genre: Value(manga.genres.join(', ')),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),

              // Title and Info
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        manga.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (manga.indonesia_title != null)
                        Text(
                          manga.indonesia_title!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.darkTextSecondary,
                          ),
                        ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: manga.genres
                            .map(
                              (g) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.darkAccent),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  g,
                                  style: TextStyle(
                                    color: AppColors.darkAccent,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 20),

                      // Dynamic Synopsis
                      const Text(
                        'Synopsis',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkTextPrimary
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => setState(
                          () => _isSynopsisExpanded = !_isSynopsisExpanded,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              manga.sinopsis ?? 'No synopsis available',
                              maxLines: _isSynopsisExpanded ? null : 4,
                              overflow: _isSynopsisExpanded
                                  ? null
                                  : TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.darkTextSecondary,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                            Text(
                              _isSynopsisExpanded ? 'Show less' : 'Read more',
                              style: TextStyle(
                                color: AppColors.darkAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Chapters (${manga.chapters.length})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkTextPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Chapter List
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final chapter = manga.chapters[index];
                  return Consumer<Activityproviders>(
                    builder: (context, activity, child) {
                      final isRead = activity.histories.any(
                        (h) =>
                            h.lastChapter == chapter.title &&
                            h.mangaSlug == widget.slug,
                      );
                      return ListTile(
                        title: Text(
                          chapter.title,
                          style: TextStyle(
                            color: isRead
                                ? AppColors.darkTextSecondary
                                : AppColors.darkTextPrimary,
                          ),
                        ),
                        subtitle: Text(
                          chapter.date,
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: isRead
                            ? const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 20,
                              )
                            : const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReadScreen(
                                mangaSlug: widget.slug,
                                chapterSlug: chapter.slug,
                                chapters: manga.chapters,
                                mangaThumbnail: manga.image_url,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }, childCount: manga.chapters.length),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildShimmer() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 400,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Shimmer.fromColors(
              baseColor: Colors.grey[800]!,
              highlightColor: Colors.grey[700]!,
              child: Container(color: Colors.black),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(width: 250, height: 28),
                const SizedBox(height: 12),
                _shimmerBox(width: 180, height: 20),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  children: List.generate(
                    3,
                    (index) => _shimmerBox(width: 60, height: 24, borderRadius: 20),
                  ),
                ),
                const SizedBox(height: 24),
                _shimmerBox(width: 100, height: 22),
                const SizedBox(height: 12),
                _shimmerBox(width: double.infinity, height: 14),
                const SizedBox(height: 8),
                _shimmerBox(width: double.infinity, height: 14),
                const SizedBox(height: 8),
                _shimmerBox(width: 200, height: 14),
                const SizedBox(height: 24),
                _shimmerBox(width: 120, height: 22),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimmerBox(width: 150, height: 16),
                        const SizedBox(height: 4),
                        _shimmerBox(width: 80, height: 12),
                      ],
                    ),
                  ),
                  _shimmerBox(width: 24, height: 24, borderRadius: 12),
                ],
              ),
            ),
            childCount: 10,
          ),
        ),
      ],
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    double borderRadius = 4,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}