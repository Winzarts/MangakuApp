import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangaku/models/popularModel.dart';
import 'package:mangaku/models/latestModel.dart';
import 'package:mangaku/models/listModel.dart';
import 'package:mangaku/models/genreModel.dart';
import 'package:mangaku/models/searchModel.dart';
import 'package:mangaku/screens/detailScreen.dart';
import 'package:mangaku/themes/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class MangaCard extends StatelessWidget {
  final String title;
  final String thumbnail;
  final String slug;
  final String? type;
  final String? status;
  final String? subtitle;

  final double? progress; // 0.0 to 1.0

  const MangaCard({
    super.key,
    required this.title,
    required this.thumbnail,
    required this.slug,
    this.type,
    this.status,
    this.subtitle,
    this.progress,
  });

  factory MangaCard.library(dynamic manga, {double? progress}) {
    if (manga is ListMangaModel) {
      final slug = Uri.parse(manga.url).pathSegments.lastWhere((s) => s.isNotEmpty, orElse: () => '');
      return MangaCard(
        title: manga.title,
        thumbnail: manga.thumbnail,
        slug: slug,
        type: manga.type,
        subtitle: manga.status.isNotEmpty ? manga.status : manga.type,
        progress: progress,
      );
    }
    // Handle other types if needed
    return MangaCard(
      title: manga.title ?? '',
      thumbnail: manga.thumbnail ?? '',
      slug: manga.slug ?? '',
      type: manga.type,
      progress: progress,
    );
  }

  factory MangaCard.popular(PopularModel manga) {
    return MangaCard(
      title: manga.title,
      thumbnail: manga.thumbnail,
      slug: manga.slug,
      type: manga.type,
      subtitle: manga.genre,
    );
  }

  factory MangaCard.latest(LatestModel manga) {
    return MangaCard(
      title: manga.title,
      thumbnail: manga.thumbnail,
      slug: manga.slug,
      type: manga.type,
      subtitle: manga.genre,
    );
  }

  factory MangaCard.listManga(ListMangaModel manga) {
    final slug = Uri.parse(manga.url).pathSegments.lastWhere((s) => s.isNotEmpty, orElse: () => '');
    return MangaCard(
      title: manga.title,
      thumbnail: manga.thumbnail,
      slug: slug,
      type: manga.type,
      status: manga.status,
      subtitle: manga.type,
    );
  }

  factory MangaCard.byGenre(ByGenreModel manga) {
    return MangaCard(
      title: manga.title,
      thumbnail: manga.thumbnail,
      slug: manga.slug,
      type: manga.type,
      subtitle: manga.genre,
    );
  }

  factory MangaCard.search(ResultsModel manga) {
    return MangaCard(
      title: manga.title,
      thumbnail: manga.thumbnail,
      slug: manga.slug,
      type: manga.type,
      subtitle: manga.type,
    );
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(slug: slug)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Badge
          AspectRatio(
            aspectRatio: 3 / 4.2,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: thumbnail,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[800]!,
                      highlightColor: Colors.grey[700]!,
                      child: Container(color: Colors.black),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.darkSurfaceVariant,
                      child: const Icon(Icons.error, color: Colors.white24),
                    ),
                  ),
                ),
                // Badge
                if (status != null && status!.isNotEmpty)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getBadgeColor(status!).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        status!.toUpperCase(),
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                else if (type != null)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getBadgeColor(type!).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                         _getBadgeText(type!),
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                // Progress Bar
                if (progress != null)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 4,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        color: Colors.black26,
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress!.clamp(0.0, 1.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                            ),
                            color: AppColors.darkAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Title
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          // Subtitle / Genre
          if (subtitle != null)
            Text(
              subtitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppColors.darkTextSecondary,
              ),
            ),
        ],
      ),
    );
  }

  static Widget shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 3 / 4.2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 14,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 12,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  String _getBadgeText(String type) {
    final t = type.toLowerCase();
    if (t == 'manga') return 'UP';
    if (t == 'manhwa' || t == 'manhua') return 'NEW';
    return type.toUpperCase();
  }

  Color _getBadgeColor(String type) {
    switch (type.toLowerCase()) {
      case 'manga':
        return AppColors.manga;
      case 'manhwa':
        return AppColors.manhwa;
      case 'manhua':
        return AppColors.manhua;
      default:
        return AppColors.darkAccent;
    }
  }
}