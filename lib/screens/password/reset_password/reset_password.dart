import 'package:flutter/material.dart';
import 'package:flutter_app/screens/password/password_pin/password_pin.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/text_views.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController? emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
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
                          TextView.title("Password Reset", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                          TextView.subTitleWithBlurRadius("Enter your email, a reset code will be sent to this address.", color: AppColors.blackColor, lines: 2, fontFamily: Assets.poppinsRegular),
                        ],
                      ),
                      SizedBox(height: getHeight() * 0.04),
                      CommonWidgets.textField(
                          textEditingController: emailController,
                          hint: "Email Address",
                          textInputType: TextInputType.emailAddress
                      ),
                      SizedBox(height: getHeight() * 0.04),
                      CommonWidgets.getButton(onPress: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const PasswordPin()));
                      }, text: "Send Reset Code"),
                      SizedBox(height: getHeight() * 0.04),
                      CommonWidgets.getButton(onPress: () {
                        Navigator.pop(context);
                      },
                          text: "Cancel", btnColor: AppColors.pureWhiteColor, textColor: AppColors.darkGrey, borderColor: AppColors.darkGrey),
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
