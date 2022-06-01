
import 'package:flutter_app/network/remote_repositories/auth_repository.dart';
import 'package:get/get.dart';
import '/common/methods.dart';
import '/constants/colors.dart';
import '/constants/routes.dart';

class ResetPasswordPinController extends GetxController {
  Future verifyResetPin(String email, String pin) async {
    final response =
        await AuthRepository.verifyResetPin(email: email, pin: pin);

    /// if any Exception occurs
    if (response == null) {
      return;
    }
    Map<String, dynamic> _map = {
      'email': email,
      'token': response['reset_token'],
    };
    await showSnackBar(
        title: 'Verified', backgroundColor: AppColors.greenColor);
    Get.offAndToNamed(
      Routes.newPasswordScreen,
      arguments: _map,
    );
  }
}
