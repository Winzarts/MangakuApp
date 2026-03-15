import 'package:json_annotation/json_annotation.dart';

part 'genresModel.g.dart';

@JsonSerializable()
class GenresModel {
  final String genre;
  final String url;

  GenresModel({required this.genre, required this.url});

  factory GenresModel.fromJson(Map<String, dynamic> json) =>
      _$GenresModelFromJson(json);
  Map<String, dynamic> toJson() => _$GenresModelToJson(this);
}

@JsonSerializable()
class ByGenreModel {
  final String chapter_awal;
  final String chapter_terbaru;
  final String description;
  final String genre;
  final String link;
  final String readers;
  final String thumbnail;
  final String title;
  final String slug;
  final String type;

  ByGenreModel({
    required this.chapter_awal,
    required this.chapter_terbaru,
    required this.description,
    required this.genre,
    required this.link,
    required this.slug,
    required this.readers,
    required this.thumbnail,
    required this.title,
    required this.type,
  });

  factory ByGenreModel.fromJson(Map<String, dynamic> json) =>
      _$ByGenreModelFromJson(json);
  Map<String, dynamic> toJson() => _$ByGenreModelToJson(this);
}
