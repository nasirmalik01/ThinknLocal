import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/screens/sign_in/login_controller.dart';
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
  final LogInController _logInController = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
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
                      Button(onPress: () async {
                        if(_emailController!.text.trim().isEmpty || _passwordController!.text.trim().isEmpty){
                          return showSnackBar(subTitle: 'Please fill all the required fields');
                        }

                        if(_passwordController!.text.length < 6){
                          return showSnackBar(title: 'Password too short', subTitle: 'It should be of minimum 6 characters');
                        }

                        showLoadingDialog(message: 'Authenticating User');
                        _logInController.authenticateUserWithEmailPassword(email: _emailController!.text, password: _passwordController!.text,);
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
                        children: [
                          GestureDetector(
                            onTap: (){
                              _logInController.loginWithApple();
                            },
                            child: const Image(
                              image: AssetImage(Assets.appleLogo,),
                              fit: BoxFit.fill,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _logInController.loginWithGoogle();
                            },
                            child: const Image(
                              image: AssetImage(Assets.googleLogo,),
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Image(
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
          )
    );
  }
}
