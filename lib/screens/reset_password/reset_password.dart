import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
                    Row(
                      children: [
                        TextView.getMediumText18("Password Reset", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                      ],
                    ),
                    Row(
                      children: [
                        TextView.regular11Text("Enter your email, a reset code will be sent to this address.", color: AppColors.blackColor),
                      ],
                    ),
                    SizedBox(height: getHeight() * 0.04),
                    CommonWidgets.textField(
                        textEditingController: emailController,
                        hint: "Email Address",
                        textInputType: TextInputType.emailAddress
                    ),
                    SizedBox(height: getHeight() * 0.04),
                    CommonWidgets.getButton(onPress: () {}, text: "Send Reset Code"),
                    SizedBox(height: getHeight() * 0.04),
                    CommonWidgets.getButton(onPress: () {
                      Navigator.pop(context);
                    },
                        text: "Cancel", btnColor: AppColors.pureWhiteColor, textColor: AppColors.darkGrey, borderColor: AppColors.darkGrey),
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
