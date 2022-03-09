import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/reset_password/reset_password.dart';
import 'package:flutter_app/screens/sign_in/sign_in.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
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
    firstNameController = TextEditingController(text: "Johnathon");
    lastNameController = TextEditingController(text: "Doe");
    emailController = TextEditingController(text: "johnathon.doe@email.com");
    passwordController = TextEditingController(text: "John123!");
    confirmPasswordController = TextEditingController();
    zipCodeController = TextEditingController(text: "90145");
    groupCodeController = TextEditingController(text: "AYALHIGHSCHOOL");
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
                width: getWidth(),
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes!.width * 0.06, vertical: sizes!.width * 0.05),
                    child: TextView.bold12Text("Back", color: AppColors.lightBlack,fontFamily: Assets.poppinsMedium,
                        textDecoration: TextDecoration.underline),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes!.width * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView.bold25Text("Edit Account Info", color: AppColors.lightBlack, fontFamily: Assets.latoBold, lines: 1),
                        SizedBox(height: getHeight() * 0.04),
                        TextView.getMediumText15("Basic info", color: AppColors.darkGrey, fontFamily: Assets.poppinsMedium),
                        SizedBox(height: getHeight() * 0.01),
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
                        ),SizedBox(height: getHeight() * 0.02),
                        TextView.getMediumText15("Password", color: AppColors.darkGrey, fontFamily: Assets.poppinsMedium),
                        SizedBox(height: getHeight() * 0.01),
                        CommonWidgets.textField(
                            textEditingController: passwordController,
                            hint: "Password",
                            obscureText: true
                        ),SizedBox(height: getHeight() * 0.02),
                        TextView.getMediumText15("Zip Code", color: AppColors.darkGrey, fontFamily: Assets.poppinsMedium),
                        SizedBox(height: getHeight() * 0.01),
                        CommonWidgets.textField(
                          textEditingController: zipCodeController,
                          hint: "Zip Code",
                        ),SizedBox(height: getHeight() * 0.02),
                        TextView.getMediumText15("Group Code", color: AppColors.lightBlue, fontFamily: Assets.poppinsMedium),
                        SizedBox(height: getHeight() * 0.01),
                        CommonWidgets.textField(
                            textEditingController: groupCodeController,
                            hint: "Group Code",
                            textColor: AppColors.lightBlue,
                            hintTextColor: AppColors.lightBlue,
                            cursorColor: AppColors.lightBlue
                        ),
                        SizedBox(height: getHeight() * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonWidgets.getButton(onPress: (){
                              Navigator.pop(context);
                            },
                                width: sizes!.width * 0.42, height: getHeight() * 0.08,
                                text: "Cancel,", textColor: AppColors.pureWhiteColor,
                                btnColor: AppColors.borderColor),
                            CommonWidgets.getButton(onPress: (){}, width: sizes!.width * 0.42, height: getHeight() * 0.08,
                                text: "Update,", textColor: AppColors.pureWhiteColor,
                                btnColor: AppColors.greenColor),
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
      ),
    );
  }
}
