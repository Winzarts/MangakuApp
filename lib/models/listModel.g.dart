// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListMangaModel _$ListMangaModelFromJson(Map<String, dynamic> json) =>
    ListMangaModel(
      genre: json['genre'] as String,
      status: json['status'] as String,
      thumbnail: json['thumbnail'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ListMangaModelToJson(ListMangaModel instance) =>
    <String, dynamic>{
      'genre': instance.genre,
      'status': instance.status,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
      'type': instance.type,
      'url': instance.url,
    };

ListMangaResponseModel _$ListMangaResponseModelFromJson(
  Map<String, dynamic> json,
) => ListMangaResponseModel(
  page: (json['page'] as num?)?.toInt(),
  count: (json['count'] as num?)?.toInt(),
  listManga: (json['List_Manga'] as List<dynamic>)
      .map((e) => ListMangaModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ListMangaResponseModelToJson(
  ListMangaResponseModel instance,
) => <String, dynamic>{
  'page': instance.page,
  'count': instance.count,
  'List_Manga': instance.listManga,
};
