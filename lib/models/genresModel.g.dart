// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genresModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenresModel _$GenresModelFromJson(Map<String, dynamic> json) =>
    GenresModel(genre: json['genre'] as String, url: json['url'] as String);

Map<String, dynamic> _$GenresModelToJson(GenresModel instance) =>
    <String, dynamic>{'genre': instance.genre, 'url': instance.url};

ByGenreModel _$ByGenreModelFromJson(Map<String, dynamic> json) => ByGenreModel(
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
);

Map<String, dynamic> _$ByGenreModelToJson(ByGenreModel instance) =>
    <String, dynamic>{
      'chapter_awal': instance.chapter_awal,
      'chapter_terbaru': instance.chapter_terbaru,
      'description': instance.description,
      'genre': instance.genre,
      'link': instance.link,
      'readers': instance.readers,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
      'slug': instance.slug,
      'type': instance.type,
    };
