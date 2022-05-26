import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/network/remote_repositories/auth_repository.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class LogInController extends GetxController {
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;

  authenticateUser({String? email, String? password}) async {
    final response =
        await AuthRepository.login(email: email!, password: password!);
    if (response != null) {
      String token = response['token'];
      await MyHive.setToken(token);
      Get.back();
      PreferenceUtils.setBool(Strings.showHome, true);
      Get.offAndToNamed(Routes.bottomNavBarScreen);
    }
  }
}
