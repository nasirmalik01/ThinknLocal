import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class LogInController extends GetxController{

  authenticateUser({String? email, String? password}) async {
    final response = await GetIt.I<RemoteServices>().postRequest('authenticate', {
      'email': email,
      'password': password,
    });

    /// if any Exception occurs
    if (response == null) {
      return;
    }

    await MyHive.setToken(response['token']);

    Get.back();
    PreferenceUtils.setBool(Strings.showHome, true);
    Get.offAndToNamed(Routes.bottomNavBarScreen);
  }
}