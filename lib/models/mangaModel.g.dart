// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mangaModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaModel _$MangaModelFromJson(Map<String, dynamic> json) => MangaModel(
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  title: json['title'] as String,
);

Map<String, dynamic> _$MangaModelToJson(MangaModel instance) =>
    <String, dynamic>{'images': instance.images, 'title': instance.title};

ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) => ChapterModel(
  title: json['title'] as String,
  url: json['url'] as String,
  slug: json['slug'] as String,
  views: json['views'] as String,
  date: json['date'] as String,
);

Map<String, dynamic> _$ChapterModelToJson(ChapterModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'slug': instance.slug,
      'views': instance.views,
      'date': instance.date,
    };

DetailMangaModel _$DetailMangaModelFromJson(Map<String, dynamic> json) =>
    DetailMangaModel(
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => ChapterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres: (json['genres'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      image_url: json['image_url'] as String,
      indonesia_title: json['indonesia_title'] as String?,
      description: json['description'] as String?,
      sinopsis: json['sinopsis'] as String?,
      title: json['title'] as String,
    );

Map<String, dynamic> _$DetailMangaModelToJson(DetailMangaModel instance) =>
    <String, dynamic>{
      'chapters': instance.chapters,
      'genres': instance.genres,
      'image_url': instance.image_url,
      'indonesia_title': instance.indonesia_title,
      'description': instance.description,
      'sinopsis': instance.sinopsis,
      'title': instance.title,
    };
