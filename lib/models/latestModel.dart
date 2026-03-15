import 'package:json_annotation/json_annotation.dart';

part 'latestModel.g.dart';

@JsonSerializable()
class LatestModel {
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
  final String updated;

  LatestModel({
    required this.chapter_awal,
    required this.chapter_terbaru,
    required this.description,
    required this.genre,
    required this.link,
    required this.readers,
    required this.thumbnail,
    required this.title,
    required this.slug,
    required this.type,
    required this.updated,
  });

  factory LatestModel.fromJson(Map<String, dynamic> json) => _$LatestModelFromJson(json);
  Map<String, dynamic> toJson() => _$LatestModelToJson(this);
}