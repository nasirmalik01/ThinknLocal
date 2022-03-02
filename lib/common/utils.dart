import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

import '../res/strings.dart';

class PreferenceUtils {
  static String? userImage;
  var time = DateTime;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String? getString(String key, [String? defValue]) {
    if (PreferenceUtils._prefsInstance != null)
      return _prefsInstance?.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;

    return prefs.setString(key, value); //?? Future.value(null);
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value); //?? Future.value(null);
  }

  static bool getBool(String key, [bool? defValue]) {
    return _prefsInstance?.getBool(key) ?? defValue ?? false;
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;

    return prefs.setInt(key, value); //?? Future.value(null);
  }

  static int getInt(String key, [int? defValue]) {
    return _prefsInstance?.getInt(key) ?? defValue ?? 0;
  }

  static Future setUploadImage(uploadProfilePictureResponse) async {
    PreferenceUtils.setString(
        Strings.filePath, uploadProfilePictureResponse.data!.message!);
  }

  static setUserImage(String? image) {
    PreferenceUtils.setString(Strings.userImageKey, image!);
  }

  static String? getUserImage() {
    userImage = PreferenceUtils.getString(Strings.userImageKey)!;
    return userImage;
  }

  // static Future setLoginResponse(loginResponse) async {
  //   if (loginResponse.data.subscription.isEmpty) {
  //     await PreferenceUtils.setBool(Strings.isSubscription, false);
  //   } else {
  //     await PreferenceUtils.setBool(Strings.isSubscription, true);
  //     PreferenceUtils.setString(
  //         Strings.userSubscriptionPlanKey, loginResponse.data?.subscription[0].subscriptionPlan ?? "");
  //   }
  //   await PreferenceUtils.setInt(
  //       Strings.loginUserId, loginResponse.data?.userId ?? 0);
  //   await PreferenceUtils.setString(
  //       Strings.loginName, loginResponse.data?.name ?? "");
  //
  //   PreferenceUtils.setString(
  //       Strings.loginEmail, loginResponse.data?.email ?? "");
  //
  //   PreferenceUtils.setString(
  //       Strings.loginPhoneNo, loginResponse.data?.phone ?? "");
  //   PreferenceUtils.setString(
  //       Strings.loginPassword, loginResponse.data?.password ?? "");
  //   PreferenceUtils.setString(
  //       Strings.loginProfilePicture, loginResponse.data?.profilePicture ?? "");
  //   PreferenceUtils.setInt(
  //       Strings.loginUserTypeId, loginResponse.data?.userTypeId ?? 0);
  //   PreferenceUtils.setString(
  //       Strings.loginUserType, loginResponse.data?.userType ?? "");
  //   PreferenceUtils.setString(
  //       Strings.loginDeviceId, loginResponse.data?.deviceId ?? "");
  //
  //
  //   // PreferenceUtils.setString(Strings.userSubscriptionPlanKey,
  //   //     loginResponse.data?.subscription[0].subscriptionPlan ?? "");
  // }
  //
  // // --- Google and Facebook Login --- //
  // static Future setSocialLoginResponse(socialLoginResponse) async {
  //   if (socialLoginResponse.data.subscription.isEmpty) {
  //     await PreferenceUtils.setBool(Strings.isSubscription, false);
  //   } else {
  //     await PreferenceUtils.setBool(Strings.isSubscription, true);
  //     PreferenceUtils.setString(
  //         Strings.userSubscriptionPlanKey, socialLoginResponse.data?.subscription[0].subscriptionPlan ?? "");
  //   }
  //   await PreferenceUtils.setInt(
  //       Strings.loginUserId, socialLoginResponse.data?.userId ?? 0);
  //   await PreferenceUtils.setString(
  //       Strings.loginName, socialLoginResponse.data?.name ?? "");
  //   await PreferenceUtils.setString(
  //       Strings.loginEmail, socialLoginResponse.data?.email ?? "");
  //   PreferenceUtils.setString(
  //       Strings.loginPhoneNo, socialLoginResponse.data?.phone ?? "");
  //   PreferenceUtils.setString(
  //       Strings.loginPassword, socialLoginResponse.data?.password ?? "");
  //   PreferenceUtils.setString(Strings.loginProfilePicture,
  //       socialLoginResponse.data?.profilePicture ?? "");
  //   PreferenceUtils.setInt(
  //       Strings.loginUserTypeId, socialLoginResponse.data?.userTypeId ?? "");
  //   PreferenceUtils.setString(
  //       Strings.loginUserType, socialLoginResponse.data?.userType ?? "");
  //   PreferenceUtils.setString(
  //       Strings.loginDeviceId, socialLoginResponse.data?.deviceId ?? "");
  //
  //   // PreferenceUtils.setString(Strings.userSubscriptionPlanKey,
  //   //     socialLoginResponse.data?.subscription[0].subscriptionPlan ?? "");
  // }
  //
  // static Future setSignUpResponse(SignUpResponse signUpResponse) async {
  //   PreferenceUtils.setInt(
  //       Strings.signUpUserId, signUpResponse.data?.userId ?? 0);
  //   PreferenceUtils.setString(
  //       Strings.signUpName, signUpResponse.data?.name ?? "");
  //   PreferenceUtils.setString(
  //       Strings.signUpEmail, signUpResponse.data?.email ?? "");
  //   PreferenceUtils.setString(
  //       Strings.signUpPhoneNo, signUpResponse.data?.phone ?? "");
  //   PreferenceUtils.setString(
  //       Strings.signUpPassword, signUpResponse.data?.password ?? "");
  //   PreferenceUtils.setString(Strings.signUpProfilePicture,
  //       signUpResponse.data?.profilePicture ?? "");
  //   PreferenceUtils.setInt(
  //       Strings.signUpUserTypeId, signUpResponse.data?.userTypeId ?? 0);
  //   PreferenceUtils.setString(
  //       Strings.signUpUserType, signUpResponse.data?.userType ?? "");
  //   PreferenceUtils.setString(
  //       Strings.signUpDeviceId, signUpResponse.data?.deviceId ?? "");
  // }
  //
  // static Future setEditProfileResponse(
  //     EditProfileResponse editProfileResponse) async {
  //   await PreferenceUtils.setInt(
  //       Strings.loginUserId, editProfileResponse.data?.userId ?? 0);
  //   await PreferenceUtils.setString(
  //       Strings.loginName, editProfileResponse.data?.name ?? "");
  //   PreferenceUtils.setString(
  //       Strings.loginEmail, editProfileResponse.data?.email ?? "");
  //   PreferenceUtils.setString(
  //       Strings.loginPhoneNo, editProfileResponse.data?.phone ?? "");
  //   PreferenceUtils.setString(
  //       Strings.loginPassword, editProfileResponse.data?.password ?? "");
  //   PreferenceUtils.setString(Strings.loginProfilePicture,
  //       editProfileResponse.data?.profilePicture ?? "");
  //   PreferenceUtils.setInt(
  //       Strings.loginUserTypeId, editProfileResponse.data?.userTypeId ?? 0);
  //   PreferenceUtils.setString(
  //       Strings.loginUserType, editProfileResponse.data?.userType ?? "");
  //   PreferenceUtils.setString(
  //       Strings.loginDeviceId, editProfileResponse.data?.deviceId ?? "");
  //
  //   // PreferenceUtils.setInt(
  //   //     Strings.editProfileUserId, editProfileResponse.data?.userId ?? 0);
  //   // PreferenceUtils.setString(
  //   //     Strings.editProfileName, editProfileResponse.data?.name ?? "");
  //   // PreferenceUtils.setString(
  //   //     Strings.editProfileEmail, editProfileResponse.data?.email ?? "");
  //   // PreferenceUtils.setString(
  //   //     Strings.editProfilePhoneNo, editProfileResponse.data?.phone ?? "");
  //   // PreferenceUtils.setString(
  //   //     Strings.editProfilePassword, editProfileResponse.data?.password ?? "");
  //   // PreferenceUtils.setString(Strings.editProfilePicture,
  //   //     editProfileResponse.data?.profilePicture ?? "");
  //   // PreferenceUtils.setInt(Strings.editProfileUserTypeId,
  //   //     editProfileResponse.data?.userTypeId ?? 0);
  //   // PreferenceUtils.setString(
  //   //     Strings.editProfileUserType, editProfileResponse.data?.userType ?? "");
  //   // PreferenceUtils.setString(
  //   //     Strings.editProfileDeviceId, editProfileResponse.data?.deviceId ?? "");
  //   //
  //   //
  // }


  static clearPreferences() {
    _prefsInstance?.clear();
  }
}
