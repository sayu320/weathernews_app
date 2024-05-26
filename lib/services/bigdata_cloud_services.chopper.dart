// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bigdata_cloud_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$BigDataCloudService extends BigDataCloudService {
  _$BigDataCloudService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = BigDataCloudService;

  @override
  Future<Response<Map<String, dynamic>>> getCityName(
    double latitude,
    double longitude,
    String localityLanguage,
  ) {
    final Uri $url = Uri.parse('reverse-geocode-client');
    final Map<String, dynamic> $params = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'localityLanguage': localityLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
