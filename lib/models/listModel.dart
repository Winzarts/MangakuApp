import 'package:json_annotation/json_annotation.dart';

part 'listModel.g.dart';

@JsonSerializable()
class ListMangaModel {
  final String genre;
  final String status;
  final String thumbnail;
  final String title;
  final String type;
  final String url;

  ListMangaModel({
    required this.genre,
    required this.status,
    required this.thumbnail,
    required this.title,
    required this.type,
    required this.url,
  });

  factory ListMangaModel.fromJson(Map<String, dynamic> json) =>
      _$ListMangaModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListMangaModelToJson(this);
}

@JsonSerializable()
class ListMangaResponseModel {
  final int? page;
  final int? count;
  @JsonKey(name: 'List_Manga')
  final List<ListMangaModel> listManga;

  ListMangaResponseModel({this.page, this.count, required this.listManga});

  factory ListMangaResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ListMangaResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListMangaResponseModelToJson(this);
}
