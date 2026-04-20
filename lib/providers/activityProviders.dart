import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mangaku/databases/appDB.dart';

class Activityproviders extends ChangeNotifier {
  final AppDatabase _db;

  Activityproviders(this._db);

  List<Bookmark> _bookmarks = [];
  List<History> _histories = [];

  List<History> get histories => _histories;
  List<Bookmark> get bookmarks => _bookmarks;

  Future<void> loadAll() async {
    _bookmarks = await _db.getAllBookmarks();
    _histories = await _db.getAllHistories();
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
  Future<void> upsertHistory(HistoriesCompanion entry) async {
    await _db.upsertHistory(entry);
    await loadAll();
  }

  Future<void> deleteHistory(String mangaSlug, String chapterSlug) async {
    await _db.deleteHistory(mangaSlug, chapterSlug);
    await loadAll();
  }

  Future<void> clearHistories() async {
    await _db.clearHistories();
    await loadAll();
  }
}