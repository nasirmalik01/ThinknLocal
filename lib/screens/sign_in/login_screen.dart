import 'package:flutter/material.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_field.dart';
import 'package:get/get.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/text_views.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController? _emailController = TextEditingController();
  final TextEditingController? _passwordController = TextEditingController();

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
                    SizedBox(height: getHeight() * 0.08),
                    TextFieldWidget(
                        textEditingController: _emailController,
                        hint: "Email Address",
                        textInputType: TextInputType.emailAddress
                    ),
                    SizedBox(height: getHeight() * 0.03),
                    TextFieldWidget(
                        textEditingController: _passwordController,
                        hint: "Password",
                        obscureText: true
                    ),
                    SizedBox(height: getHeight() * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextView.titleWithBlurRadius("Forgot password? ", Assets.poppinsRegular, color: AppColors.blackColor, lines: 1),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.resetPasswordScreen);
                          },
                            child: TextView.titleWithBlurRadius("Reset it", Assets.poppinsMedium, color: AppColors.greenColor, lines: 1, isUnderLine: true)),

                      ],
                    ),
                    SizedBox(height: getHeight() * 0.04),
                    Button(onPress: () {
                      PreferenceUtils.setBool(Strings.showHome, true);
                      Get.offAllNamed(Routes.bottomNavBarScreen);
                    },
                      btnColor: AppColors.greenColor,
                      textColor: AppColors.pureWhiteColor,
                      text: "Sign In"
                    ),
                    SizedBox(height: getHeight() * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: sizes.width * 0.2,
                          child: Divider(
                            height: getHeight() * 0.01,
                            thickness: getHeight() * 0.002,
                            color: AppColors.borderColor,
                          ),
                        ),
                        SizedBox(width: getWidth() * 0.05),
                        TextView.titleWithDecoration("Or continue with", color: AppColors.lightBlack),
                        SizedBox(width: getWidth() * 0.05),
                        SizedBox(
                          width: sizes.width * 0.2,
                          child: Divider(
                            height: getHeight() * 0.01,
                            thickness: getHeight() * 0.002,
                            color: AppColors.borderColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getHeight() * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Image(
                          image: AssetImage(Assets.appleLogo,),
                          fit: BoxFit.fill,
                        ),
                        Image(
                          image: AssetImage(Assets.googleLogo,),
                          fit: BoxFit.fill,
                        ),
                        Image(
                          image: AssetImage(Assets.facebookLogo,),
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                    SizedBox(height: getHeight() * 0.09),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextView.titleWithDecoration("Don't have an account? ", fontFamily: Assets.poppinsRegular, color: AppColors.blackColor, lines: 1),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.signUpScreen);
                          },
                            child: TextView.titleWithDecoration("Register", fontFamily: Assets.poppinsMedium, color: AppColors.greenColor, lines: 1, textDecoration: TextDecoration.underline)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
