// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultsModel _$ResultsModelFromJson(Map<String, dynamic> json) => ResultsModel(
  description: json['description'] as String,
  genre: json['genre'] as String,
  link: json['link'] as String,
  slug: json['slug'] as String,
  thumbnail: json['thumbnail'] as String,
  title: json['title'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$ResultsModelToJson(ResultsModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'genre': instance.genre,
      'link': instance.link,
      'slug': instance.slug,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
      'type': instance.type,
    };

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => SearchModel(
  count: (json['count'] as num).toInt(),
  query: json['query'] as String,
  results: (json['results'] as List<dynamic>)
      .map((e) => ResultsModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'query': instance.query,
      'results': instance.results,
    };
