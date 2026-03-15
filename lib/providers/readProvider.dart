import 'package:flutter/material.dart';
import 'package:mangaku/models/mangaModel.dart';
import 'package:mangaku/services/mangaServices.dart';

enum ReadingMode { vertical, horizontal }

enum ReaderTheme { dark, sepia }

class ReaderProvider extends ChangeNotifier {
  final Mangaservices _mangaServices = Mangaservices.create();

  ReadingMode _readingMode = ReadingMode.vertical;
  ReadingMode get readingMode => _readingMode;

  ReaderTheme _readerTheme = ReaderTheme.dark;
  ReaderTheme get readerTheme => _readerTheme;

  MangaModel? _chapterContent;
  MangaModel? get chapterContent => _chapterContent;

  int _currentPage = 0;
  int get currentPage => _currentPage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  void setReadingMode(ReadingMode mode) {
    _readingMode = mode;
    notifyListeners();
  }

  void setReaderTheme(ReaderTheme theme) {
    _readerTheme = theme;
    notifyListeners();
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
        .replaceAll('-id', '')
        .replaceAll('-indo', '');
  }

  Future<void> fetchChapters(String slug, String chapterSlug) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final cleanedChapterSlug = _cleanSlug(chapterSlug);
    final cleanedMangaSlug = _cleanMangaSlug(slug);

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
          _errorMessage =
              'Format data tidak sesuai (bukan Map): ${body.runtimeType}';
        }
      } else {
        String errorMsg = 'Gagal memuat isi chapter';
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
}
