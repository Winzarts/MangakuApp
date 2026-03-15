import 'package:chopper/chopper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'mangaServices.chopper.dart';

String baseUrl = dotenv.env['BASE_URL'] ?? '';

@ChopperApi()
abstract class Mangaservices extends ChopperService {
  //✅
  @Get(path: '/manga/{slug}')
  Future<Response<dynamic>> getDetailManga(@Path('slug') String slug);

  @Get(path: '/manga/{slug}/{chapter-slug}/')
  Future<Response<dynamic>> getManga(
    @Path('slug') String slug,
    @Path('chapter-slug') String chapterSlug,
  );

  @Get(path: '/search')
  Future<Response<dynamic>> SearchManga(@Query('q') String query);

  @Get(path: '/genre')
  Future<Response<dynamic>> getGenre();

  @Get(path: '/genre/{genre}')
  Future<Response<dynamic>> getMangaByGenre(@Path('genre') String genre);

  @Get(path: '/list-semua-komik')
  Future<Response<dynamic>> getAllMangaList();

  @Get(path: '/list-manga')
  Future<Response<dynamic>> getMangaList();

  @Get(path: '/list-manhua')
  Future<Response<dynamic>> getManhuaList();

  @Get(path: '/list-manhwa')
  Future<Response<dynamic>> getManhwaList();

  //✅
  @Get(path: '/popular')
  Future<Response<dynamic>> getPopularManga();

  //✅
  @Get(path: '/popular-manga')
  Future<Response<dynamic>> getPopularMangaList();

  //✅
  @Get(path: '/popular-manhua')
  Future<Response<dynamic>> getPopularManhuaList();

  //✅
  @Get(path: '/popular-manhwa')
  Future<Response<dynamic>> getPopularManhwaList();

  //✅
  @Get(path: '/latest')
  Future<Response<dynamic>> getLatestManga();

  //✅
  @Get(path: '/latest-manga')
  Future<Response<dynamic>> getLatestMangaList();

  //✅
  @Get(path: '/latest-manhua')
  Future<Response<dynamic>> getLatestManhuaList();

  //✅
  @Get(path: '/latest-manhwa')
  Future<Response<dynamic>> getLatestManhwaList();

  static Mangaservices create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(baseUrl),
      services: [_$Mangaservices()],
      converter: JsonConverter(),
    );
    return _$Mangaservices(client);
  }
}
