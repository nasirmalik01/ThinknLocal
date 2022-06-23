import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/screens/password/new_password/new_password_controller.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/password_text_field.dart';
import 'package:flutter_app/widgets/text_field.dart';
import 'package:get/get.dart';

import '/constants/assets.dart';
import '/constants/colors.dart';
import '/res/res.dart';
import '/widgets/text_views.dart';


class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  bool hiddenPassword = true;
  final NewPasswordController _newPasswordController = Get.put(NewPasswordController());

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final _params = ModalRoute.of(context)!.settings.arguments as Map;
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView.title("Enter Your Reset Pin", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                      SizedBox(height: getHeight()*0.01,),
                      TextView.headerWithBlurRadius("Enter the new password that you want to set for your account.",
                          color: AppColors.blackColor, lines: 2, fontFamily: Assets.poppinsRegular),
                      SizedBox(height: getHeight() * 0.04),
                      PasswordTextField(
                          textEditingController: passwordController,
                          hint: "Password",
                          textInputType: TextInputType.emailAddress,
                          hidePassword: hiddenPassword,
                          clickIcon: isPasswordIconClicked
                      ),
                      SizedBox(height: getHeight() * 0.02),
                      TextView.subTitleWithBlurRadius("Must be at least 8 characters.", color: AppColors.darkGrey),
                      SizedBox(height: getHeight() * 0.04),
                      TextFieldWidget(
                          textEditingController: confirmPasswordController,
                          hint: "Confirm Password",
                          textInputType: TextInputType.emailAddress
                      ),
                      SizedBox(height: getHeight() * 0.02),
                      TextView.subTitleWithBlurRadius("Both passwords must match.", color: AppColors.darkGrey),
                      SizedBox(height: getHeight() * 0.04),
                      Button(onPress: () {
                        if(passwordController!.text != confirmPasswordController!.text)
                          {
                            showSnackBar(subTitle: 'Password didn\'t Match', backgroundColor: AppColors.greenColor,);
                          }
                        else if(passwordController!.text.length<8 || confirmPasswordController!.text.length < 8)
                        {
                          showSnackBar(subTitle: 'Enter atleast 8 characters', backgroundColor: AppColors.greenColor,);
                        }
                        else{
                          _newPasswordController.newPassword(_params['email'],_params['token'], passwordController!.text);
                        }
                      }, text: "Reset Password"),
                      SizedBox(height: getHeight() * 0.04),
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

  void isPasswordIconClicked() {
    setState(() {
      hiddenPassword = !hiddenPassword;
    });
  }
}
