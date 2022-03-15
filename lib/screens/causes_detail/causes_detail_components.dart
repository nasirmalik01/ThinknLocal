import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/text_views.dart';

class CauseDetailComponents {
  Widget getCausesFundsContainer({
    required String? fullBoxImage,
    required String? logoImage,
    required String? name,
    required String? collectedAmount,
    required String? totalAmount,
    required String? endDate,
    required Function onClickBox,
    required double completePercentage,
    required bool isFavorite,
    required Function onPressBackArrow,
  }){
    //bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onClickBox.call(),
      child: Container(
        //width: getWidth() * 0.7,
        //margin: EdgeInsets.symmetric(horizontal: getWidth()*0.01),
        decoration: BoxDecoration(
            color: AppColors.greenColor,
            //borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.01)),
            image: DecorationImage(
                image: AssetImage(fullBoxImage!),
                fit: BoxFit.cover)
        ),
        child: Container(
          decoration: const BoxDecoration(
            //borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.01)),
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppColors.blackColor,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth()*0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: getWidth()*0.03, right: getWidth()*0.03, top: getHeight() * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => onPressBackArrow(),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.pureWhiteColor,
                          size: getHeight() * 0.03,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.save_alt,
                            color: AppColors.pureWhiteColor,
                            size: getHeight() * 0.03,
                          ),
                          SizedBox(width: sizes!.width * 0.03),
                          isFavorite? Icon(Icons.favorite, color: AppColors.greenColor, size: getHeight()*0.03,):
                          Icon(Icons.favorite_border, color: AppColors.pureWhiteColor, size: getHeight()*0.03,)
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: getWidth()*0.03, top: getHeight()*0.14),
                  child: SizedBox(
                    //width: getWidth()*0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: getHeight()*0.06,
                              width: getWidth() * 0.12,
                              decoration: BoxDecoration(
                                  color: AppColors.blackColor,
                                  borderRadius: BorderRadius.circular(getHeight() * 0.01),
                                  image: DecorationImage(
                                      image: AssetImage(logoImage!),
                                      fit: BoxFit.cover)
                              ),
                            ),
                            SizedBox(width: getWidth() * 0.02),
                            SizedBox(
                                width: getWidth() * 0.7,
                                child: TextView.regular16Text(name??"", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium, lines: 2)),
                          ],
                        ),
                        SizedBox(height: getHeight()*0.01),

                      ],
                    ),
                  ),
                ),
                LinearPercentIndicator(
                  padding: EdgeInsets.only(left: sizes!.width * 0.03, right: sizes!.width * 0.04),
                  barRadius: Radius.circular(sizes!.height* 0.01),
                  lineHeight: sizes!.height * 0.01,
                  percent: completePercentage,
                  backgroundColor: AppColors.pureWhiteColor,
                  progressColor: AppColors.greenColor,
                ),
                SizedBox(height: getHeight() * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: getWidth()*0.03, right: getWidth()*0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextView.bold12Text("Raised: ", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                          TextView.bold12Text("\$$collectedAmount", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular),
                          TextView.bold12Text(" of \$$totalAmount", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                        ],
                      ),
                      TextView.bold12Text("$endDate", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium),
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