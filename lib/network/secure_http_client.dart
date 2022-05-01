import 'package:dio/dio.dart';
import 'package:flutter_app/local/my_hive.dart';

class MySecureHttpClient {
  static Dio? secureClient;
  static Dio? insecureClient;

  static Dio getClient() {
    secureClient ??= Dio(BaseOptions(baseUrl: 'https://staging-api.thinknlocal.com/v2/', headers: {
      'Authorization': MyHive.getToken() ?? 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOm51bGwsImRhdGEiOm51bGx9.rTBYjY035F8ni5Jprku9A_YTugZGMp3G3n7xgNX-Gqw',
    },
        responseType: ResponseType.plain

    ),
    );
    return secureClient!;

  }

  static Dio getInsecureClient() {
    return insecureClient ??= Dio(BaseOptions(baseUrl: 'https://staging-api.thinknlocal.com/v2/'));
  }
}
