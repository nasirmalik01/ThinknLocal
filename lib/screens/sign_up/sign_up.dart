import 'package:flutter/material.dart';
import 'package:flutter_app/screens/sign_in/sign_in.dart';
import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                    AppColors.gradientColor1,
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
                      TextView.getMediumText15("Create your account to continue!", color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, lines: 1),
                      SizedBox(height: getHeight() * 0.02),
                      CommonWidgets.textField(
                          textEditingController: firstNameController,
                          hint: "First Name",
                          textInputType: TextInputType.emailAddress
                      ),
                      SizedBox(height: getHeight() * 0.03),
                      CommonWidgets.textField(
                          textEditingController: lastNameController,
                          hint: "Last Name",
                      ),
                      SizedBox(height: getHeight() * 0.03),
                      CommonWidgets.textField(
                          textEditingController: emailController,
                          hint: "Email",
                      ),SizedBox(height: getHeight() * 0.03),
                      CommonWidgets.textField(
                          textEditingController: passwordController,
                          hint: "Password",
                          obscureText: true
                      ),SizedBox(height: getHeight() * 0.03),
                      CommonWidgets.textField(
                          textEditingController: confirmPasswordController,
                          hint: "Confirm Password",
                          obscureText: true
                      ),SizedBox(height: getHeight() * 0.03),
                      CommonWidgets.textField(
                          textEditingController: zipCodeController,
                          hint: "Zip Code",
                      ),SizedBox(height: getHeight() * 0.03),
                      CommonWidgets.textField(
                          textEditingController: groupCodeController,
                          hint: "Group Code",
                          textColor: AppColors.lightBlue,
                          hintTextColor: AppColors.lightBlue,
                          cursorColor: AppColors.lightBlue
                      ),
                      SizedBox(height: getHeight() * 0.01),
                      TextView.getText13("*Part of a club, organization or special group?", color: AppColors.lightBlue, fontFamily: Assets.poppinsMedium),
                      SizedBox(height: getHeight() * 0.06),
                      CommonWidgets.getButton(onPress: () {}, text: "Sign Up!"),
                      SizedBox(height: getHeight() * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView.getMediumText15("Already have an account? ", fontFamily: Assets.poppinsRegular, color: AppColors.blackColor, lines: 1),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const SignIn()));
                            },
                              child: TextView.getMediumText15("Sign In", fontFamily: Assets.poppinsMedium, color: AppColors.greenColor, lines: 1)),

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
