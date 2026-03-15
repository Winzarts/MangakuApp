import 'package:flutter/material.dart';
import 'package:mangaku/models/searchModel.dart';
import 'package:mangaku/services/mangaServices.dart';

class SearchProvider extends ChangeNotifier {
  final Mangaservices _mangaServices = Mangaservices.create();

  List<SearchModel>? _searchModel;
  List<SearchModel> get searchModel => _searchModel ?? [];

  List<ResultsModel>? _results;
  List<ResultsModel> get results => _results ?? [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> searchManga(String query) async {
    if (query.isEmpty) {
      _results = null;
      notifyListeners();
      return;
    }
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _mangaServices.SearchManga(query);
      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        if (body is Map) {
          final searchModel = SearchModel.fromJson(
            Map<String, dynamic>.from(body),
          );
          _results = searchModel.results;
        } else if (body is List) {
          _results = body
              .map((e) => ResultsModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();
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
