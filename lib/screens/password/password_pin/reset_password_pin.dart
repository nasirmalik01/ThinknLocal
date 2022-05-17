import 'package:flutter/material.dart';
import 'package:flutter_app/screens/password/password_pin/reset_password_pin_controller.dart';
import 'package:flutter_app/widgets/text_field.dart';
import 'package:get/get.dart';
import '../../../common/methods.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/button.dart';
import '../../../widgets/text_views.dart';

class ResetPinScreen extends StatefulWidget {
  const ResetPinScreen({Key? key}) : super(key: key);

  @override
  _ResetPinScreenState createState() => _ResetPinScreenState();
}

class _ResetPinScreenState extends State<ResetPinScreen> {
  TextEditingController? resetPinController;
  final ResetPasswordPinController _resetPasswordPinController = Get.put(ResetPasswordPinController());

  @override
  void initState() {
    super.initState();
    resetPinController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final _email = ModalRoute.of(context)!.settings.arguments as String;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage(Assets.logo,),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.08),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView.title("Enter Your Reset Pin", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                      SizedBox(height: getHeight()*0.01,),
                      TextView.headerWithBlurRadius("Enter the pin that was sent to your email address to finish, resetting your password.",
                          color: AppColors.blackColor, lines: 2, fontFamily: Assets.poppinsRegular),
                    ],
                  ),
                  SizedBox(height: getHeight() * 0.04),
                  TextFieldWidget(
                      textEditingController: resetPinController,
                      hint: "Reset Pin",
                      textInputType: TextInputType.emailAddress
                  ),
                  SizedBox(height: getHeight() * 0.04),
                  Button(onPress: () {
                    if (resetPinController!.text.trim().isEmpty) {
                      return showSnackBar(subTitle: 'Please enter your reset pin');
                    }
                    _resetPasswordPinController.verifyResetPin(_email, resetPinController!.text);
                  }, text: "Reset"),
                  SizedBox(height: getHeight() * 0.04),
                  Button(onPress: () {
                    Navigator.pop(context);
                  },
                      text: "Cancel", btnColor: AppColors.pureWhiteColor, textColor: AppColors.darkGrey, borderColor: AppColors.darkGrey),
                  SizedBox(height: getHeight() * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView.headerWithBlurRadius("Didn't receive the code? ", color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, fontSize: sizes.fontSize14),
                      TextView.headerWithBlurRadius("Resend", color: AppColors.greenColor, fontFamily: Assets.poppinsMedium, textDecoration: TextDecoration.underline, fontSize: sizes.fontSize14)
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
}
