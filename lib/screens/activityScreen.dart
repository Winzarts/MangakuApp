import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangaku/providers/activityProviders.dart';
import 'package:mangaku/themes/app_colors.dart';
import 'package:mangaku/themes/app_theme.dart';
import 'package:mangaku/screens/detailScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ActivityScreen extends StatefulWidget {
  static const routename = "/activity-screen";

  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<Activityproviders>().loadAll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            'Activity',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.darkAccent,
            ),
          ),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Bookmarks'),
              Tab(text: 'History'),
            ],
            indicatorColor: AppColors.darkAccent,
            labelColor: AppColors.darkTextPrimary,
            unselectedLabelColor: AppColors.darkTextSecondary,
            labelStyle: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        body: TabBarView(children: [_buildBookmarksTab(), _buildHistoryTab()]),
      ),
    );
  }

  Widget _buildBookmarksTab() {
    return Consumer<Activityproviders>(
      builder: (context, provider, child) {
        if (provider.bookmarks.isEmpty) {
          return _buildEmptyState('No bookmarks yet');
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
                slug: bookmark.slug,
                subtitle:
                    'Bookmarked on ${DateFormat('dd MMM yyyy').format(bookmark.savedAt)}',
                trailing: IconButton(
                  icon: const Icon(Icons.bookmark, color: AppColors.darkAccent),
                  onPressed: () => provider.removeBookmark(bookmark.slug),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHistoryTab() {
    return Consumer<Activityproviders>(
      builder: (context, provider, child) {
        if (provider.histories.isEmpty) {
          return _buildEmptyState('No history available');
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.histories.length,
          itemBuilder: (context, index) {
            final item = provider.histories[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildActivityItem(
                title: item.title,
                thumbnail: item.thumbnail,
                slug: item.mangaSlug,
                subtitle: 'Last read: ${item.lastChapter}',
                trailing: Text(
                  DateFormat('HH:mm').format(item.readAt),
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.darkTextSecondary,
                    fontSize: 12,
                  ),
                ),
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
    required String slug,
    required String subtitle,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(slug: slug),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.darkSurfaceVariant,
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
                errorWidget: (context, url, error) => Container(
                  width: 60,
                  height: 80,
                  color: AppColors.darkSurfaceVariant,
                  child: const Icon(Icons.error, color: Colors.white24),
                ),
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
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextPrimary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.darkTextSecondary,
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

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.history_toggle_off, size: 64, color: Colors.white12),
          const SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.plusJakartaSans(color: AppColors.darkTextSecondary),
          ),
        ],
      ),
    );
  }
}