import 'package:flutter/material.dart';
import 'package:flutter_app/screens/sign_in/sign_in.dart';
import 'package:flutter_app/widgets/text_field.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  TextEditingController? zipCodeController;
  TextEditingController? groupCodeController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    zipCodeController = TextEditingController();
    groupCodeController = TextEditingController();
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
                      SizedBox(height: getHeight() * 0.06),
                      TextView.titleWithDecoration("Create your account to continue!", color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, lines: 1),
                      SizedBox(height: getHeight() * 0.02),
                      TextFieldWidget(
                          textEditingController: firstNameController,
                          hint: "First Name",
                          textInputType: TextInputType.emailAddress
                      ),
                      SizedBox(height: getHeight() * 0.03),
                      TextFieldWidget(
                          textEditingController: lastNameController,
                          hint: "Last Name",
                      ),
                      SizedBox(height: getHeight() * 0.03),
                      TextFieldWidget(
                          textEditingController: emailController,
                          hint: "Email",
                      ),SizedBox(height: getHeight() * 0.03),
                      TextFieldWidget(
                          textEditingController: passwordController,
                          hint: "Password",
                          obscureText: true
                      ),SizedBox(height: getHeight() * 0.03),
                      TextFieldWidget(
                          textEditingController: confirmPasswordController,
                          hint: "Confirm Password",
                          obscureText: true
                      ),SizedBox(height: getHeight() * 0.03),
                      TextFieldWidget(
                          textEditingController: zipCodeController,
                          hint: "Zip Code",
                      ),SizedBox(height: getHeight() * 0.03),
                      TextFieldWidget(
                          textEditingController: groupCodeController,
                          hint: "Group Code",
                          textColor: AppColors.lightBlue,
                          hintTextColor: AppColors.lightBlue,
                          cursorColor: AppColors.lightBlue
                      ),
                      SizedBox(height: getHeight() * 0.01),
                      TextView.subTitleWithBlurRadius("*Part of a club, organization or special group?", color: AppColors.lightBlue, fontFamily: Assets.poppinsMedium),
                      SizedBox(height: getHeight() * 0.06),
                      CommonWidgets.getButton(onPress: () {}, text: "Sign Up!"),
                      SizedBox(height: getHeight() * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView.titleWithDecoration("Already have an account? ", fontFamily: Assets.poppinsRegular, color: AppColors.blackColor, lines: 1),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const LoginScreen()));
                            },
                              child: TextView.titleWithDecoration("Sign In", fontFamily: Assets.poppinsMedium, color: AppColors.greenColor, lines: 1)),

                        ],
                      ),
                      SizedBox(height: getHeight() * 0.04),
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
