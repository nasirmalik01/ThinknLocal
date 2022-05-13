import 'package:flutter_app/model/dummy/account.dart';
import 'package:flutter_app/network/remote_repositories/profile_repository.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';

class AccountController extends GetxController{
  RxBool isPushNotifications = false.obs;
  RxBool isEmail = false.obs;
  RxBool isLocation = false.obs;
  RxBool isOtherOption = false.obs;
  RxBool isOtherOption2 = false.obs;
  Account? account;
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;



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
    account = (await ProfileRemoteRepository.fetchProfileInfo({}));
    if(RemoteServices.statusCode != 200 && RemoteServices.statusCode != 201 && RemoteServices.statusCode != 204){
      isError.value = true;
      isLoading.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
    isPushNotifications.value = account?.settings?.pushNotifications ?? false;
    isLoading.value = false;
  }
}