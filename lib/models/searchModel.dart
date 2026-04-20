import 'package:json_annotation/json_annotation.dart';

part 'searchModel.g.dart';

@JsonSerializable()
class ResultsModel {
  final String? description;
  final String genre;
  final String link;
  final String slug;
  final String thumbnail;
  final String title;
  final String type;

  ResultsModel({
    this.description,
    required this.genre,
    required this.link,
    required this.slug,
    required this.thumbnail,
    required this.title,
    required this.type,
  });

  factory ResultsModel.fromJson(Map<String, dynamic> json) =>
      _$ResultsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResultsModelToJson(this);
}

@JsonSerializable()
class SearchModel {
  final int count;
  final String query;
  final List<ResultsModel> results;

  SearchModel({
    required this.count,
    required this.query,
    required this.results,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}