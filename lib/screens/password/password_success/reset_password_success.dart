import 'package:flutter/material.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/text_views.dart';

class ResetPasswordSuccessScreen extends StatelessWidget {
  const ResetPasswordSuccessScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: getHeight() * 0.1),
                  Stack(
                    children: const [
                      Image(
                        image: AssetImage(Assets.successBigIcon),
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Image(
                          image: AssetImage(Assets.blurEffect),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getHeight() * 0.01),
                  TextView.header("Success!", color: AppColors.greenColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize35),
                  SizedBox(height: getHeight() * 0.04),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.2),
                    child: TextView.subTitle("Successfully reset your password!", color: AppColors.darkGrey, lines: 2, textAlign: TextAlign.center, fontSize: sizes.fontSize18),
                  ),
                  SizedBox(height: getHeight() * 0.1),
                  CommonWidgets.getButton(
                    onPress: (){
                      Get.toNamed(Routes.loginScreen);
                    },
                    text: "Sign In"
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
