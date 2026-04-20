import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'appDB.g.dart';

//table
class Bookmarks extends Table {
  IntColumn get idBookmarks => integer().autoIncrement()();
  TextColumn get slug => text()();
  TextColumn get title => text()();
  TextColumn get url => text()();
  TextColumn get thumbnail => text()();
  TextColumn get type => text()();
  TextColumn get genre => text().withDefault(const Constant(''))();
  DateTimeColumn get savedAt => dateTime().withDefault(currentDateAndTime)();
}

class Histories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get url => text()();
  TextColumn get mangaSlug => text()();
  TextColumn get chapterSlug => text()();
  TextColumn get thumbnail => text()();
  TextColumn get type => text()();
  TextColumn get lastChapter => text()();
  IntColumn get lastPage => integer().withDefault(const Constant(0))();
  TextColumn get genre => text().withDefault(const Constant(''))();
  DateTimeColumn get readAt => dateTime().withDefault(currentDateAndTime)();
}

//database
@DriftDatabase(tables: [Bookmarks, Histories])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Bookmark>> getAllBookmarks() =>
      (select(bookmarks)..orderBy([(b) => OrderingTerm.desc(b.savedAt)])).get();

  Future<bool> isBookmarked(String slug) async {
    final row = await (select(
      bookmarks,
    )..where((b) => b.slug.equals(slug))).getSingleOrNull();
    return row != null;
  }

  Future<void> addBookmark(BookmarksCompanion entry) =>
      into(bookmarks).insertOnConflictUpdate(entry);

  Future<void> removeBookmark(String slug) =>
      (delete(bookmarks)..where((b) => b.slug.equals(slug))).go();

  Future<List<History>> getAllHistories() =>
      (select(histories)
            ..orderBy([(h) => OrderingTerm.desc(h.readAt)])
            ..limit(100))
          .get();

  Future<void> upsertHistory(HistoriesCompanion entry) async {
    final existing =
        await (select(histories)..where(
              (h) =>
                  h.mangaSlug.equals(entry.mangaSlug.value) &
                  h.chapterSlug.equals(entry.chapterSlug.value),
            ))
            .getSingleOrNull();

    if (existing != null) {
      await (update(histories)..where((h) => h.id.equals(existing.id))).write(
        HistoriesCompanion(
          lastPage: entry.lastPage,
          readAt: Value(DateTime.now()),
        ),
      );
    } else {
      await into(histories).insert(entry);
    }
  }

  Future<void> deleteHistory(String mangaSlug, String chapterSlug) =>
      (delete(histories)..where(
            (h) =>
                h.mangaSlug.equals(mangaSlug) &
                h.chapterSlug.equals(chapterSlug),
          ))
          .go();

  Future<void> clearHistories() => delete(histories).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'mangaku.db'));
    return NativeDatabase.createInBackground(file);
  });
}
