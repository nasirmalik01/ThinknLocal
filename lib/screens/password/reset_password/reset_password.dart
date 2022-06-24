import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/screens/password/reset_password/reset_password_controller.dart';
import 'package:thinknlocal_app/widgets/button.dart';
import 'package:thinknlocal_app/widgets/text_field.dart';
import 'package:get/get.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/text_views.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);

  final TextEditingController? emailController = TextEditingController();
  final ResetPasswordController _resetPasswordController = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: sizes.height,
        width: sizes.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: [
            Container(
              height: getHeight() * 0.1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.lightGreenColor,
                    AppColors.pureWhiteColor,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage(Assets.logo,),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.08),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView.title("Password Reset", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                      SizedBox(height: getHeight()*0.01,),
                      TextView.subTitleWithBlurRadius("Enter your email, a reset code will be sent to this address.", color: AppColors.blackColor, lines: 2, fontFamily: Assets.poppinsRegular),
                    ],
                  ),
                  SizedBox(height: getHeight() * 0.04),
                  TextFieldWidget(
                      textEditingController: emailController,
                      hint: "Email Address",
                      textInputType: TextInputType.emailAddress
                  ),
                  SizedBox(height: getHeight() * 0.04),
                  Button(onPress: () {
                    if (emailController!.text.trim().isEmpty) {
                      return showSnackBar(subTitle: 'Please enter email');
                    }
                    _resetPasswordController.resetPassword(emailController!.text);
                  }, text: "Send Reset Code"),
                  SizedBox(height: getHeight() * 0.04),
                  Button(onPress: () {
                    Navigator.pop(context);
                  },
                      text: "Cancel", btnColor: AppColors.pureWhiteColor, textColor: AppColors.darkGrey, borderColor: AppColors.darkGrey),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
