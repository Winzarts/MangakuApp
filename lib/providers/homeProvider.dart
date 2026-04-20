import 'package:flutter/material.dart';
import 'package:mangaku/models/latestModel.dart';
import 'package:mangaku/models/popularModel.dart';
import 'package:mangaku/services/mangaServices.dart';

class Homeprovider extends ChangeNotifier {
  final MangaServices _mangaServices = MangaServices.create();

  List<PopularModel> _popularManga = [];
  List<PopularModel> get popularManga => _popularManga;

  List<LatestModel> _latestManga = [];
  List<LatestModel> get latestManga => _latestManga;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  Future<void> fetchPopular() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _mangaServices.getPopular();
      final body = response.body;
      List<dynamic> mangaList = [];

      if (body is List) {
        mangaList = body;
      } else if (body is Map<String, dynamic>) {
        mangaList = body['manga'] ?? body['results'] ?? [];
      }

      _popularManga = mangaList.map((e) => PopularModel.fromJson(e)).toList();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'terjadi kesalahan saat memuat data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPopularManga() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _mangaServices.getPopularManga();
      final body = response.body;
      List<dynamic> mangaList = [];

      if (body is List) {
        mangaList = body;
      } else if (body is Map<String, dynamic>) {
        mangaList = body['manga'] ?? body['results'] ?? [];
      }

      _popularManga = mangaList.map((e) => PopularModel.fromJson(e)).toList();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'terjadi kesalahan saat memuat data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPopularManhua() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _mangaServices.getPopularManhua();
      final body = response.body;
      List<dynamic> mangaList = [];

      if (body is List) {
        mangaList = body;
      } else if (body is Map<String, dynamic>) {
        mangaList = body['manga'] ?? body['results'] ?? [];
      }

      _popularManga = mangaList.map((e) => PopularModel.fromJson(e)).toList();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'terjadi kesalahan saat memuat data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPopularManhwa() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _mangaServices.getPopularManhwa();
      final body = response.body;
      List<dynamic> mangaList = [];

      if (body is List) {
        mangaList = body;
      } else if (body is Map<String, dynamic>) {
        mangaList = body['manga'] ?? body['results'] ?? [];
      }

      _popularManga = mangaList.map((e) => PopularModel.fromJson(e)).toList();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'terjadi kesalahan saat memuat data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLatest() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _mangaServices.getLatest();
      final body = response.body;
      List<dynamic> mangaList = [];

      if (body is List) {
        mangaList = body;
      } else if (body is Map<String, dynamic>) {
        mangaList = body['manga'] ?? body['results'] ?? [];
      }

      _latestManga = mangaList.map((e) => LatestModel.fromJson(e)).toList();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'terjadi kesalahan saat memuat data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLatestManga() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _mangaServices.getLatestManga();
      final body = response.body;
      List<dynamic> mangaList = [];

      if (body is List) {
        mangaList = body;
      } else if (body is Map<String, dynamic>) {
        mangaList = body['manga'] ?? body['results'] ?? [];
      }

      _latestManga = mangaList.map((e) => LatestModel.fromJson(e)).toList();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'terjadi kesalahan saat memuat data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLatestManhua() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _mangaServices.getLatestManhua();
      final body = response.body;
      List<dynamic> mangaList = [];

      if (body is List) {
        mangaList = body;
      } else if (body is Map<String, dynamic>) {
        mangaList = body['manga'] ?? body['results'] ?? [];
      }

      _latestManga = mangaList.map((e) => LatestModel.fromJson(e)).toList();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'terjadi kesalahan saat memuat data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLatestManhwa() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _mangaServices.getLatestManhwa();
      final body = response.body;
      List<dynamic> mangaList = [];

      if (body is List) {
        mangaList = body;
      } else if (body is Map<String, dynamic>) {
        mangaList = body['manga'] ?? body['results'] ?? [];
      }

      _latestManga = mangaList.map((e) => LatestModel.fromJson(e)).toList();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'terjadi kesalahan saat memuat data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
