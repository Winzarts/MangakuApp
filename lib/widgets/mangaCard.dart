import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mangaku/models/popularModel.dart';
import 'package:mangaku/models/latestModel.dart';
import 'package:mangaku/models/listModel.dart';
import 'package:mangaku/models/genresModel.dart';
import 'package:mangaku/models/searchModel.dart';
import 'package:mangaku/screens/detailScreen.dart';
import 'package:mangaku/themes/zenThemes.dart';

class MangaCard extends StatelessWidget {
  final String title;
  final String thumbnail;
  final String slug;
  final String? type;
  final String? status;
  final String? updated;

  const MangaCard({
    super.key,
    required this.title,
    required this.thumbnail,
    required this.slug,
    this.type,
    this.status,
    this.updated,
  });

  factory MangaCard.popular(PopularModel manga) {
    return MangaCard(
      title: manga.title,
      thumbnail: manga.thumbnail,
      slug: manga.slug,
      type: manga.type,
      updated: manga.updated,
    );
  }

  factory MangaCard.latest(LatestModel manga) {
    return MangaCard(
      title: manga.title,
      thumbnail: manga.thumbnail,
      slug: manga.slug,
      type: manga.type,
      updated: manga.updated,
    );
  }

  factory MangaCard.listManga(ListMangaModel manga) {
    final slug = Uri.parse(
      manga.url,
    ).pathSegments.lastWhere((s) => s.isNotEmpty, orElse: () => '');
    return MangaCard(
      title: manga.title,
      thumbnail: manga.thumbnail,
      slug: slug,
      type: manga.type,
      status: manga.status,
    );
  }

  factory MangaCard.byGenre(ByGenreModel manga) {
    return MangaCard(
      title: manga.title,
      thumbnail: manga.thumbnail,
      slug: manga.slug,
      type: manga.type,
    );
  }

  factory MangaCard.search(ResultsModel manga) {
    return MangaCard(
      title: manga.title,
      thumbnail: manga.thumbnail,
      slug: manga.slug,
      type: manga.type,
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
      child: Container(
        decoration: BoxDecoration(
          color: ZenTheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: thumbnail,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: ZenTheme.surface,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: ZenTheme.surface,
                      child: const Icon(Icons.error),
                    ),
                  ),
                  if (type != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: ZenTheme.primary.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          type!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ZenTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (updated != null)
                    Text(
                      updated!,
                      style: TextStyle(
                        fontSize: 12,
                        color: ZenTheme.textSecondary,
                      ),
                    ),
                  if (status != null)
                    Text(
                      status!,
                      style: TextStyle(
                        fontSize: 12,
                        color: status!.toLowerCase() == 'completed'
                            ? Colors.green
                            : ZenTheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
