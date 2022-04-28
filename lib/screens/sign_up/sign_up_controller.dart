import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class SignUpController extends GetxController{

  Future registerUser({String? email, String? password, String? confirmPassword, String? firstName, String? lastName, String? zipCode, String? groupCode, String? businessId, String? causeId, String? organizationId}) async {
    final response = await GetIt.I<RemoteServices>().postRequest('users', {
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'first_name': firstName,
      'last_name': lastName,
      'zip': zipCode,
      'group_code': groupCode,
      'business_id': businessId,
      'cause_id': causeId,
      'organization_id': organizationId
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