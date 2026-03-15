import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mangaku/providers/readProvider.dart';
import 'package:mangaku/themes/zenThemes.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:mangaku/providers/activityProvider.dart';
import 'package:mangaku/database/Appdb.dart';
import 'package:drift/drift.dart' show Value;
import 'package:mangaku/models/mangaModel.dart';

class ReadScreen extends StatefulWidget {
  final String mangaSlug;
  final String chapterSlug;
  final List<ChapterModel> chapters;
  final String mangaThumbnail;

  const ReadScreen({
    super.key,
    required this.mangaSlug,
    required this.chapterSlug,
    required this.chapters,
    required this.mangaThumbnail,
  });

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  bool _showControls = true;
  late String _currentChapterSlug;

  @override
  void initState() {
    super.initState();
    _currentChapterSlug = widget.chapterSlug;
    // Enter Fullscreen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadChapter(_currentChapterSlug);
    });
  }

  void _loadChapter(String slug) async {
    final readerProvider = context.read<ReaderProvider>();
    await readerProvider.fetchChapters(widget.mangaSlug, slug);

    if (mounted && readerProvider.chapterContent != null) {
      final content = readerProvider.chapterContent!;
      final activityProvider = context.read<ActivityProvider>();

      // Get the chapter model from current list
      final chapter = widget.chapters.firstWhere(
        (c) => c.slug == slug,
        orElse: () => ChapterModel(
          title: content.title,
          url: '',
          slug: slug,
          views: '',
          date: '',
        ),
      );

      await activityProvider.upsertHistory(
        ReadingHistoryCompanion(
          title: Value(content.title),
          mangaSlug: Value(widget.mangaSlug),
          chapterSlug: Value(slug),
          lastChapter: Value(chapter.title),
          thumbnail: Value(widget.mangaThumbnail),
          url: Value(''), // Placeholder
          type: Value('Manga'),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Exit Fullscreen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Reader Content
          GestureDetector(
            onTap: _toggleControls,
            child: Consumer<ReaderProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final content = provider.chapterContent;
                if (content == null) {
                  return Center(
                    child: Text(
                      provider.errorMessage,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }

                if (provider.readingMode == ReadingMode.vertical) {
                  return ListView.builder(
                    itemCount: content.images.length,
                    cacheExtent: 500, // Reduced cache to save data quota
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: content.images[index],
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) => const SizedBox(
                          height: 300,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    },
                  );
                } else {
                  return PageView.builder(
                    itemCount: content.images.length,
                    itemBuilder: (context, index) {
                      return InteractiveViewer(
                        child: CachedNetworkImage(
                          imageUrl: content.images[index],
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),

          // Controls Overlay
          if (_showControls) ...[_buildTopBar(), _buildFloatingBottomBar()],
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Consumer<ReaderProvider>(
        builder: (context, provider, child) {
          final content = provider.chapterContent;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      content?.title ?? 'Loading...',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: ZenTheme.background,
                        builder: (context) => _buildSettingsSheet(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingsSheet() {
    return Consumer<ReaderProvider>(
      builder: (context, provider, _) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reading Mode',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.view_day, color: Colors.white),
              title: const Text(
                'Vertical',
                style: TextStyle(color: Colors.white),
              ),
              trailing: provider.readingMode == ReadingMode.vertical
                  ? const Icon(Icons.check, color: ZenTheme.primary)
                  : null,
              onTap: () {
                provider.setReadingMode(ReadingMode.vertical);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_carousel, color: Colors.white),
              title: const Text(
                'Horizontal',
                style: TextStyle(color: Colors.white),
              ),
              trailing: provider.readingMode == ReadingMode.horizontal
                  ? const Icon(Icons.check, color: ZenTheme.primary)
                  : null,
              onTap: () {
                provider.setReadingMode(ReadingMode.horizontal);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingBottomBar() {
    final int currentIndex = widget.chapters.indexWhere(
      (c) => c.slug == _currentChapterSlug,
    );
    final bool hasPrev = currentIndex < widget.chapters.length - 1;
    final bool hasNext = currentIndex > 0;

    return Positioned(
      bottom: 24,
      left: 24,
      right: 24,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white10, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Skip to START (Awal Chapter - biasanya index paling besar di API ini)
            _buildNavButton(
              icon: Icons.first_page,
              onPressed: currentIndex == widget.chapters.length - 1
                  ? null
                  : () => _navigateToChapter(widget.chapters.last.slug),
              label: 'Ke Awal',
            ),
            // PREVIOUS Chapter
            _buildNavButton(
              icon: Icons.chevron_left,
              onPressed: !hasPrev
                  ? null
                  : () => _navigateToChapter(
                      widget.chapters[currentIndex + 1].slug,
                    ),
              label: 'Sebelumnya',
            ),
            // DOWNLOAD
            _buildNavButton(
              icon: Icons.download,
              color: ZenTheme.primary,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Download dimulai...')),
                );
              },
              label: 'Download',
            ),
            // NEXT Chapter
            _buildNavButton(
              icon: Icons.chevron_right,
              onPressed: !hasNext
                  ? null
                  : () => _navigateToChapter(
                      widget.chapters[currentIndex - 1].slug,
                    ),
              label: 'Selanjutnya',
            ),
            // Skip to END (Akhir Chapter - biasanya index 0)
            _buildNavButton(
              icon: Icons.last_page,
              onPressed: currentIndex == 0
                  ? null
                  : () => _navigateToChapter(widget.chapters.first.slug),
              label: 'Ke Akhir',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback? onPressed,
    String? label,
    Color color = Colors.white,
  }) {
    return IconButton(
      icon: Icon(icon, color: onPressed == null ? Colors.white24 : color),
      onPressed: onPressed,
      tooltip: label,
    );
  }

  void _navigateToChapter(String slug) {
    setState(() {
      _currentChapterSlug = slug;
    });
    _loadChapter(slug);
  }
}
