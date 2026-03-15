import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mangaku/providers/activityProvider.dart';
import 'package:mangaku/themes/zenThemes.dart';
import 'package:mangaku/screens/detailScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActivityProvider>().loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ZenTheme.background,
        appBar: AppBar(
          title: const Text('Activity'),
          elevation: 0,
          backgroundColor: ZenTheme.background,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Bookmarks'),
              Tab(text: 'Reading History'),
            ],
            indicatorColor: ZenTheme.primary,
            labelColor: ZenTheme.primary,
            unselectedLabelColor: ZenTheme.textSecondary,
          ),
        ),
        body: TabBarView(children: [_buildBookmarksTab(), _buildHistoryTab()]),
      ),
    );
  }

  Widget _buildBookmarksTab() {
    return Consumer<ActivityProvider>(
      builder: (context, provider, child) {
        if (provider.bookmarks.isEmpty) {
          return const Center(
            child: Text(
              'No bookmarks yet',
              style: TextStyle(color: ZenTheme.textSecondary),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.bookmarks.length,
          itemBuilder: (context, index) {
            final bookmark = provider.bookmarks[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildActivityItem(
                title: bookmark.title,
                thumbnail: bookmark.thumbnail,
                subtitle:
                    'Bookmarked on ${DateFormat('dd MMM yyyy').format(bookmark.savedAt)}',
                trailing: IconButton(
                  icon: const Icon(Icons.bookmark, color: ZenTheme.primary),
                  onPressed: () => provider.removeBookmark(bookmark.slug),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(slug: bookmark.slug),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHistoryTab() {
    return Consumer<ActivityProvider>(
      builder: (context, provider, child) {
        if (provider.history.isEmpty) {
          return const Center(
            child: Text(
              'No history available',
              style: TextStyle(color: ZenTheme.textSecondary),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.history.length,
          itemBuilder: (context, index) {
            final item = provider.history[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildActivityItem(
                title: item.title,
                thumbnail: item.thumbnail,
                subtitle: 'Last read: ${item.lastChapter}',
                trailing: Text(
                  DateFormat('HH:mm').format(item.readAt),
                  style: const TextStyle(
                    color: ZenTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(slug: item.mangaSlug),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildActivityItem({
    required String title,
    required String thumbnail,
    required String subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ZenTheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: thumbnail,
                width: 60,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ZenTheme.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: ZenTheme.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}
