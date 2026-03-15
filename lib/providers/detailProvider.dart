import 'package:flutter/material.dart';
import 'package:mangaku/models/mangaModel.dart';
import 'package:mangaku/services/mangaServices.dart';

class DetailProvider extends ChangeNotifier {
  final Mangaservices _mangaServices = Mangaservices.create();

  DetailMangaModel? _mangaDetail;
  DetailMangaModel? get mangaDetail => _mangaDetail;

  MangaModel? _chapterContent;
  MangaModel? get chapterContent => _chapterContent;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchMangaDetail(String slug) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _mangaServices.getDetailManga(slug);
      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        if (body is Map<String, dynamic>) {
          _mangaDetail = DetailMangaModel.fromJson(body);
        } else {
          _errorMessage = 'Format data detail manga tidak valid';
        }
      } else {
        _errorMessage = 'Gagal mengambil detail manga';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _cleanSlug(String slug) {
    // Extract the part starting with 'chapter-'
    final index = slug.indexOf('chapter-');
    if (index != -1) {
      return slug.substring(index);
    }
    return slug;
  }

  String _cleanMangaSlug(String slug) {
    return slug
        .replaceAll('-indonesia', '')
        .replaceAll('-indo', '')
        .replaceAll('-id', '');
  }

  Future<void> fetchChapterContent(String mangaSlug, String chapterSlug) async {
    _isLoading = true;
    _errorMessage = '';
    _chapterContent = null; // Reset previous content
    notifyListeners();

    final cleanedChapterSlug = _cleanSlug(chapterSlug);
    final cleanedMangaSlug = _cleanMangaSlug(mangaSlug);

    try {
      final response = await _mangaServices.getManga(
        cleanedMangaSlug,
        cleanedChapterSlug,
      );
      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        if (body is Map) {
          _chapterContent = MangaModel.fromJson(
            Map<String, dynamic>.from(body),
          );
        } else {
          _errorMessage = 'Format data salah (bukan Map): ${body.runtimeType}';
        }
      } else {
        String errorMsg = 'Gagal mengambil isi chapter';
        final apiUrl = response.base.request?.url.toString() ?? 'Unknown URL';

        if (response.statusCode == 404) {
          errorMsg = 'Chapter tidak ditemukan (404).\nLink: $apiUrl';
        } else if (response.statusCode == 500) {
          errorMsg = 'API Error (500): Gagal ambil konten.\nLink: $apiUrl';
        } else {
          errorMsg =
              'Error ${response.statusCode}: ${response.error ?? 'Unknown error'}\nLink: $apiUrl';
        }
        _errorMessage = errorMsg;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearChapterContent() {
    _chapterContent = null;
    notifyListeners();
  }
}
