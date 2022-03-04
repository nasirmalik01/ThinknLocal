import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';
import '../on_boarding2/on_boarding2.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({Key? key}) : super(key: key);

  @override
  _OnBoarding1State createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {

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
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const OnBoarding2()));
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
                      TextView.getText27("Welcome!", color: AppColors.greenColor, fontFamily: Assets.poppinsMedium),
                      const Image(
                        image: AssetImage(Assets.onBoarding3),
                        fit: BoxFit.fill,
                      ),
                      TextView.getMediumText18("Find a great cause!", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                      SizedBox(height: getHeight() * 0.02),
                      TextView.getMediumText15("Search for that great\n fundraiser you'd like to\n support.", color: AppColors.blackColor, textAlign: TextAlign.center, fontFamily: Assets.poppinsRegular),
                      SizedBox(height: getHeight() * 0.2),
                      SizedBox(
                        width: getWidth() * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CommonWidgets.getSmallButton(borderColor: AppColors.greenColor, fillColor: AppColors.greenColor),
                            CommonWidgets.getSmallButton(borderColor: AppColors.greenColor, fillColor: AppColors.pureWhiteColor),
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
