import 'package:flutter/material.dart';
import 'package:mangaku/models/searchModel.dart';
import 'package:mangaku/services/mangaServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchProvider extends ChangeNotifier {
  final MangaServices _mangaServices = MangaServices.create();

  SearchProvider() {
    loadRecentSearches();
  }

  List<SearchModel>? _searchModel;
  List<SearchModel> get searchModel => _searchModel ?? [];

  List<ResultsModel>? _results;
  List<ResultsModel> get results => _results ?? [];

  List<String> _recentSearches = [];
  List<String> get recentSearches => _recentSearches;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    _recentSearches = prefs.getStringList('recentSearches') ?? [];
    notifyListeners();
  }

  Future<void> saveRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recentSearches', _recentSearches);
  }

  void addRecentSearch(String query) {
    if (query.isEmpty) return;
    
    // Remove if already exists to move to top
    _recentSearches.remove(query);
    _recentSearches.insert(0, query);
    
    // Limit to 10 items
    if (_recentSearches.length > 10) {
      _recentSearches = _recentSearches.sublist(0, 10);
    }
    
    saveRecentSearches();
    notifyListeners();
  }

  void removeRecentSearch(String query) {
    _recentSearches.remove(query);
    saveRecentSearches();
    notifyListeners();
  }

  void clearRecentSearches() {
    _recentSearches.clear();
    saveRecentSearches();
    notifyListeners();
  }

  Future<void> searchManga(String query) async {
    if (query.isEmpty) {
      _results = null;
      notifyListeners();
      return;
    }

    addRecentSearch(query);
    
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _mangaServices.searchManga(query);
      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        if (body is Map) {
          final searchModel = SearchModel.fromJson(
            Map<String, dynamic>.from(body),
          );
          _results = searchModel.results;
        }
      }
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}