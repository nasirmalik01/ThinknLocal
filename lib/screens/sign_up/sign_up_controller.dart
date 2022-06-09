import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/deep_link_info.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class SignUpController extends GetxController{
  RxBool isEmptyTextFieldValues = false.obs;
  RxBool isShortPassword = false.obs;
  RxBool isPasswordNotMatches = false.obs;
  RxBool isZipLengthNotFive = false.obs;

  Future registerUser({String? email, String? password, String? confirmPassword, String? firstName, String? lastName, String? zipCode, String? groupCode}) async {
    DeepLinkInfo? _deepLinkInfo = MyHive.getDeepLinkInfo();
    final response = await GetIt.I<RemoteServices>().postRequest(ApiEndPoints.users, {
      Strings.email: email,
      Strings.password: password,
      Strings.passwordConfirmation: confirmPassword,
      Strings.firstName: firstName,
      Strings.lastName: lastName,
      Strings.zip: zipCode,
      Strings.groupCode: groupCode,
      Strings.businessId: _deepLinkInfo?.businessId ?? '',
      Strings.causeId: _deepLinkInfo?.causeId ?? '',
      Strings.organizationId: _deepLinkInfo?.organizationId ?? ''
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