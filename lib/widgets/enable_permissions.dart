import 'package:flutter/material.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:sizer/sizer.dart';

class EnablePermission extends StatelessWidget {
  final bool isLocation;
  final String? title;
  final String? description;
  final Function()? onGoToSettingsTap;
  final String? buttonText;


  const EnablePermission({Key? key, this.isLocation = true, this.title, this.description, this.onGoToSettingsTap, this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: EdgeInsets.only(left: sizes.width * 0.06, right: sizes.width * 0.06, top: getHeight() * 0.09),
            child: Column(
              children: [
               Image(
                 image: AssetImage(isLocation ? Assets.locationPermissionIcon : Assets.notificationPermissionIcon),
                 fit: BoxFit.fill,
                 height: getHeight()*0.24,
                 // height: 22.h,
               ),
                SizedBox(height: getHeight()*0.03,),
                TextView.subTitle(title, color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, isSetFontWeight: false, fontSize: 17.sp),
                SizedBox(height: getHeight()*0.025,),
                SizedBox(
                  height: getHeight()*0.12,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth()*0.15),
                    child: TextView.caption(description, color: AppColors.grayColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize15, isEllipsis: false, textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(height: getHeight() * 0.09),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.01),
                  child: Button(
                    onPress: onGoToSettingsTap,
                    text: buttonText,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
