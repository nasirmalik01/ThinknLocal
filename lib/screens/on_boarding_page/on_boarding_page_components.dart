import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:sizer/sizer.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';

class OnBoardingPageComponents {
  Widget onBoardingPageDesign({
    required String heading,
    required String image,
    required String subHeading,
    required String description,
    required bool isOnBoarding3,
    Function? onPressStartButton,
    bool isFirstPage = false,
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: PreferenceUtils.getGradient()
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: sizes.width * 0.06, right: sizes.width * 0.06, top: sizes.width * 0.06),
            child: Column(
              children: [
                SizedBox(height: isFirstPage ? 2.h : 0,),
                TextView.subTitle(heading, color: AppColors.greenColor, fontFamily: Assets.poppinsMedium, isSetFontWeight: false, fontSize: 21.09.sp),
                Image(
                  image: AssetImage(image),
                  fit: BoxFit.fill,
                  height: 32.h,
                ),
                TextView.title(subHeading, color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                SizedBox(height: getHeight() * 0.02),
                TextView.titleWithDecoration(description, color: AppColors.blackColor, textAlign: TextAlign.center, fontFamily: Assets.poppinsRegular),
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