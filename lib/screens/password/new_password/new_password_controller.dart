import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '/common/methods.dart';
import '/constants/api_endpoints.dart';
import '/constants/colors.dart';
import '/constants/routes.dart';
import '/network/remote_services.dart';

class NewPasswordController extends GetxController {

  newPassword(String email, String token, String password) async {
    final response =
        await GetIt.I<RemoteServices>().patchRequest(ApiEndPoints.resetPassword, {
          'reset_token' : token,
          'password' : password,
          'password_confirmation' : password,
          'email': email,

    });

    /// if any Exception occurs
    if (response == null) {
      return;
    }

    await showSnackBar(
        title: 'Password Successfully Changed', backgroundColor: AppColors.greenColor);
    Get.offAndToNamed(
      Routes.resetPasswordSuccessScreen,
    );
  }
}