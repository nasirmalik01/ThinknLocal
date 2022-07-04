import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/widgets/dialog_button.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';
import 'package:get/get.dart';

customDialog({String? backgroundImage, String? icon, String? title, String? summary, String? description, Function()? onClickLearnMore, bool isLearnMoreButton = true}){
  Get.dialog(
    Center(
      child: Wrap(
        children: [
          Container(
            width: getWidth()*0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(getHeight() * 0.02),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.only(left: getWidth()*0.06, right: getWidth()*0.06, bottom: getHeight()*0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getHeight()*0.16,
                      child: Stack(
                        children: [
                          Container(
                            height: getHeight()*0.12,
                            width: getHeight(),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(getHeight() * 0.02), topRight: Radius.circular(getHeight() * 0.02)),
                              color: AppColors.pureWhiteColor,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        backgroundImage ?? Strings.dummyBgImage
                                    ),
                                    fit: BoxFit.cover,
                                    opacity: 0.6
                                )
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: getWidth()*0.2,
                            right: getWidth()*0.2,
                            child: Container(
                              height: getHeight()*0.1,
                              width: getHeight()*0.1,
                              decoration: BoxDecoration(
                                color: AppColors.pureWhiteColor,
                                  borderRadius: BorderRadius.circular(getHeight()*0.01),
                                  border: Border.all(
                                      width: 2,
                                      color: AppColors.pureWhiteColor
                                  ),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          icon ?? Strings.dummyLogoForDialog
                                      ),
                                      fit: BoxFit.contain
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getHeight()*0.02,),
                    TextView.titleWithBlurRadius(title ?? 'Target', Assets.poppinsMedium, color: AppColors.blackColor, fontSize: sizes.fontSize20, lines: 1),
                    SizedBox(height: getHeight()*0.02,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView.caption(summary ?? 'Target is lorem ipsum doloar sit amet lariet.', color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, isEllipsis: false, fontSize: sizes.fontSize12,),
                        SizedBox(height: getHeight()*0.02,),
                        TextView.header(description ?? 'Lorem ipsum dolor sit amet, sonsectetur adipiscing elit. Suspensisse quis metus vel nisl aliquam trislique. Etiam sit amet.', color: AppColors.blackColor, fontFamily: Assets.poppinsRegular,  fontSize: sizes.fontSize12, isElipses: false),
                        SizedBox(height: getHeight()*0.03,),
                        isLearnMoreButton
                        ? Row(
                          children: [
                            Expanded(
                              child: DialogButton(
                                height: getHeight()*0.06,
                                textColor: AppColors.pureWhiteColor,
                                btnColor: AppColors.greenColor,
                                text: 'Learn More',
                                onPress: onClickLearnMore,
                              ),
                            ),
                            SizedBox(width: getWidth()*0.04,),
                            Expanded(
                              child: DialogButton(
                                height: getHeight()*0.06,
                                textColor: AppColors.lightPurpleColor,
                                btnColor: AppColors.pureWhiteColor,
                                text: 'Close',
                                borderColor: AppColors.lightPurpleColor,
                                onPress: (){
                                  log('Okay');
                                  Get.back();
                                },
                              ),
                            )
                          ],
                        )
                        :  Center(
                          child: DialogButton(
                            height: getHeight()*0.06,
                            textColor: AppColors.lightPurpleColor,
                            btnColor: AppColors.pureWhiteColor,
                            text: 'Close',
                            borderColor: AppColors.lightPurpleColor,
                            onPress: (){
                              log('Okay');
                              Get.back();
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    )
  );
}
