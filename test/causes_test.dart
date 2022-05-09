import 'package:dio/dio.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  final secureRepository = Dio(BaseOptions(baseUrl: Strings.baseUrl, headers: {
    'Authorization': Strings.dummyToken,
  }, responseType: ResponseType.plain
  ),);

  test('Causes', () async {
    dynamic _response = await secureRepository.get(ApiEndPoints.causes, queryParameters: {
      Strings.featured : true,
      Strings.active: true
    });

    expect(_response.statusCode, 200);
  });

  test('Recently Started Causes', () async {
      dynamic _response = await secureRepository.get(ApiEndPoints.causes, queryParameters: {
        Strings.featured : true,
        Strings.recent: true
      });

      expect(_response.statusCode, 200);
  });

  test('Upcoming Causes', () async {
    dynamic _response = await secureRepository.get(ApiEndPoints.causes, queryParameters: {
      Strings.featured : true,
      Strings.upcoming: true
    });

    expect(_response.statusCode, 200);
  });

}