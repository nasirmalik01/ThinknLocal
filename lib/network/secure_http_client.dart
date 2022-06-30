import 'package:dio/dio.dart';
import 'package:thinknlocal_app/constants/routes.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/local/app_info.dart';
import 'package:thinknlocal_app/local/my_hive.dart';
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

          /// For test cases use below tokenh
          // 'Authorization': Strings.testingToken,
        },
        responseType: ResponseType.plain,
      ),
    );
  }

  static Dio getInsecureClient() {
    return insecureClient ??=
        Dio(BaseOptions(baseUrl: 'https://api.thinknlocal.com/v2/'));
  }

  static checkPermissions() async {
    PermissionStatus status = await Permission.location.status;
    if (status == PermissionStatus.permanentlyDenied) {
      Get.offAllNamed(Routes.locationPermissionScreen);
    }
  }
}
