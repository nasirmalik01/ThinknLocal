import 'package:flutter/material.dart';
import 'package:flutter_app/screens/password/password_success/password_success.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/text_views.dart';


class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  bool hiddenPassword = true;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView.title("Enter Your Reset password", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                          TextView.headerWithBlurRadius("Enter the new password that you want to set for your account.",
                              color: AppColors.blackColor, lines: 2, fontFamily: Assets.poppinsRegular),
                          SizedBox(height: getHeight() * 0.04),
                          CommonWidgets.textFieldForPassword(
                              textEditingController: passwordController,
                              hint: "Password",
                              textInputType: TextInputType.emailAddress,
                              hidePassword: hiddenPassword,
                              clickIcon: isPasswordIconClicked
                          ),
                          SizedBox(height: getHeight() * 0.02),
                          TextView.subTitleWithBlurRadius("Must be at least 8 characters.", color: AppColors.darkGrey),
                          SizedBox(height: getHeight() * 0.04),
                          CommonWidgets.textField(
                              textEditingController: confirmPasswordController,
                              hint: "Confirm Password",
                              textInputType: TextInputType.emailAddress
                          ),
                          SizedBox(height: getHeight() * 0.02),
                          TextView.subTitleWithBlurRadius("Both passwords must match.", color: AppColors.darkGrey),
                          SizedBox(height: getHeight() * 0.04),
                          CommonWidgets.getButton(onPress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const PasswordSuccess()));
                          }, text: "Reset Password"),
                          SizedBox(height: getHeight() * 0.04),
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

  void isPasswordIconClicked() {
    setState(() {
      hiddenPassword = !hiddenPassword;
    });
  }
}