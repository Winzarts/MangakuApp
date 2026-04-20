// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appDB.dart';

// ignore_for_file: type=lint
class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idBookmarksMeta = const VerificationMeta(
    'idBookmarks',
  );
  @override
  late final GeneratedColumn<int> idBookmarks = GeneratedColumn<int>(
    'id_bookmarks',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailMeta = const VerificationMeta(
    'thumbnail',
  );
  @override
  late final GeneratedColumn<String> thumbnail = GeneratedColumn<String>(
    'thumbnail',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
    'genre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idBookmarks,
    slug,
    title,
    url,
    thumbnail,
    type,
    genre,
    savedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_bookmarks')) {
      context.handle(
        _idBookmarksMeta,
        idBookmarks.isAcceptableOrUnknown(
          data['id_bookmarks']!,
          _idBookmarksMeta,
        ),
      );
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('thumbnail')) {
      context.handle(
        _thumbnailMeta,
        thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta),
      );
    } else if (isInserting) {
      context.missing(_thumbnailMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('genre')) {
      context.handle(
        _genreMeta,
        genre.isAcceptableOrUnknown(data['genre']!, _genreMeta),
      );
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idBookmarks};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      idBookmarks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_bookmarks'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      thumbnail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      genre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}genre'],
      )!,
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int idBookmarks;
  final String slug;
  final String title;
  final String url;
  final String thumbnail;
  final String type;
  final String genre;
  final DateTime savedAt;
  const Bookmark({
    required this.idBookmarks,
    required this.slug,
    required this.title,
    required this.url,
    required this.thumbnail,
    required this.type,
    required this.genre,
    required this.savedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_bookmarks'] = Variable<int>(idBookmarks);
    map['slug'] = Variable<String>(slug);
    map['title'] = Variable<String>(title);
    map['url'] = Variable<String>(url);
    map['thumbnail'] = Variable<String>(thumbnail);
    map['type'] = Variable<String>(type);
    map['genre'] = Variable<String>(genre);
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      idBookmarks: Value(idBookmarks),
      slug: Value(slug),
      title: Value(title),
      url: Value(url),
      thumbnail: Value(thumbnail),
      type: Value(type),
      genre: Value(genre),
      savedAt: Value(savedAt),
    );
  }

  factory Bookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      idBookmarks: serializer.fromJson<int>(json['idBookmarks']),
      slug: serializer.fromJson<String>(json['slug']),
      title: serializer.fromJson<String>(json['title']),
      url: serializer.fromJson<String>(json['url']),
      thumbnail: serializer.fromJson<String>(json['thumbnail']),
      type: serializer.fromJson<String>(json['type']),
      genre: serializer.fromJson<String>(json['genre']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idBookmarks': serializer.toJson<int>(idBookmarks),
      'slug': serializer.toJson<String>(slug),
      'title': serializer.toJson<String>(title),
      'url': serializer.toJson<String>(url),
      'thumbnail': serializer.toJson<String>(thumbnail),
      'type': serializer.toJson<String>(type),
      'genre': serializer.toJson<String>(genre),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  Bookmark copyWith({
    int? idBookmarks,
    String? slug,
    String? title,
    String? url,
    String? thumbnail,
    String? type,
    String? genre,
    DateTime? savedAt,
  }) => Bookmark(
    idBookmarks: idBookmarks ?? this.idBookmarks,
    slug: slug ?? this.slug,
    title: title ?? this.title,
    url: url ?? this.url,
    thumbnail: thumbnail ?? this.thumbnail,
    type: type ?? this.type,
    genre: genre ?? this.genre,
    savedAt: savedAt ?? this.savedAt,
  );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      idBookmarks: data.idBookmarks.present
          ? data.idBookmarks.value
          : this.idBookmarks,
      slug: data.slug.present ? data.slug.value : this.slug,
      title: data.title.present ? data.title.value : this.title,
      url: data.url.present ? data.url.value : this.url,
      thumbnail: data.thumbnail.present ? data.thumbnail.value : this.thumbnail,
      type: data.type.present ? data.type.value : this.type,
      genre: data.genre.present ? data.genre.value : this.genre,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('idBookmarks: $idBookmarks, ')
          ..write('slug: $slug, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('type: $type, ')
          ..write('genre: $genre, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idBookmarks,
    slug,
    title,
    url,
    thumbnail,
    type,
    genre,
    savedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.idBookmarks == this.idBookmarks &&
          other.slug == this.slug &&
          other.title == this.title &&
          other.url == this.url &&
          other.thumbnail == this.thumbnail &&
          other.type == this.type &&
          other.genre == this.genre &&
          other.savedAt == this.savedAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> idBookmarks;
  final Value<String> slug;
  final Value<String> title;
  final Value<String> url;
  final Value<String> thumbnail;
  final Value<String> type;
  final Value<String> genre;
  final Value<DateTime> savedAt;
  const BookmarksCompanion({
    this.idBookmarks = const Value.absent(),
    this.slug = const Value.absent(),
    this.title = const Value.absent(),
    this.url = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.type = const Value.absent(),
    this.genre = const Value.absent(),
    this.savedAt = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.idBookmarks = const Value.absent(),
    required String slug,
    required String title,
    required String url,
    required String thumbnail,
    required String type,
    this.genre = const Value.absent(),
    this.savedAt = const Value.absent(),
  }) : slug = Value(slug),
       title = Value(title),
       url = Value(url),
       thumbnail = Value(thumbnail),
       type = Value(type);
  static Insertable<Bookmark> custom({
    Expression<int>? idBookmarks,
    Expression<String>? slug,
    Expression<String>? title,
    Expression<String>? url,
    Expression<String>? thumbnail,
    Expression<String>? type,
    Expression<String>? genre,
    Expression<DateTime>? savedAt,
  }) {
    return RawValuesInsertable({
      if (idBookmarks != null) 'id_bookmarks': idBookmarks,
      if (slug != null) 'slug': slug,
      if (title != null) 'title': title,
      if (url != null) 'url': url,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (type != null) 'type': type,
      if (genre != null) 'genre': genre,
      if (savedAt != null) 'saved_at': savedAt,
    });
  }

  BookmarksCompanion copyWith({
    Value<int>? idBookmarks,
    Value<String>? slug,
    Value<String>? title,
    Value<String>? url,
    Value<String>? thumbnail,
    Value<String>? type,
    Value<String>? genre,
    Value<DateTime>? savedAt,
  }) {
    return BookmarksCompanion(
      idBookmarks: idBookmarks ?? this.idBookmarks,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      url: url ?? this.url,
      thumbnail: thumbnail ?? this.thumbnail,
      type: type ?? this.type,
      genre: genre ?? this.genre,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idBookmarks.present) {
      map['id_bookmarks'] = Variable<int>(idBookmarks.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String>(thumbnail.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('idBookmarks: $idBookmarks, ')
          ..write('slug: $slug, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('type: $type, ')
          ..write('genre: $genre, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }
}

class $HistoriesTable extends Histories
    with TableInfo<$HistoriesTable, History> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mangaSlugMeta = const VerificationMeta(
    'mangaSlug',
  );
  @override
  late final GeneratedColumn<String> mangaSlug = GeneratedColumn<String>(
    'manga_slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterSlugMeta = const VerificationMeta(
    'chapterSlug',
  );
  @override
  late final GeneratedColumn<String> chapterSlug = GeneratedColumn<String>(
    'chapter_slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailMeta = const VerificationMeta(
    'thumbnail',
  );
  @override
  late final GeneratedColumn<String> thumbnail = GeneratedColumn<String>(
    'thumbnail',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastChapterMeta = const VerificationMeta(
    'lastChapter',
  );
  @override
  late final GeneratedColumn<String> lastChapter = GeneratedColumn<String>(
    'last_chapter',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastPageMeta = const VerificationMeta(
    'lastPage',
  );
  @override
  late final GeneratedColumn<int> lastPage = GeneratedColumn<int>(
    'last_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
    'genre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _readAtMeta = const VerificationMeta('readAt');
  @override
  late final GeneratedColumn<DateTime> readAt = GeneratedColumn<DateTime>(
    'read_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    url,
    mangaSlug,
    chapterSlug,
    thumbnail,
    type,
    lastChapter,
    lastPage,
    genre,
    readAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<History> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('manga_slug')) {
      context.handle(
        _mangaSlugMeta,
        mangaSlug.isAcceptableOrUnknown(data['manga_slug']!, _mangaSlugMeta),
      );
    } else if (isInserting) {
      context.missing(_mangaSlugMeta);
    }
    if (data.containsKey('chapter_slug')) {
      context.handle(
        _chapterSlugMeta,
        chapterSlug.isAcceptableOrUnknown(
          data['chapter_slug']!,
          _chapterSlugMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chapterSlugMeta);
    }
    if (data.containsKey('thumbnail')) {
      context.handle(
        _thumbnailMeta,
        thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta),
      );
    } else if (isInserting) {
      context.missing(_thumbnailMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('last_chapter')) {
      context.handle(
        _lastChapterMeta,
        lastChapter.isAcceptableOrUnknown(
          data['last_chapter']!,
          _lastChapterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastChapterMeta);
    }
    if (data.containsKey('last_page')) {
      context.handle(
        _lastPageMeta,
        lastPage.isAcceptableOrUnknown(data['last_page']!, _lastPageMeta),
      );
    }
    if (data.containsKey('genre')) {
      context.handle(
        _genreMeta,
        genre.isAcceptableOrUnknown(data['genre']!, _genreMeta),
      );
    }
    if (data.containsKey('read_at')) {
      context.handle(
        _readAtMeta,
        readAt.isAcceptableOrUnknown(data['read_at']!, _readAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  History map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return History(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      mangaSlug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manga_slug'],
      )!,
      chapterSlug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_slug'],
      )!,
      thumbnail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      lastChapter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_chapter'],
      )!,
      lastPage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_page'],
      )!,
      genre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}genre'],
      )!,
      readAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}read_at'],
      )!,
    );
  }

  @override
  $HistoriesTable createAlias(String alias) {
    return $HistoriesTable(attachedDatabase, alias);
  }
}

class History extends DataClass implements Insertable<History> {
  final int id;
  final String title;
  final String url;
  final String mangaSlug;
  final String chapterSlug;
  final String thumbnail;
  final String type;
  final String lastChapter;
  final int lastPage;
  final String genre;
  final DateTime readAt;
  const History({
    required this.id,
    required this.title,
    required this.url,
    required this.mangaSlug,
    required this.chapterSlug,
    required this.thumbnail,
    required this.type,
    required this.lastChapter,
    required this.lastPage,
    required this.genre,
    required this.readAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['url'] = Variable<String>(url);
    map['manga_slug'] = Variable<String>(mangaSlug);
    map['chapter_slug'] = Variable<String>(chapterSlug);
    map['thumbnail'] = Variable<String>(thumbnail);
    map['type'] = Variable<String>(type);
    map['last_chapter'] = Variable<String>(lastChapter);
    map['last_page'] = Variable<int>(lastPage);
    map['genre'] = Variable<String>(genre);
    map['read_at'] = Variable<DateTime>(readAt);
    return map;
  }

  HistoriesCompanion toCompanion(bool nullToAbsent) {
    return HistoriesCompanion(
      id: Value(id),
      title: Value(title),
      url: Value(url),
      mangaSlug: Value(mangaSlug),
      chapterSlug: Value(chapterSlug),
      thumbnail: Value(thumbnail),
      type: Value(type),
      lastChapter: Value(lastChapter),
      lastPage: Value(lastPage),
      genre: Value(genre),
      readAt: Value(readAt),
    );
  }

  factory History.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return History(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      url: serializer.fromJson<String>(json['url']),
      mangaSlug: serializer.fromJson<String>(json['mangaSlug']),
      chapterSlug: serializer.fromJson<String>(json['chapterSlug']),
      thumbnail: serializer.fromJson<String>(json['thumbnail']),
      type: serializer.fromJson<String>(json['type']),
      lastChapter: serializer.fromJson<String>(json['lastChapter']),
      lastPage: serializer.fromJson<int>(json['lastPage']),
      genre: serializer.fromJson<String>(json['genre']),
      readAt: serializer.fromJson<DateTime>(json['readAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'url': serializer.toJson<String>(url),
      'mangaSlug': serializer.toJson<String>(mangaSlug),
      'chapterSlug': serializer.toJson<String>(chapterSlug),
      'thumbnail': serializer.toJson<String>(thumbnail),
      'type': serializer.toJson<String>(type),
      'lastChapter': serializer.toJson<String>(lastChapter),
      'lastPage': serializer.toJson<int>(lastPage),
      'genre': serializer.toJson<String>(genre),
      'readAt': serializer.toJson<DateTime>(readAt),
    };
  }

  History copyWith({
    int? id,
    String? title,
    String? url,
    String? mangaSlug,
    String? chapterSlug,
    String? thumbnail,
    String? type,
    String? lastChapter,
    int? lastPage,
    String? genre,
    DateTime? readAt,
  }) => History(
    id: id ?? this.id,
    title: title ?? this.title,
    url: url ?? this.url,
    mangaSlug: mangaSlug ?? this.mangaSlug,
    chapterSlug: chapterSlug ?? this.chapterSlug,
    thumbnail: thumbnail ?? this.thumbnail,
    type: type ?? this.type,
    lastChapter: lastChapter ?? this.lastChapter,
    lastPage: lastPage ?? this.lastPage,
    genre: genre ?? this.genre,
    readAt: readAt ?? this.readAt,
  );
  History copyWithCompanion(HistoriesCompanion data) {
    return History(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      url: data.url.present ? data.url.value : this.url,
      mangaSlug: data.mangaSlug.present ? data.mangaSlug.value : this.mangaSlug,
      chapterSlug: data.chapterSlug.present
          ? data.chapterSlug.value
          : this.chapterSlug,
      thumbnail: data.thumbnail.present ? data.thumbnail.value : this.thumbnail,
      type: data.type.present ? data.type.value : this.type,
      lastChapter: data.lastChapter.present
          ? data.lastChapter.value
          : this.lastChapter,
      lastPage: data.lastPage.present ? data.lastPage.value : this.lastPage,
      genre: data.genre.present ? data.genre.value : this.genre,
      readAt: data.readAt.present ? data.readAt.value : this.readAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('History(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('mangaSlug: $mangaSlug, ')
          ..write('chapterSlug: $chapterSlug, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('type: $type, ')
          ..write('lastChapter: $lastChapter, ')
          ..write('lastPage: $lastPage, ')
          ..write('genre: $genre, ')
          ..write('readAt: $readAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    url,
    mangaSlug,
    chapterSlug,
    thumbnail,
    type,
    lastChapter,
    lastPage,
    genre,
    readAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is History &&
          other.id == this.id &&
          other.title == this.title &&
          other.url == this.url &&
          other.mangaSlug == this.mangaSlug &&
          other.chapterSlug == this.chapterSlug &&
          other.thumbnail == this.thumbnail &&
          other.type == this.type &&
          other.lastChapter == this.lastChapter &&
          other.lastPage == this.lastPage &&
          other.genre == this.genre &&
          other.readAt == this.readAt);
}

class HistoriesCompanion extends UpdateCompanion<History> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> url;
  final Value<String> mangaSlug;
  final Value<String> chapterSlug;
  final Value<String> thumbnail;
  final Value<String> type;
  final Value<String> lastChapter;
  final Value<int> lastPage;
  final Value<String> genre;
  final Value<DateTime> readAt;
  const HistoriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.url = const Value.absent(),
    this.mangaSlug = const Value.absent(),
    this.chapterSlug = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.type = const Value.absent(),
    this.lastChapter = const Value.absent(),
    this.lastPage = const Value.absent(),
    this.genre = const Value.absent(),
    this.readAt = const Value.absent(),
  });
  HistoriesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String url,
    required String mangaSlug,
    required String chapterSlug,
    required String thumbnail,
    required String type,
    required String lastChapter,
    this.lastPage = const Value.absent(),
    this.genre = const Value.absent(),
    this.readAt = const Value.absent(),
  }) : title = Value(title),
       url = Value(url),
       mangaSlug = Value(mangaSlug),
       chapterSlug = Value(chapterSlug),
       thumbnail = Value(thumbnail),
       type = Value(type),
       lastChapter = Value(lastChapter);
  static Insertable<History> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? url,
    Expression<String>? mangaSlug,
    Expression<String>? chapterSlug,
    Expression<String>? thumbnail,
    Expression<String>? type,
    Expression<String>? lastChapter,
    Expression<int>? lastPage,
    Expression<String>? genre,
    Expression<DateTime>? readAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (url != null) 'url': url,
      if (mangaSlug != null) 'manga_slug': mangaSlug,
      if (chapterSlug != null) 'chapter_slug': chapterSlug,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (type != null) 'type': type,
      if (lastChapter != null) 'last_chapter': lastChapter,
      if (lastPage != null) 'last_page': lastPage,
      if (genre != null) 'genre': genre,
      if (readAt != null) 'read_at': readAt,
    });
  }

  HistoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? url,
    Value<String>? mangaSlug,
    Value<String>? chapterSlug,
    Value<String>? thumbnail,
    Value<String>? type,
    Value<String>? lastChapter,
    Value<int>? lastPage,
    Value<String>? genre,
    Value<DateTime>? readAt,
  }) {
    return HistoriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      mangaSlug: mangaSlug ?? this.mangaSlug,
      chapterSlug: chapterSlug ?? this.chapterSlug,
      thumbnail: thumbnail ?? this.thumbnail,
      type: type ?? this.type,
      lastChapter: lastChapter ?? this.lastChapter,
      lastPage: lastPage ?? this.lastPage,
      genre: genre ?? this.genre,
      readAt: readAt ?? this.readAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (mangaSlug.present) {
      map['manga_slug'] = Variable<String>(mangaSlug.value);
    }
    if (chapterSlug.present) {
      map['chapter_slug'] = Variable<String>(chapterSlug.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String>(thumbnail.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (lastChapter.present) {
      map['last_chapter'] = Variable<String>(lastChapter.value);
    }
    if (lastPage.present) {
      map['last_page'] = Variable<int>(lastPage.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (readAt.present) {
      map['read_at'] = Variable<DateTime>(readAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('mangaSlug: $mangaSlug, ')
          ..write('chapterSlug: $chapterSlug, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('type: $type, ')
          ..write('lastChapter: $lastChapter, ')
          ..write('lastPage: $lastPage, ')
          ..write('genre: $genre, ')
          ..write('readAt: $readAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $HistoriesTable histories = $HistoriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [bookmarks, histories];
}

typedef $$BookmarksTableCreateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> idBookmarks,
      required String slug,
      required String title,
      required String url,
      required String thumbnail,
      required String type,
      Value<String> genre,
      Value<DateTime> savedAt,
    });
typedef $$BookmarksTableUpdateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> idBookmarks,
      Value<String> slug,
      Value<String> title,
      Value<String> url,
      Value<String> thumbnail,
      Value<String> type,
      Value<String> genre,
      Value<DateTime> savedAt,
    });

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idBookmarks => $composableBuilder(
    column: $table.idBookmarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnail => $composableBuilder(
    column: $table.thumbnail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genre => $composableBuilder(
    column: $table.genre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idBookmarks => $composableBuilder(
    column: $table.idBookmarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnail => $composableBuilder(
    column: $table.thumbnail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genre => $composableBuilder(
    column: $table.genre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idBookmarks => $composableBuilder(
    column: $table.idBookmarks,
    builder: (column) => column,
  );

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get thumbnail =>
      $composableBuilder(column: $table.thumbnail, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get genre =>
      $composableBuilder(column: $table.genre, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTable,
          Bookmark,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
          Bookmark,
          PrefetchHooks Function()
        > {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idBookmarks = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> thumbnail = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> genre = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
              }) => BookmarksCompanion(
                idBookmarks: idBookmarks,
                slug: slug,
                title: title,
                url: url,
                thumbnail: thumbnail,
                type: type,
                genre: genre,
                savedAt: savedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> idBookmarks = const Value.absent(),
                required String slug,
                required String title,
                required String url,
                required String thumbnail,
                required String type,
                Value<String> genre = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
              }) => BookmarksCompanion.insert(
                idBookmarks: idBookmarks,
                slug: slug,
                title: title,
                url: url,
                thumbnail: thumbnail,
                type: type,
                genre: genre,
                savedAt: savedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTable,
      Bookmark,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
      Bookmark,
      PrefetchHooks Function()
    >;
typedef $$HistoriesTableCreateCompanionBuilder =
    HistoriesCompanion Function({
      Value<int> id,
      required String title,
      required String url,
      required String mangaSlug,
      required String chapterSlug,
      required String thumbnail,
      required String type,
      required String lastChapter,
      Value<int> lastPage,
      Value<String> genre,
      Value<DateTime> readAt,
    });
typedef $$HistoriesTableUpdateCompanionBuilder =
    HistoriesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> url,
      Value<String> mangaSlug,
      Value<String> chapterSlug,
      Value<String> thumbnail,
      Value<String> type,
      Value<String> lastChapter,
      Value<int> lastPage,
      Value<String> genre,
      Value<DateTime> readAt,
    });

class $$HistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $HistoriesTable> {
  $$HistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mangaSlug => $composableBuilder(
    column: $table.mangaSlug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chapterSlug => $composableBuilder(
    column: $table.chapterSlug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnail => $composableBuilder(
    column: $table.thumbnail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastChapter => $composableBuilder(
    column: $table.lastChapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastPage => $composableBuilder(
    column: $table.lastPage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genre => $composableBuilder(
    column: $table.genre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $HistoriesTable> {
  $$HistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mangaSlug => $composableBuilder(
    column: $table.mangaSlug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chapterSlug => $composableBuilder(
    column: $table.chapterSlug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnail => $composableBuilder(
    column: $table.thumbnail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastChapter => $composableBuilder(
    column: $table.lastChapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastPage => $composableBuilder(
    column: $table.lastPage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genre => $composableBuilder(
    column: $table.genre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistoriesTable> {
  $$HistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get mangaSlug =>
      $composableBuilder(column: $table.mangaSlug, builder: (column) => column);

  GeneratedColumn<String> get chapterSlug => $composableBuilder(
    column: $table.chapterSlug,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thumbnail =>
      $composableBuilder(column: $table.thumbnail, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get lastChapter => $composableBuilder(
    column: $table.lastChapter,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastPage =>
      $composableBuilder(column: $table.lastPage, builder: (column) => column);

  GeneratedColumn<String> get genre =>
      $composableBuilder(column: $table.genre, builder: (column) => column);

  GeneratedColumn<DateTime> get readAt =>
      $composableBuilder(column: $table.readAt, builder: (column) => column);
}

class $$HistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HistoriesTable,
          History,
          $$HistoriesTableFilterComposer,
          $$HistoriesTableOrderingComposer,
          $$HistoriesTableAnnotationComposer,
          $$HistoriesTableCreateCompanionBuilder,
          $$HistoriesTableUpdateCompanionBuilder,
          (History, BaseReferences<_$AppDatabase, $HistoriesTable, History>),
          History,
          PrefetchHooks Function()
        > {
  $$HistoriesTableTableManager(_$AppDatabase db, $HistoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> mangaSlug = const Value.absent(),
                Value<String> chapterSlug = const Value.absent(),
                Value<String> thumbnail = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> lastChapter = const Value.absent(),
                Value<int> lastPage = const Value.absent(),
                Value<String> genre = const Value.absent(),
                Value<DateTime> readAt = const Value.absent(),
              }) => HistoriesCompanion(
                id: id,
                title: title,
                url: url,
                mangaSlug: mangaSlug,
                chapterSlug: chapterSlug,
                thumbnail: thumbnail,
                type: type,
                lastChapter: lastChapter,
                lastPage: lastPage,
                genre: genre,
                readAt: readAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String url,
                required String mangaSlug,
                required String chapterSlug,
                required String thumbnail,
                required String type,
                required String lastChapter,
                Value<int> lastPage = const Value.absent(),
                Value<String> genre = const Value.absent(),
                Value<DateTime> readAt = const Value.absent(),
              }) => HistoriesCompanion.insert(
                id: id,
                title: title,
                url: url,
                mangaSlug: mangaSlug,
                chapterSlug: chapterSlug,
                thumbnail: thumbnail,
                type: type,
                lastChapter: lastChapter,
                lastPage: lastPage,
                genre: genre,
                readAt: readAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HistoriesTable,
      History,
      $$HistoriesTableFilterComposer,
      $$HistoriesTableOrderingComposer,
      $$HistoriesTableAnnotationComposer,
      $$HistoriesTableCreateCompanionBuilder,
      $$HistoriesTableUpdateCompanionBuilder,
      (History, BaseReferences<_$AppDatabase, $HistoriesTable, History>),
      History,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$HistoriesTableTableManager get histories =>
      $$HistoriesTableTableManager(_db, _db.histories);
}
