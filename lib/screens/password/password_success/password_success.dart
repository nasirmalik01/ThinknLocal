import 'package:flutter/material.dart';
import 'package:flutter_app/screens/sign_in/sign_in.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/text_views.dart';

class PasswordSuccess extends StatefulWidget {
  const PasswordSuccess({Key? key}) : super(key: key);

  @override
  _PasswordSuccessState createState() => _PasswordSuccessState();
}

class _PasswordSuccessState extends State<PasswordSuccess> {

  @override
  void initState() {
    super.initState();
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
                      SizedBox(height: getHeight() * 0.1),
                      const Image(
                        image: AssetImage(Assets.successBigIcon),
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: getHeight() * 0.01),
                      TextView.header("Success!", color: AppColors.greenColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize35),
                      SizedBox(height: getHeight() * 0.04),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.12),
                        child: TextView.subTitle("Successfully reset your password!", color: AppColors.darkGrey, lines: 2, textAlign: TextAlign.center),
                      ),
                      SizedBox(height: getHeight() * 0.1),
                      CommonWidgets.getButton(
                        onPress: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const LoginScreen()));
                        },
                        text: "Sign In"
                      )
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
