import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:mangaku/models/genreModel.dart';
import 'package:mangaku/models/listModel.dart';
import 'package:mangaku/services/mangaServices.dart';

enum LibraryType { all, manga, manhwa, manhua }

enum LibrarySort { popular, latest, alphabets }

class LibraryProvider with ChangeNotifier {
  final MangaServices _mangaServices = MangaServices.create();

  List<ListMangaModel> _mangaList = [];
  List<ListMangaModel> get mangaList => _mangaList;

  List<GenresModel> _genres = [];
  List<GenresModel> get genres => _genres;

  GenresModel? _selectedGenre;
  GenresModel? get selectedGenre => _selectedGenre;

  LibraryType _selectedType = LibraryType.all;
  LibraryType get selectedType => _selectedType;

  LibrarySort _selectedSort = LibrarySort.alphabets;
  LibrarySort get selectedSort => _selectedSort;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  bool _isGridView = true;
  bool get isGridView => _isGridView;

  String _selectedTab = 'All';
  String get selectedTab => _selectedTab;

  int _page = 1;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  void toggleView() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  void setSelectedTab(String tab) {
    _selectedTab = tab;
    fetchLibrary(reset: true);
  }

  List<dynamic> _parseList(dynamic body) {
    if (body is List) return body;
    if (body is Map<String, dynamic>) {
      return body['manga'] ?? 
             body['results'] ?? 
             body['data'] ?? 
             body['List_Manga'] ?? 
             [];
    }
    return [];
  }

  void setType(LibraryType type) {
    _selectedType = type;
    fetchLibrary(reset: true);
  }

  void setSort(LibrarySort sort) {
    _selectedSort = sort;
    _selectedGenre = null;
    fetchLibrary(reset: true);
  }

  void setGenre(GenresModel? genre) {
    _selectedGenre = genre;
    fetchLibrary(reset: true);
  }

  Future<void> fetchGenres() async {
    try {
      final response = await _mangaServices.getGenre();

      if (response.isSuccessful && response.body != null) {
        final list = _parseList(response.body);

        _genres = list
            .map((e) => GenresModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();

        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> fetchLibrary({bool reset = false}) async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = "";

    if (reset) {
      _page = 1;
      _mangaList.clear();
      _hasMore = true;
    }

    notifyListeners();

    try {
      Response<dynamic> response;

      if (_selectedGenre != null) {
        // extract slug from url (e.g. "https://archive.org/genre/action/" -> "action")
        final slug = _selectedGenre!.url
            .split('/')
            .where((s) => s.isNotEmpty)
            .last;
        response = await _mangaServices.getGenreDetail(slug);
      } else {
        switch (_selectedType) {
          case LibraryType.all:
            response = await _mangaServices.getAllManga(_page);
            break;
          case LibraryType.manga:
            response = await _mangaServices.getListManga(_page);
            break;
          case LibraryType.manhwa:
            response = await _mangaServices.getListManhwa(_page);
            break;
          case LibraryType.manhua:
            response = await _mangaServices.getListManhua(_page);
            break;
        }
      }

      if (response.isSuccessful && response.body != null) {
        final list = _parseList(response.body);

        final newManga = list
            .map((e) => ListMangaModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();

        _mangaList = newManga;

        _page = 2; // 🔥 next page
        _hasMore = newManga.length >= 50;
      } else {
        _errorMessage = "Gagal memuat data";
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLibraryMore() async {
    if (_isLoadingMore || !_hasMore || _selectedGenre != null)
      return; // genre detail might not support pagination in the same way

    _isLoadingMore = true;
    notifyListeners();

    try {
      Response<dynamic> response;
      switch (_selectedType) {
        case LibraryType.all:
          response = await _mangaServices.getAllManga(_page);
          break;
        case LibraryType.manga:
          response = await _mangaServices.getListManga(_page);
          break;
        case LibraryType.manhwa:
          response = await _mangaServices.getListManhwa(_page);
          break;
        case LibraryType.manhua:
          response = await _mangaServices.getListManhua(_page);
          break;
      }

      if (response.isSuccessful && response.body != null) {
        final list = _parseList(response.body);

        final newManga = list
            .map((e) => ListMangaModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();

        final filtered = newManga.where(
          (newItem) => !_mangaList.any((old) => old.url == newItem.url),
        );

        _mangaList.addAll(filtered);

        _page++;
        _hasMore = newManga.length >= 50;
      } else {
        _errorMessage = "Gagal memuat data";
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }
}
