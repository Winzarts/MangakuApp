import "package:chopper/chopper.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

part "mangaServices.chopper.dart";

@ChopperApi()
abstract class MangaServices extends ChopperService {
  @Get(path: '/manga/{slug}')
  Future<Response<dynamic>> getMangaDetail(@Path('slug') String slug);

  @Get(path: '/manga/{slug}/{chapter-slug}')
  Future<Response<dynamic>> getChapterDetail(
    @Path('slug') String slug,
    @Path('chapter-slug') String chapterSlug,
  );

  @Get(path: '/search')
  Future<Response<dynamic>> searchManga(@Query('q') String query);

  @Get(path: '/genre')
  Future<Response<dynamic>> getGenre();

  @Get(path: '/genre/{genre-slug}')
  Future<Response<dynamic>> getGenreDetail(@Path('genre-slug') String genreSlug);

  @Get(path: '/list-semua-komik')
  Future<Response<dynamic>> getAllManga(
    @Query('page') int page,
  );

  @Get(path: '/list-manga')
  Future<Response<dynamic>> getListManga(
    @Query('page') int page,
  );

  @Get(path: '/list-manhua')
  Future<Response<dynamic>> getListManhua(
    @Query('page') int page,
  );

  @Get(path: '/list-manhwa')
  Future<Response<dynamic>> getListManhwa(
    @Query('page') int page,
  );

  @Get(path: '/popular')
  Future<Response<dynamic>> getPopular();

  @Get(path: '/popular-manga')
  Future<Response<dynamic>> getPopularManga();

  @Get(path: '/popular-manhua')
  Future<Response<dynamic>> getPopularManhua();

  @Get(path: '/popular-manhwa')
  Future<Response<dynamic>> getPopularManhwa();

  @Get(path: '/latest')
  Future<Response<dynamic>> getLatest();

  @Get(path: '/latest-manga')
  Future<Response<dynamic>> getLatestManga();

  @Get(path: '/latest-manhua')
  Future<Response<dynamic>> getLatestManhua();

  @Get(path: '/latest-manhwa')
  Future<Response<dynamic>> getLatestManhwa();

  static MangaServices create() {
    final String baseUrl = dotenv.env["BASE_URL"] ?? "";
    final client = ChopperClient(
      baseUrl: Uri.parse(baseUrl),
      services: [_$MangaServices()],
      converter: const JsonConverter(),
      errorConverter: const JsonConverter(),
    );
    return _$MangaServices(client);
  }
}
