import 'package:thinknlocal_app/network/remote_repositories/auth_repository.dart';
import 'package:get/get.dart';

import '/common/methods.dart';
import '/constants/colors.dart';
import '/constants/routes.dart';

class ResetPasswordController extends GetxController {
  Future resetPassword(String? email) async {
    final response = await AuthRepository.resetPassword(email: email!);
    if (response == null) {
      return;
    }
    await showSnackBar(
        title: 'Reset Code Sent', backgroundColor: AppColors.greenColor);
    Get.offAndToNamed(
      Routes.resetPinScreen,
      arguments: email,
    );
  }
}
