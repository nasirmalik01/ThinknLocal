import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '/common/methods.dart';
import '/constants/colors.dart';
import '/constants/routes.dart';
import '/network/remote_services.dart';

class ResetPasswordController extends GetxController {
  Future resetPassword(String? email) async {
    final response =
        await GetIt.I<RemoteServices>().postRequest('password_reset', {
      'email': email,
    });

    /// if any Exception occurs
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
