import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/model/account.dart';
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
  RxBool isEditDataLoading = false.obs;
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
    account = await ProfileRemoteRepository.fetchProfileInfo({});
    if(RemoteServices.statusCode != 200 && RemoteServices.statusCode != 201 && RemoteServices.statusCode != 204){
      isError.value = true;
      isLoading.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
    isPushNotifications.value = account?.settings?.pushNotifications ?? false;
    isEmail.value = account?.settings?.weeklyUpdates ?? false;
    isLoading.value = false;
  }

  editAccountInfo(Map<String, dynamic> body) async {
    showLoadingDialog(message: 'Loading ...');
    isEditDataLoading.value = true;
    account = await ProfileRemoteRepository.editAccountInfo(body);
    if(RemoteServices.statusCode != 200 && RemoteServices.statusCode != 201 && RemoteServices.statusCode != 204){
      isError.value = true;
      isLoading.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
    Get.back();
    isEditDataLoading.value = false;
  }



}