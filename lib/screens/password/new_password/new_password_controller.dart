import 'package:flutter_app/network/remote_repositories/auth_repository.dart';
import 'package:get/get.dart';
import '/common/methods.dart';
import '/constants/colors.dart';
import '/constants/routes.dart';

class NewPasswordController extends GetxController {
  newPassword(String email, String token, String password) async {
    final response = await AuthRepository.setNewPassword(
        token: token,
        password: password,
        confirmPassowrd: password,
        email: email);

    /// if any Exception occurs
    if (response == null) {
      return;
    }

    await showSnackBar(
        title: 'Password Successfully Changed',
        backgroundColor: AppColors.greenColor);
    Get.offAndToNamed(
      Routes.resetPasswordSuccessScreen,
    );
  }
}
