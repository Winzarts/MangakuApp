import 'package:flutter/material.dart';
import 'package:mangaku/models/genresModel.dart';
import 'package:mangaku/models/latestModel.dart';
import 'package:mangaku/models/listModel.dart';
import 'package:mangaku/models/popularModel.dart';
import 'package:mangaku/services/mangaServices.dart';
import 'package:chopper/chopper.dart';

enum LibraryType { all, manga, manhwa, manhua }

enum LibrarySort { popular, latest, alphabets }

class LibraryProvider extends ChangeNotifier {
  final Mangaservices _mangaServices = Mangaservices.create();

  List<dynamic> _mangas = [];
  List<dynamic> get mangas => _mangas;

  LibraryType _selectedType = LibraryType.all;
  LibraryType get selectedType => _selectedType;

  LibrarySort _selectedSort = LibrarySort.alphabets;
  LibrarySort get selectedSort => _selectedSort;

  List<GenresModel> _genres = [];
  List<GenresModel> get genres => _genres;

  GenresModel? _selectedGenre;
  GenresModel? get selectedGenre => _selectedGenre;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  void setType(LibraryType type) {
    _selectedType = type;
    fetchLibrary();
  }

  void setSort(LibrarySort sort) {
    _selectedSort = sort;
    _selectedGenre = null; // Clear genre when changing sort
    fetchLibrary();
  }

  void setGenre(GenresModel? genre) {
    _selectedGenre = genre;
    fetchLibrary();
  }

  Future<void> fetchGenres() async {
    try {
      final response = await _mangaServices.getGenre();
      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        List<dynamic> genreList = [];
        if (body is List) {
          genreList = body;
        } else if (body is Map<String, dynamic>) {
          genreList = body['genres'] ?? body['results'] ?? [];
        }

        _genres = genreList
            .map((e) => GenresModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching genres: $e');
    }
  }

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  Future<void> fetchLibrary({bool isLoadMore = false}) async {
    if (isLoadMore && (!_hasMore || _isLoading)) return;

    if (!isLoadMore) {
      _mangas = [];
      _hasMore = true;
    }

    _isLoading = true;
    notifyListeners();

    try {
      Response response;
      // Note: The API currently doesn't seem to support ?page=X for all endpoints,
      // but we'll include logic to handle the response appropriately.

      if (_selectedGenre != null) {
        response = await _mangaServices.getMangaByGenre(_selectedGenre!.genre);
      } else if (_selectedSort == LibrarySort.popular) {
        switch (_selectedType) {
          case LibraryType.manga:
            response = await _mangaServices.getPopularMangaList();
            break;
          case LibraryType.manhwa:
            response = await _mangaServices.getPopularManhwaList();
            break;
          case LibraryType.manhua:
            response = await _mangaServices.getPopularManhuaList();
            break;
          case LibraryType.all:
            response = await _mangaServices.getPopularManga();
            break;
        }
      } else if (_selectedSort == LibrarySort.latest) {
        switch (_selectedType) {
          case LibraryType.manga:
            response = await _mangaServices.getLatestMangaList();
            break;
          case LibraryType.manhwa:
            response = await _mangaServices.getLatestManhwaList();
            break;
          case LibraryType.manhua:
            response = await _mangaServices.getLatestManhuaList();
            break;
          case LibraryType.all:
            response = await _mangaServices.getLatestManga();
            break;
        }
      } else {
        switch (_selectedType) {
          case LibraryType.manga:
            response = await _mangaServices.getMangaList();
            break;
          case LibraryType.manhwa:
            response = await _mangaServices.getManhwaList();
            break;
          case LibraryType.manhua:
            response = await _mangaServices.getManhuaList();
            break;
          case LibraryType.all:
            response = await _mangaServices.getAllMangaList();
            break;
        }
      }

      if (response.isSuccessful && response.body != null) {
        List<dynamic> newMangasRaw = [];
        final body = response.body;

        if (body is Map) {
          if (body.containsKey('List_Manga')) {
            newMangasRaw = body['List_Manga'] as List;
          } else if (body.containsKey('Manga_List')) {
            newMangasRaw = body['Manga_List'] as List;
          } else if (body.containsKey('results')) {
            newMangasRaw = body['results'] as List;
          } else if (body.containsKey('manga')) {
            newMangasRaw = body['manga'] as List;
          } else if (body.containsKey('data')) {
            final data = body['data'];
            if (data is List) {
              newMangasRaw = data;
            }
          }
        } else if (body is List) {
          newMangasRaw = body;
        }

        List<dynamic> newMangas = [];
        if (_selectedGenre != null) {
          newMangas = newMangasRaw
              .map((e) => ByGenreModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();
        } else if (_selectedSort == LibrarySort.popular) {
          newMangas = newMangasRaw
              .map((e) => PopularModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();
        } else if (_selectedSort == LibrarySort.latest) {
          newMangas = newMangasRaw
              .map((e) => LatestModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();
        } else {
          newMangas = newMangasRaw
              .map((e) => ListMangaModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();
        }

        if (isLoadMore) {
          _mangas.addAll(newMangas);
        } else {
          _mangas = newMangas;
        }

        // Simple check to see if we reached the end
        if (newMangas.isEmpty || newMangas.length < 10) {
          _hasMore = false;
        }

        _errorMessage = '';
      } else {
        _errorMessage = 'Gagal mengambil data dari server';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
