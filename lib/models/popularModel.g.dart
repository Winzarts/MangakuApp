// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popularModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularModel _$PopularModelFromJson(Map<String, dynamic> json) => PopularModel(
  chapter_awal: json['chapter_awal'] as String,
  chapter_terbaru: json['chapter_terbaru'] as String,
  description: json['description'] as String,
  genre: json['genre'] as String,
  link: json['link'] as String,
  slug: json['slug'] as String,
  readers: json['readers'] as String,
  thumbnail: json['thumbnail'] as String,
  title: json['title'] as String,
  type: json['type'] as String,
  updated: json['updated'] as String,
);

Map<String, dynamic> _$PopularModelToJson(PopularModel instance) =>
    <String, dynamic>{
      'chapter_awal': instance.chapter_awal,
      'chapter_terbaru': instance.chapter_terbaru,
      'description': instance.description,
      'genre': instance.genre,
      'link': instance.link,
      'slug': instance.slug,
      'readers': instance.readers,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
      'type': instance.type,
      'updated': instance.updated,
    };
