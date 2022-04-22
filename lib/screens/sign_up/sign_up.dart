import 'package:flutter/material.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_field.dart';
import 'package:get/get.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/text_views.dart';

class SignUpScreen extends StatelessWidget {

  final TextEditingController? firstNameController = TextEditingController();
  final TextEditingController? lastNameController = TextEditingController();
  final TextEditingController? emailController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();
  final TextEditingController? confirmPasswordController = TextEditingController();
  final TextEditingController? zipCodeController = TextEditingController();
  final TextEditingController? groupCodeController = TextEditingController();

  SignUpScreen({Key? key}) : super(key: key);



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
                children: [
                  const Image(
                    image: AssetImage(Assets.logo,),
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: getHeight() * 0.06),
                  TextView.titleWithDecoration("Create your account to continue!", color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, lines: 1, fontSize: sizes.fontSize16),
                  SizedBox(height: getHeight() * 0.03),
                  TextFieldWidget(
                      textEditingController: firstNameController,
                      hint: "First Name",
                      textInputType: TextInputType.emailAddress
                  ),
                  SizedBox(height: getHeight() * 0.035),
                  TextFieldWidget(
                      textEditingController: lastNameController,
                      hint: "Last Name",
                  ),
                  SizedBox(height: getHeight() * 0.035),
                  TextFieldWidget(
                      textEditingController: emailController,
                      hint: "Email",
                  ),SizedBox(height: getHeight() * 0.035),
                  TextFieldWidget(
                      textEditingController: passwordController,
                      hint: "Password",
                      obscureText: true
                  ),SizedBox(height: getHeight() * 0.035),
                  TextFieldWidget(
                      textEditingController: confirmPasswordController,
                      hint: "Confirm Password",
                      obscureText: true
                  ),SizedBox(height: getHeight() * 0.035),
                  TextFieldWidget(
                      textEditingController: zipCodeController,
                      hint: "Zip Code",
                  ),SizedBox(height: getHeight() * 0.035),
                  TextFieldWidget(
                      textEditingController: groupCodeController,
                      hint: "Group Code",
                      textColor: AppColors.lightBlue,
                      hintTextColor: AppColors.lightBlue,
                      cursorColor: AppColors.lightBlue,
                      bgColor: AppColors.lightPurpleColorForTextField
                  ),
                  SizedBox(height: getHeight() * 0.01),
                  TextView.subTitleWithBlurRadius("*Part of a club, organization or special group?", color: AppColors.lightBlue, fontFamily: Assets.poppinsMedium),
                  SizedBox(height: getHeight() * 0.06),
                  Button(onPress: () {
                    Get.offAllNamed(Routes.bottomNavBarScreen);
                  }, text: "Sign Up!"),
                  SizedBox(height: getHeight() * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView.titleWithDecoration("Already have an account? ", fontFamily: Assets.poppinsRegular, color: AppColors.blackColor, lines: 1),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.loginScreen);
                        },
                          child: TextView.titleWithDecoration("Sign In", fontFamily: Assets.poppinsMedium, color: AppColors.greenColor, lines: 1, textDecoration: TextDecoration.underline)),

                    ],
                  ),
                  SizedBox(height: getHeight() * 0.06),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
