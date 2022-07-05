import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_help_scout/flutter_help_scout.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/local/my_hive.dart';
import 'package:thinknlocal_app/model/account.dart';
import 'package:thinknlocal_app/network/remote_repositories/profile_repository.dart';
import 'package:thinknlocal_app/network/remote_services.dart';
import 'package:get/get.dart';

class AccountController extends GetxController{
  bool isPushNotificationsEnabled = MyHive.isPushNotificationsEnabled();
  bool isEmailEnabled = MyHive.isEmailEnabled();
  bool isLocationServicesEnabled = MyHive.isLocationServicesEnabled();
  RxBool isPushNotifications = false.obs;
  RxBool isEmail = false.obs;
  RxBool isLocation = true.obs;
  RxBool isOtherOption = false.obs;
  RxBool isOtherOption2 = false.obs;
  Account? account;
  RxBool isLoading = false.obs;
  RxBool isEditDataLoading = false.obs;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  late FlutterHelpScout _beacon;
  String beaconId = 'cd97e8db-7fc6-4dd9-9147-27f46817fd60';

  @override
  void onInit() {
    isPushNotifications.value = isPushNotificationsEnabled;
    isEmail.value = isEmailEnabled;
    isLocation.value = isLocationServicesEnabled;
    initBeacon();
    super.onInit();
  }

  void changePushNotificationValue(bool value) {
    MyHive.setPushNotificationsEnabled(value);
    isPushNotifications.value = value;
  }

  void changeEmailValue(bool value) {
    MyHive.setEmailEnabled(value);
    isEmail.value = value;
  }

  void changeLocationServicesValue(bool value) {
    MyHive.setLocationServicesEnabled(value);
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

  Future<void> initBeacon() async {
    _beacon = FlutterHelpScout(
        beaconId: beaconId,
    );
    try {
      _beacon.initialize();
    } on PlatformException catch (e) {
      debugPrint('${e.message}');
    }
  }

  openBeacon(){
     _beacon.open(beaconId: beaconId);
  }
}