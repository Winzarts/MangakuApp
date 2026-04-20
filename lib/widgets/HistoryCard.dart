import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mangaku/databases/appDB.dart';
import 'package:mangaku/providers/activityProviders.dart';
import 'package:mangaku/themes/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:mangaku/screens/detailScreen.dart';
import 'package:drift/drift.dart' show Value;

class HistoryCard extends StatelessWidget {
  final int index;
  final History history;

  const HistoryCard({
    super.key,
    required this.index,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Activityproviders>(
      builder: (context, activity, child) {
        // Use FutureBuilder or check the local list
        // Since loadAll() is called in initState, we can check activity.bookmarks
        final isBookmarked = activity.bookmarks.any((b) => b.slug == history.mangaSlug);

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(slug: history.mangaSlug),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                // Index number
                Text(
                  (index + 1).toString().padLeft(2, '0'),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextSecondary.withOpacity(0.3),
                  ),
                ),
                const SizedBox(width: 16),
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: history.thumbnail,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        history.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${history.genre} • ${history.lastChapter}",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: AppColors.darkTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Bookmark button
                GestureDetector(
                  onTap: () async {
                    if (isBookmarked) {
                      await activity.removeBookmark(history.mangaSlug);
                    } else {
                      await activity.addBookmark(
                        BookmarksCompanion(
                          slug: Value(history.mangaSlug),
                          title: Value(history.title),
                          url: Value(history.url),
                          thumbnail: Value(history.thumbnail),
                          type: Value(history.type),
                          genre: Value(history.genre),
                        ),
                      );
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isBookmarked ? AppColors.darkAccent : Colors.transparent,
                      shape: BoxShape.circle,
                      border: isBookmarked 
                        ? null 
                        : Border.all(color: AppColors.darkAccent, width: 2),
                    ),
                    child: Icon(
                      isBookmarked ? Icons.check : Icons.add,
                      size: 20,
                      color: isBookmarked ? AppColors.darkBackground : AppColors.darkAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
