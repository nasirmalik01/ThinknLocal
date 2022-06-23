import 'package:dio/dio.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/app_info.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MySecureHttpClient {
  static Dio? secureClient;
  static Dio? insecureClient;

  static Dio getClient() {
    AppInfo appInfo = MyHive.getAppInfo();
    checkPermissions();

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

  static checkPermissions() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isDenied) {
      Get.offAllNamed(Routes.locationPermissionScreen);
    }
  }
}
