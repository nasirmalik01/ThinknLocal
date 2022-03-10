import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/on_boarding1/on_boarding1.dart';
import 'package:flutter_app/screens/reset_password/reset_password.dart';
import 'package:flutter_app/screens/sign_up/sign_up.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.appBackground,
        body: Container(
            height: sizes!.height,
            width: sizes!.width,
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
                        AppColors.gradientColor1,
                        AppColors.pureWhiteColor,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes!.width * 0.06),
                  child: Column(
                    children: [
                      Container(
                        // height: sizes!.height * 0.1,
                        // width: sizes!.width * 0.7,
                        child: const Image(
                          image: AssetImage(Assets.logo,),
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: getHeight() * 0.08),
                      CommonWidgets.textField(
                          textEditingController: emailController,
                          hint: "Email Address",
                          textInputType: TextInputType.emailAddress
                      ),
                      SizedBox(height: getHeight() * 0.03),
                      CommonWidgets.textField(
                          textEditingController: passwordController,
                          hint: "Password",
                          obscureText: true
                      ),
                      SizedBox(height: getHeight() * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextView.getMediumText16("Forgot password? ", Assets.poppinsRegular, color: AppColors.blackColor, lines: 1),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const ResetPassword()));
                            },
                              child: TextView.getMediumText16("Reset it", Assets.poppinsMedium, color: AppColors.greenColor, lines: 1)),

                        ],
                      ),
                      SizedBox(height: getHeight() * 0.02),
                      CommonWidgets.getButton(onPress: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const OnBoarding1()));
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
                            width: sizes!.width * 0.22,
                            child: Divider(
                              height: getHeight() * 0.01,
                              color: AppColors.borderColor,
                            ),
                          ),
                          SizedBox(width: getWidth() * 0.06),
                          TextView.getMediumText15("Or continue with", color: AppColors.lightBlack),
                          SizedBox(width: getWidth() * 0.06),
                          SizedBox(
                            width: sizes!.width * 0.22,
                            child: Divider(
                              height: getHeight() * 0.01,
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
                      SizedBox(height: getHeight() * 0.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView.getMediumText15("Don't have an account? ", fontFamily: Assets.poppinsRegular, color: AppColors.blackColor, lines: 1),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const SignUp()));
                            },
                              child: TextView.getMediumText15("Register", fontFamily: Assets.poppinsMedium, color: AppColors.greenColor, lines: 1)),

                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
