import 'package:json_annotation/json_annotation.dart';

part 'mangaModel.g.dart';

@JsonSerializable()
class MangaModel {
  final List<String> images;
  final String title;

  MangaModel({required this.images, required this.title});

  factory MangaModel.fromJson(Map<String, dynamic> json) =>
      _$MangaModelFromJson(json);
  Map<String, dynamic> toJson() => _$MangaModelToJson(this);
}

@JsonSerializable()
class ChapterModel {
  final String title;
  final String url;
  final String slug;
  final String views;
  final String date;

  ChapterModel({
    required this.title,
    required this.url,
    required this.slug,
    required this.views,
    required this.date,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterModelToJson(this);
}

@JsonSerializable()
class DetailMangaModel {
  final List<ChapterModel> chapters;
  final List<String> genres;
  final String image_url;
  final String? indonesia_title;
  final String? description;
  final String? sinopsis;
  final String title;

  DetailMangaModel({
    required this.chapters,
    required this.genres,
    required this.image_url,
    this.indonesia_title,
    this.description,
    this.sinopsis,
    required this.title,
  });

  factory DetailMangaModel.fromJson(Map<String, dynamic> json) =>
      _$DetailMangaModelFromJson(json);
  Map<String, dynamic> toJson() => _$DetailMangaModelToJson(this);
}