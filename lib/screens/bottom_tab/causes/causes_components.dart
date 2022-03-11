import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/text_views.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CausesComponents {
  Widget getIconsContainer({required String image, required String label}) {
    return Column(
      children: [
        Container(
          height: getHeight() * 0.07,
          width: getWidth() * 0.2,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: AppColors.pureWhiteColor,
          ),
          child: Center(
              child: Image.asset(image)),
        ),
        TextView.regular11Text(label, color: AppColors.darkGrey, fontFamily: Assets.poppinsMedium)
      ],
    );
  }

  Widget typesText({required String title, required bool isSelected}) {
    return Container(
      height: sizes!.height * 0.04,
      padding: EdgeInsets.symmetric(horizontal: sizes!.width * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(
                bottom: sizes!.height * 0.002,
              ),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(
                    color: isSelected ? AppColors.greenColor: AppColors.pureWhiteColor,
                    width: sizes!.width * 0.005, // This would be the width of the underline
                  ))
              ),
            child:
            TextView.getMediumText15(
              title,
              color: isSelected ? AppColors.blackColor: AppColors.darkGrey,
              fontFamily: Assets.poppinsMedium
            ),
          ),

        ],
      ),
    );
  }

  Widget getImageContainer({
    required String? fullBoxImage,
    required String? logoImage,
    required String? name,
    required String? bookName,
    required String? collectedAmount,
    required String? totalAmount,
    required String? endDate,
    required Function onClickBox,
    required double completePercentage,
  }){
    //bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onClickBox.call(),
      child: Container(
        width: getWidth() * 0.7,
        margin: EdgeInsets.symmetric(horizontal: getWidth()*0.01),
        decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                image: AssetImage(fullBoxImage!),
                fit: BoxFit.cover)
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppColors.blackColor,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: getWidth()*0.03, top: getHeight()*0.12),
                child: SizedBox(
                  width: getWidth()*0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: getHeight()*0.05,
                            width: getWidth() * 0.1,
                            decoration: BoxDecoration(
                                color: AppColors.blackColor,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(logoImage!),
                                    fit: BoxFit.cover)
                            ),
                          ),
                          SizedBox(width: getWidth() * 0.02),
                          SizedBox(
                            width: getWidth() * 0.5,
                              child: TextView.bold15Text(name??"", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium, lines: 2)),
                        ],
                      ),
                      SizedBox(height: getHeight()*0.01),

                      //TextView.regular12Text(bookName??"", color: AppColors.pureWhiteColor),
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
                        TextView.semiBold10Text("\$$collectedAmount", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular),
                        TextView.semiBold10Text(" of \$$totalAmount", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                      ],
                    ),
                    TextView.semiBold10Text("Ends $endDate", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium),
                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}