import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '/common/methods.dart';
import '/constants/colors.dart';
import '/constants/routes.dart';
import '/network/remote_services.dart';

class ResetPasswordPinController extends GetxController {
  Future verifyResetPin(String email, String pin) async {
    final response =
    await GetIt.I<RemoteServices>().postRequest(ApiEndPoints.resetPin, {
      'email': email,
      'password_reset_code' : pin,
    });

    /// if any Exception occurs
    if (response == null) {
      return;
    }
    Map<String, dynamic> _map = {'email' : email, 'token' : response['reset_token'],};
    await showSnackBar(
        title: 'Verified', backgroundColor: AppColors.greenColor);
    Get.offAndToNamed(
      Routes.newPasswordScreen,
      arguments: _map,
    );
  }
}