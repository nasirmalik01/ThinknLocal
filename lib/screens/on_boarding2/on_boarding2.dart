import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';
import '../on_boarding1/on_boarding1.dart';
import '../on_boarding3/on_boarding3.dart';

class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({Key? key}) : super(key: key);

  @override
  _OnBoarding2State createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onPanUpdate: (dis) {
            if (dis.delta.dx > 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const OnBoarding1()));
              //User swiped from left to right
            } else if (dis.delta.dx < 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const OnBoarding3()));
              //User swiped from right to left
            }
          },
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const OnBoarding3()));
          },
          child: Container(
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                  child: Column(
                    children: [
                      SizedBox(height: getHeight() * 0.05),
                      const Image(
                        image: AssetImage(Assets.onBoarding2),
                        fit: BoxFit.fill,
                      ),
                      TextView.getMediumText18("Shop at participating business", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                      SizedBox(height: getHeight() * 0.02),
                      TextView.getMediumText15("Try new restaurants, visit the\n quaint ${"Mom & Pop"} &"
                          " Support\n local businesses while you help\n fund a worthy cause!",
                          color: AppColors.blackColor,
                          textAlign: TextAlign.center,
                          fontFamily: Assets.poppinsRegular),
                      SizedBox(height: getHeight() * 0.18),
                      SizedBox(
                        width: getWidth() * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CommonWidgets.getSmallButton(borderColor: AppColors.greenColor, fillColor: AppColors.pureWhiteColor),
                            CommonWidgets.getSmallButton(borderColor: AppColors.greenColor, fillColor: AppColors.greenColor),
                            CommonWidgets.getSmallButton(borderColor: AppColors.greenColor, fillColor: AppColors.pureWhiteColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
