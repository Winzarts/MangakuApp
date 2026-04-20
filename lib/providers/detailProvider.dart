import 'package:flutter/material.dart';
import 'package:mangaku/models/mangaModel.dart';
import 'package:mangaku/services/mangaServices.dart';

class Detailprovider extends ChangeNotifier {
  final MangaServices _mangaServices = MangaServices.create();

  DetailMangaModel? _mangaDetail;
  DetailMangaModel? get mangaDetail => _mangaDetail;

  MangaModel? _chapterContent;
  MangaModel? get chapterContent => _chapterContent;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  Future<void> fetchMangaDetail(String slug) async {
    _mangaDetail = null;
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _mangaServices.getMangaDetail(slug);
      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        if (body is Map) {
          _mangaDetail = DetailMangaModel.fromJson(
            Map<String, dynamic>.from(body),
          );
        } else {
          _errorMessage = 'gagal memuat format data';
        }
      } else {
        _errorMessage = "gagal memuat data";
      }
    } catch (e) {
      _errorMessage = "terjadi kesalahan saat memuat data";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _cleanSlug(String slug) {
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
    notifyListeners();

    final cleanedChapterSlug = _cleanSlug(chapterSlug);
    final cleanedMangaSlug = _cleanMangaSlug(mangaSlug);

    try {
      final response = await _mangaServices.getChapterDetail(
        cleanedMangaSlug,
        cleanedChapterSlug
      );
      if (response.isSuccessful && response.body != null ) {
        final body = response.body;
        if (body is Map) {
          _chapterContent = MangaModel.fromJson(
            Map<String, dynamic>.from(body)
          );
        } else {
          _errorMessage = 'gagal memuat format data';
        }
      } else {
        _errorMessage = 'gagal memuat data';

        if (response.statusCode == 404) {
          _errorMessage = 'chapter komik tidak ditemukan';
        }
      }
    } catch (e) {
      _errorMessage = 'terjadi kesalahan saat memuat data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearChapterContent() {
    _chapterContent = null;
    _errorMessage = '';
    notifyListeners();
  }
}