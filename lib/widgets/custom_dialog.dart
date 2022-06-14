import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/dialog_button.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:get/get.dart';

customDialog({String? backgroundImage, String? icon, String? title, String? summary, String? description, Function()? onClickLearnMore}){
  Get.dialog(
    Center(
      child: Container(
        height: getHeight()*0.47,
        width: getWidth()*0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(getHeight() * 0.02),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            children: [
              SizedBox(
                height: getHeight()*0.16,
                child: Stack(
                  children: [
                    Container(
                      height: getHeight()*0.12,
                      width: getHeight(),
                      decoration: BoxDecoration(
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
                      left: getWidth()*0.3,
                      right: getWidth()*0.3,
                      child: Container(
                        height: getHeight()*0.1,
                        width: getHeight()*0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(getHeight()*0.02),
                            border: Border.all(
                                width: 2,
                                color: AppColors.pureWhiteColor
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                    icon ?? Strings.dummyLogoForDialog
                                ),
                                fit: BoxFit.fill
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth()*0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView.caption(summary ?? 'Target is lorem ipsum doloar sit amet lariet.', color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, lines: 1, fontSize: sizes.fontSize12,),
                    SizedBox(height: getHeight()*0.02,),
                    SizedBox(
                        height: getHeight()*0.072,
                        child: TextView.header(description ?? 'Lorem ipsum dolor sit amet, sonsectetur adipiscing elit. Suspensisse quis metus vel nisl aliquam trislique. Etiam sit amet.', color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, lines: 3, fontSize: sizes.fontSize12, )),
                    SizedBox(height: getHeight()*0.03,),
                    Row(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
  );
}
