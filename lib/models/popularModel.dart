import 'package:json_annotation/json_annotation.dart';

part 'popularModel.g.dart';

@JsonSerializable()
class PopularModel {
  final String chapter_awal;
  final String chapter_terbaru;
  final String description;
  final String genre;
  final String link;
  final String slug;
  final String readers;
  final String thumbnail;
  final String title;
  final String type;
  final String updated;

  PopularModel({
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
    required this.updated,
  });

  factory PopularModel.fromJson(Map<String, dynamic> json) => _$PopularModelFromJson(json);
  Map<String, dynamic> toJson() => _$PopularModelToJson(this);
}