import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/bottom_tab.dart';
import 'package:flutter_app/screens/bottom_tab/bottom_tab_new.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';

class OnBoarding3 extends StatefulWidget {
  const OnBoarding3({Key? key}) : super(key: key);

  @override
  _OnBoarding3State createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.appBackground,
        body: GestureDetector(
          onTap: () {

          },
          child: Container(
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
                      SizedBox(height: getHeight() * 0.05),
                      const Image(
                        image: AssetImage(Assets.onBoarding1),
                        fit: BoxFit.fill,
                      ),
                      TextView.getMediumText18("Snap a photo of your receipt", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                      SizedBox(height: getHeight() * 0.02),
                      TextView.getMediumText15("Search for that great fundraiser\n you'd like to support.",
                          color: AppColors.blackColor,
                          textAlign: TextAlign.center,
                          fontFamily: Assets.poppinsRegular),
                      SizedBox(height: getHeight() * 0.08),
                      CommonWidgets.getButton(onPress: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => BottomTabNew(pageIndex: 0)));
                      }, text: "Get Started!", width: getWidth() * 0.75),
                      SizedBox(height: getHeight() * 0.08),
                      SizedBox(
                        width: getWidth() * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CommonWidgets.getSmallButton(borderColor: AppColors.greenColor, fillColor: AppColors.pureWhiteColor),
                            CommonWidgets.getSmallButton(borderColor: AppColors.greenColor, fillColor: AppColors.pureWhiteColor),
                            CommonWidgets.getSmallButton(borderColor: AppColors.greenColor, fillColor: AppColors.greenColor),
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
