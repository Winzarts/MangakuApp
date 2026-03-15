import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import 'package:mangaku/database/Appdb.dart';
import 'package:provider/provider.dart';
import 'package:mangaku/providers/detailProvider.dart';
import 'package:mangaku/providers/activityProvider.dart';
import 'package:mangaku/themes/zenThemes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mangaku/screens/readScreen.dart';

class DetailScreen extends StatefulWidget {
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
      context.read<DetailProvider>().fetchMangaDetail(widget.slug);
      context.read<ActivityProvider>().loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZenTheme.background,
      body: Consumer<DetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.mangaDetail == null) {
            return const Center(child: CircularProgressIndicator());
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
                              ZenTheme.background.withOpacity(0.8),
                              ZenTheme.background,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Consumer<ActivityProvider>(
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
                                  ? ZenTheme.primary
                                  : Colors.white,
                            );
                          },
                        );
                      },
                    ),
                    onPressed: () async {
                      final activity = context.read<ActivityProvider>();
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
                          color: ZenTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        manga.indonesia_title,
                        style: const TextStyle(
                          fontSize: 16,
                          color: ZenTheme.textSecondary,
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
                                  border: Border.all(color: ZenTheme.primary),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  g,
                                  style: const TextStyle(
                                    color: ZenTheme.primary,
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
                          color: ZenTheme.textPrimary,
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
                              manga.sinopsis,
                              maxLines: _isSynopsisExpanded ? null : 4,
                              overflow: _isSynopsisExpanded
                                  ? null
                                  : TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: ZenTheme.textSecondary,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                            Text(
                              _isSynopsisExpanded ? 'Show less' : 'Read more',
                              style: const TextStyle(
                                color: ZenTheme.primary,
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
                          color: ZenTheme.textPrimary,
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
                  return Consumer<ActivityProvider>(
                    builder: (context, activity, child) {
                      final isRead = activity.history.any(
                        (h) =>
                            h.lastChapter == chapter.title &&
                            h.mangaSlug == widget.slug,
                      );
                      return ListTile(
                        title: Text(
                          chapter.title,
                          style: TextStyle(
                            color: isRead
                                ? ZenTheme.textSecondary
                                : ZenTheme.textPrimary,
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
}
