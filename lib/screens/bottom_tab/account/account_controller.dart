import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/model/account.dart';
import 'package:flutter_app/network/remote_repository.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class AccountController extends GetxController{
  RxBool isPushNotifications = false.obs;
  RxBool isEmail = false.obs;
  RxBool isLocation = false.obs;
  RxBool isOtherOption = false.obs;
  RxBool isOtherOption2 = false.obs;
  late Account account;
  RxBool isLoading = false.obs;


  // @override
  // void onInit() {
  //   getProfileInfo();
  //   super.onInit();
  // }

  void changePushNotificationValue(bool value) {
    isPushNotifications.value = value;
  }

  void changeEmailValue(bool value) {
    isEmail.value = value;
  }

  void changeLocationServicesValue(bool value) {
    isLocation.value = value;
  }

  void changeOtherOptionValue(bool value) {
    isOtherOption.value = value;
  }

  void changeOtherOption2Value(bool value) {
    isOtherOption2.value = value;
  }

  getProfileInfo() async {
    isLoading.value = true;
    account = (await RemoteRepository.fetchProfileInfo({}))!;
    isPushNotifications.value = account.settings!.pushNotifications ?? false;
    isLoading.value = false;
  }
}