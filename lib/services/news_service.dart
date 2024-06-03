import 'package:chopper/chopper.dart';
part 'news_service.chopper.dart';

@ChopperApi(baseUrl: '/v2')
abstract class NewsService extends ChopperService {
  static NewsService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('https://newsapi.org'),
      services: [_$NewsService()],
      converter: const JsonConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    return _$NewsService(client);
  }

  @Get(path: '/everything')
  Future<Response<Map<String, dynamic>>> getNews(
    @Query('q') String query,
    @Query('from') String fromDate,
    @Query('sortBy') String sortBy,
    @Query('apiKey') String apiKey,
  );

  static NewsService instance = create();
}

