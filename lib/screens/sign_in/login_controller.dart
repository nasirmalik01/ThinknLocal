import 'dart:developer';

import 'package:flutter_app/common/methods.dart';
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

class LogInController extends GetxController {
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isEmptyTextFieldValues = false.obs;
  RxBool isPasswordShort = false.obs;

  loginWithEmailPassword({String? email, String? password}) async {
    Map<String, dynamic> _query = {
      Strings.email: email,
      Strings.password: password,
    };
    authenticateUser(query: _query);
  }

  loginWithApple({String? zip}) async {
    try {
      final credentials = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      Map<String, dynamic> _query = {
        Strings.provider: Strings.apple,
        Strings.authorization: credentials.identityToken.toString(),
        Strings.zip: zip ?? '',
      };

      showLoadingDialog(message: 'Authenticating User');
      await authenticateUser(query: _query, provider: Strings.apple);

    }catch(e){
      log(e.toString());
    }
  }

  loginWithGoogle({String? zip}) async {
    try{
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? account = await googleSignIn.signIn();
      var credentials = await account?.authentication;

      Map<String, dynamic> _query = {
        Strings.provider: Strings.google,
        Strings.authorization: credentials?.idToken.toString(),
        Strings.zip: zip ?? '',
      };

      showLoadingDialog(message: 'Authenticating User');
      await authenticateUser(query: _query, provider: Strings.google);
    }catch(e){
      log('Error: ${e.toString()}');
    }
  }

  Future<void> authenticateUser({required Map<String, dynamic> query, String? provider}) async {
    final response = await GetIt.I<RemoteServices>().postRequest(ApiEndPoints.authenticate, query);

    if(RemoteServices.isZipRequired){
      Get.toNamed(Routes.requiredParamsScreen, arguments: provider);
      showSnackBar(subTitle: Strings.requiredFieldError);
    }

    if (response != null) {
      String token = response['token'];
      await MyHive.setToken(token);
      Get.back();
      PreferenceUtils.setBool(Strings.showHome, true);
      Get.offAndToNamed(Routes.bottomNavBarScreen);
    }
  }
}
