import 'package:flutter/material.dart';
import 'package:flutter_app/screens/password/reset_password/reset_password.dart';
import 'package:flutter_app/screens/sign_up/sign_up.dart';
import 'package:flutter_app/widgets/text_field.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';
import '../bottom_tab/bottom_tab_new.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: sizes.height,
          width: sizes.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                    child: Column(
                      children: [
                        const Image(
                          image: AssetImage(Assets.logo,),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: getHeight() * 0.08),
                        TextFieldWidget(
                            textEditingController: emailController,
                            hint: "Email Address",
                            textInputType: TextInputType.emailAddress
                        ),
                        SizedBox(height: getHeight() * 0.03),
                        TextFieldWidget(
                            textEditingController: passwordController,
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
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => const ResetPassword()));
                              },
                                child: TextView.titleWithBlurRadius("Reset it", Assets.poppinsMedium, color: AppColors.greenColor, lines: 1)),

                          ],
                        ),
                        SizedBox(height: getHeight() * 0.02),
                        CommonWidgets.getButton(onPress: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => BottomTabNew(pageIndex: 0)));
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
                        SizedBox(height: getHeight() * 0.1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextView.titleWithDecoration("Don't have an account? ", fontFamily: Assets.poppinsRegular, color: AppColors.blackColor, lines: 1),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => const SignUpScreen()));
                              },
                                child: TextView.titleWithDecoration("Register", fontFamily: Assets.poppinsMedium, color: AppColors.greenColor, lines: 1)),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
