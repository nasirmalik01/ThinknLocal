import 'package:flutter/material.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:sizer/sizer.dart';

class OnBoardingPageLayout extends StatelessWidget {
  final String heading;
  final String image;
  final String subHeading;
  final String description;
  bool isOnBoarding3;
  Function? onPressStartButton;
  bool isFirstPage;
  String? buttonText;


  OnBoardingPageLayout(
      {Key? key, required this.heading,
      required this.image,
      required this.subHeading,
      required this.description,
      required this.isOnBoarding3,
      this.onPressStartButton,
      this.isFirstPage  = false,
      this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
