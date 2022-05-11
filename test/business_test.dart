import 'package:dio/dio.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  final secureRepository = Dio(BaseOptions(baseUrl: Strings.baseUrl, headers: {
    'Authorization': Strings.dummyToken,
  }, responseType: ResponseType.plain
  ),);

  test('Business', () async {
    dynamic _response = await secureRepository.get(ApiEndPoints.businesses, queryParameters: {});
    expect(_response.statusCode, 200);
  });


  test('Nearby Businesses', () async {
    dynamic _response = await secureRepository.get(ApiEndPoints.businesses, queryParameters: {
      Strings.nearby: true,
    });

    expect(_response.statusCode, 200);
  });

}