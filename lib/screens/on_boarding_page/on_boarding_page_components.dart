import 'package:flutter/cupertino.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';

class OnBoardingPageComponents {
  Widget getPageDesignContainer({
    required String heading,
    required String image,
    required String subHeading,
    required String description,
    required bool isOnBoarding3,
    Function? onPressStartButton,
    String? buttonText
  }) {
    return Container(
      key: const Key('onBoardingPageSettingWidget'),
      height: sizes.height,
      width: sizes.width,
      decoration: const BoxDecoration(
        color: AppColors.pureWhiteColor,
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
            padding: EdgeInsets.only(left: sizes.width * 0.06, right: sizes.width * 0.06, top: sizes.width * 0.06),
            child: Column(
              children: [
                TextView.getText27(heading, color: AppColors.greenColor, fontFamily: Assets.poppinsMedium),
                Image(
                  image: AssetImage(image),
                  fit: BoxFit.fill,
                ),
                TextView.getMediumText18(subHeading, color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                SizedBox(height: getHeight() * 0.02),
                TextView.getMediumText15(description, color: AppColors.blackColor, textAlign: TextAlign.center, fontFamily: Assets.poppinsRegular),
                SizedBox(height: getHeight() * 0.06),
                isOnBoarding3 ?
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                  child: CommonWidgets.getButton(
                      onPress: () {
                        onPressStartButton?.call();
                      },
                      text: buttonText ?? "",
                  ),
                ): Container(),
              ],
            ),
          ),

        ],
      ),
    );
  }
}