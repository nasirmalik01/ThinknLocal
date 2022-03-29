import 'package:flutter/material.dart';
import 'package:flutter_app/screens/password/new_password/new_password.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/text_views.dart';

class PasswordPin extends StatefulWidget {
  const PasswordPin({Key? key}) : super(key: key);

  @override
  _PasswordPinState createState() => _PasswordPinState();
}

class _PasswordPinState extends State<PasswordPin> {
  TextEditingController? resetPinController;

  @override
  void initState() {
    super.initState();
    resetPinController = TextEditingController();
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
                      SizedBox(height: getHeight() * 0.08),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView.getMediumText18("Enter Your Reset Pin", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                          TextView.bold12Text("Enter the pin that was sent to your email address to finish, resetting your password.",
                              color: AppColors.blackColor, lines: 2, fontFamily: Assets.poppinsRegular),
                        ],
                      ),
                      SizedBox(height: getHeight() * 0.04),
                      CommonWidgets.textField(
                          textEditingController: resetPinController,
                          hint: "Reset Pin",
                          textInputType: TextInputType.emailAddress
                      ),
                      SizedBox(height: getHeight() * 0.04),
                      CommonWidgets.getButton(onPress: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const NewPassword()));
                      }, text: "Reset"),
                      SizedBox(height: getHeight() * 0.04),
                      CommonWidgets.getButton(onPress: () {
                        Navigator.pop(context);
                      },
                          text: "Cancel", btnColor: AppColors.pureWhiteColor, textColor: AppColors.darkGrey, borderColor: AppColors.darkGrey),
                      SizedBox(height: getHeight() * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView.bold15Text("Didn't receive the code? ", color: AppColors.blackColor, fontFamily: Assets.poppinsRegular),
                          TextView.bold15Text("Resend", color: AppColors.greenColor, fontFamily: Assets.poppinsMedium, textDecoration: TextDecoration.underline)
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
}
