import 'package:dio/dio.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/my_hive.dart';

class MySecureHttpClient {
  static Dio? secureClient;
  static Dio? insecureClient;

  static Dio getClient() {
    return Dio(
      BaseOptions(
        baseUrl: Strings.baseUrl,
        headers: {
          'Authorization': Strings.testingToken,
        },
        responseType: ResponseType.plain,
      ),
    );
  }

  static Dio getInsecureClient() {
    return insecureClient ??=
        Dio(BaseOptions(baseUrl: 'https://staging-api.thinknlocal.com/v2/'));
  }

  static Dio getTestingClient() {
    var testCliecnt = Dio(
      BaseOptions(
        baseUrl: Strings.baseUrl,
        headers: {
          'Authorization': Strings.testingToken,
        },
        responseType: ResponseType.plain,
      ),
    );
    return testCliecnt;
  }
}
