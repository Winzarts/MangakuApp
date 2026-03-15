// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'mangaServices.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$Mangaservices extends Mangaservices {
  _$Mangaservices([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = Mangaservices;

  @override
  Future<Response<dynamic>> getDetailManga(String slug) {
    final Uri $url = Uri.parse('/manga/${slug}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getManga(String slug, String chapterSlug) {
    final Uri $url = Uri.parse('/manga/${slug}/${chapterSlug}/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> SearchManga(String query) {
    final Uri $url = Uri.parse('/search');
    final Map<String, dynamic> $params = <String, dynamic>{'q': query};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getGenre() {
    final Uri $url = Uri.parse('/genre');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMangaByGenre(String genre) {
    final Uri $url = Uri.parse('/genre/${genre}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllMangaList() {
    final Uri $url = Uri.parse('/list-semua-komik');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMangaList() {
    final Uri $url = Uri.parse('/list-manga');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getManhuaList() {
    final Uri $url = Uri.parse('/list-manhua');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getManhwaList() {
    final Uri $url = Uri.parse('/list-manhwa');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPopularManga() {
    final Uri $url = Uri.parse('/popular');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPopularMangaList() {
    final Uri $url = Uri.parse('/popular-manga');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPopularManhuaList() {
    final Uri $url = Uri.parse('/popular-manhua');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPopularManhwaList() {
    final Uri $url = Uri.parse('/popular-manhwa');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getLatestManga() {
    final Uri $url = Uri.parse('/latest');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getLatestMangaList() {
    final Uri $url = Uri.parse('/latest-manga');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getLatestManhuaList() {
    final Uri $url = Uri.parse('/latest-manhua');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getLatestManhwaList() {
    final Uri $url = Uri.parse('/latest-manhwa');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
