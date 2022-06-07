import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class SignUpController extends GetxController{
  RxBool isEmptyTextFieldValues = false.obs;
  RxBool isShortPassword = false.obs;
  RxBool isPasswordNotMatches = false.obs;
  RxBool isZipLengthNotFive = false.obs;

  Future registerUser({String? email, String? password, String? confirmPassword, String? firstName, String? lastName, String? zipCode, String? groupCode, String? businessId, String? causeId, String? organizationId}) async {
    final response = await GetIt.I<RemoteServices>().postRequest(ApiEndPoints.users, {
      Strings.email: email,
      Strings.password: password,
      Strings.passwordConfirmation: confirmPassword,
      Strings.firstName: firstName,
      Strings.lastName: lastName,
      Strings.zip: zipCode,
      Strings.groupCode: groupCode,
      Strings.businessId: businessId,
      Strings.causeId: causeId,
      Strings.organizationId: organizationId
    });

    /// if any Exception occurs
    if (response == null) {
      return;
    }

    /// User registered successfully
   Get.back();
   await showSnackBar(title: 'User Registered successfully', subTitle: 'Lets login with your credentials', backgroundColor: AppColors.greenColor);
   Get.offAndToNamed(Routes.loginScreen);
  }
}