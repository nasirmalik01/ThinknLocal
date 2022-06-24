import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/model/account.dart';
import 'package:thinknlocal_app/screens/bottom_tab/account/account_controller.dart';
import 'package:thinknlocal_app/widgets/button.dart';
import 'package:thinknlocal_app/widgets/password_text_field.dart';
import 'package:thinknlocal_app/widgets/text_field.dart';
import 'package:get/get.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/text_views.dart';

class EditAccount extends StatefulWidget {
  final Account? account;
  const EditAccount({this.account, Key? key}) : super(key: key);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? zipCodeController;
  TextEditingController? groupCodeController;
  bool hiddenPassword = true;
  final AccountController _accountController = Get.put(AccountController());


  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.account!.firstName);
    lastNameController = TextEditingController(text: widget.account!.lastName);
    emailController = TextEditingController(text: widget.account!.email);
    passwordController = TextEditingController();
    zipCodeController = TextEditingController(text: widget.account!.zip);
    groupCodeController = TextEditingController(text: widget.account!.groupCode);
  }

  @override
  void dispose() {
    firstNameController!.dispose();
    lastNameController!.dispose();
    emailController!.dispose();
    passwordController!.dispose();
    zipCodeController!.dispose();
    groupCodeController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: sizes.width,
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
                      AppColors.lightGreenColor,
                      AppColors.pureWhiteColor,
                    ],
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06, ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: TextView.headerWithBlurRadius("Back", color: AppColors.lightBlack,fontFamily: Assets.poppinsMedium,
                          textDecoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ),
              SizedBox(height: getHeight() * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView.header("Edit Account Info", color: AppColors.lightBlack, fontFamily: Assets.poppinsSemiBold, lines: 1, fontSize: sizes.fontSize25),
                    SizedBox(height: getHeight() * 0.04),
                    TextView.titleWithDecoration("Basic info", color: AppColors.darkGrey, fontFamily: Assets.poppinsMedium),
                    SizedBox(height: getHeight() * 0.01),
                    TextFieldWidget(textEditingController: firstNameController, hint: "First Name", textInputType: TextInputType.emailAddress),
                    SizedBox(height: getHeight() * 0.03),
                    TextFieldWidget(textEditingController: lastNameController, hint: "Last Name",),
                    SizedBox(height: getHeight() * 0.03),
                    TextFieldWidget(textEditingController: emailController, hint: "Email",),
                    SizedBox(height: getHeight() * 0.03),
                    TextView.titleWithDecoration("Password", color: AppColors.darkGrey, fontFamily: Assets.poppinsMedium),
                    SizedBox(height: getHeight() * 0.01),
                    PasswordTextField(textEditingController: passwordController, hint: "Password", textInputType: TextInputType.emailAddress, hidePassword: hiddenPassword, clickIcon: isPasswordIconClicked),
                    SizedBox(height: getHeight() * 0.03),
                    TextView.titleWithDecoration("Zip Code", color: AppColors.darkGrey, fontFamily: Assets.poppinsMedium),
                    SizedBox(height: getHeight() * 0.01),
                    TextFieldWidget(textEditingController: zipCodeController, hint: "Zip Code", textInputType: TextInputType.number,),
                    SizedBox(height: getHeight() * 0.03),
                    TextView.titleWithDecoration("Group Code", color: AppColors.lightBlue, fontFamily: Assets.poppinsMedium),
                    SizedBox(height: getHeight() * 0.01),
                    TextFieldWidget(textEditingController: groupCodeController, hint: "Group Code", textColor: AppColors.lightBlue, hintTextColor: AppColors.lightBlue, cursorColor: AppColors.lightBlue),
                    SizedBox(height: getHeight() * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Button(onPress: (){
                          Navigator.pop(context);
                        },
                            width: sizes.width * 0.42, height: getHeight() * 0.08,
                            text: 'Cancel', textColor: AppColors.pureWhiteColor,
                            btnColor: AppColors.borderColor),
                        Button(onPress: () async {
                          if(zipCodeController!.text.length != 5){
                            return showSnackBar(subTitle: Strings.zipCodeError);
                          }

                          if(passwordController!.text.isNotEmpty){
                              if(passwordController!.text.length < 6){
                                return showSnackBar(subTitle: Strings.passwordError);
                              }
                          }
                          await _accountController.editAccountInfo({
                            Strings.firstName: firstNameController?.text,
                            Strings.lastName: lastNameController?.text,
                            Strings.email: emailController?.text,
                            Strings.password: passwordController?.text,
                            Strings.zip: zipCodeController?.text,
                            Strings.groupCode: groupCodeController?.text,
                          });
                          Get.back();
                        },
                            width: sizes.width * 0.42, height: getHeight() * 0.08,
                            text: 'Update', textColor: AppColors.pureWhiteColor,
                            btnColor: AppColors.greenColor),
                      ],
                    ),
                    SizedBox(height: getHeight() * 0.04),
                  ],
                ),
              ),
            ],
          ),
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
