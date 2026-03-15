import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mangaku/database/Appdb.dart';

class ActivityProvider extends ChangeNotifier {
  final AppDatabase _db;

  ActivityProvider(this._db);

  List<Bookmark> _bookmarks = [];
  List<Bookmark> get bookmarks => _bookmarks;

  List<ReadingHistoryData> _history = [];
  List<ReadingHistoryData> get history => _history;

  Future<void> loadAll() async {
    _bookmarks = await _db.getAllBookmarks();
    _history = await _db.getAllHistory();
    notifyListeners();
  }

  // Bookmark
  Future<bool> isBookmarked(String slug) async {
    return await _db.isBookmarked(slug);
  }

  Future<void> addBookmark(BookmarksCompanion entry) async {
    await _db.addBookmark(entry);
    await loadAll();
  }

  Future<void> removeBookmark(String slug) async {
    await _db.removeBookmark(slug);
    await loadAll();
  }

  // History
  Future<void> upsertHistory(ReadingHistoryCompanion entry) async {
    await _db.upsertHistory(entry);
    await loadAll();
  }

  Future<void> clearHistory() async {
    await _db.clearHistory();
    await loadAll();
  }
}
