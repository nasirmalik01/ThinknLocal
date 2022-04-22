import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/password_text_field.dart';
import 'package:flutter_app/widgets/text_field.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
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
  bool hiddenPassword = true;

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
                    TextFieldWidget(textEditingController: zipCodeController, hint: "Zip Code",),
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
                        Button(onPress: (){}, width: sizes.width * 0.42, height: getHeight() * 0.08,
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
