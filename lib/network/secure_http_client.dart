import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/app_info.dart';
import 'package:flutter_app/local/my_hive.dart';

class MySecureHttpClient {
  static Dio? secureClient;
  static Dio? insecureClient;

  static Dio getClient() {
    AppInfo appInfo = MyHive.getAppInfo();

    return Dio(
      BaseOptions(
        baseUrl: Strings.baseUrl,
        headers: {
            'Authorization': MyHive.getToken(),
            'App-Version': '${appInfo.appVersion == '' ? '2.0.0' : appInfo.appVersion}+${appInfo.buildNumber}'

          /// For test cases use below token
          // 'Authorization': Strings.testingToken,
        },
        responseType: ResponseType.plain,
      ),
    );
  }

  static Dio getInsecureClient() {
    return insecureClient ??=
        Dio(BaseOptions(baseUrl: 'https://staging-api.thinknlocal.com/v2/'));
  }
}
