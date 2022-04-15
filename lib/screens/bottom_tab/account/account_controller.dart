import 'package:get/get.dart';

class AccountController extends GetxController{
  RxBool isPushNotifications = false.obs;
  RxBool isEmail = false.obs;
  RxBool isLocation = false.obs;
  RxBool isOtherOption = false.obs;
  RxBool isOtherOption2 = false.obs;

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
}