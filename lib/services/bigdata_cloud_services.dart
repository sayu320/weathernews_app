import 'package:chopper/chopper.dart';
part 'bigdata_cloud_services.chopper.dart';

@ChopperApi()
abstract class BigDataCloudService extends ChopperService {
  @Get(path: 'reverse-geocode-client')
  Future<Response<Map<String, dynamic>>> getCityName(
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
    @Query('localityLanguage') String localityLanguage,
  );

  static BigDataCloudService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('https://api.bigdatacloud.net/data'),
      services: [_$BigDataCloudService()],
      converter: const JsonConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    return _$BigDataCloudService(client);
  }
}