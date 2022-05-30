import 'dart:developer';

import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';


class LogInController extends GetxController{
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;

  loginWithEmailPassword({String? email, String? password}) async {
    final response = await GetIt.I<RemoteServices>().postRequest(ApiEndPoints.authenticate, {
      Strings.email: email,
      Strings.password: password,
    });

    if (response != null) {
      String token = response['token'];
      await MyHive.setToken(token);
      Get.back();
      PreferenceUtils.setBool(Strings.showHome, true);
      Get.offAndToNamed(Routes.bottomNavBarScreen);
    }
  }

  loginWithApple() async {
    final credentials = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    print(credentials);
  }

  loginWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? account = await googleSignIn.signIn();
    log(account?.email ?? ' Null');
  }
}