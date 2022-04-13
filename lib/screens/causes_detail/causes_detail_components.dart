import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/text_views.dart';

class CauseDetailComponents {
  Widget descriptionTextContainer({required String heading, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView.caption(heading, color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize18),
        SizedBox(height: getHeight() * 0.01),
        TextView.caption(description, color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, lines: 3, fontSize: sizes.fontSize13)
      ],
    );
  }

  Widget typesText({required String title, required bool isSelected}) {
    return SizedBox(
      height: sizes.height * 0.04,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: sizes.height * 0.002,
            ),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                  color: isSelected ? AppColors.greenColor: AppColors.pureWhiteColor,
                  width: sizes.width * 0.005,
                ))
            ),
            child:
            TextView.headerWithBlurRadius(
                title,
                color: isSelected ? AppColors.blackColor: AppColors.darkGrey,
                fontFamily: Assets.poppinsMedium,
                fontSize: sizes.fontSize14
            ),
          ),

        ],
      ),
    );
  }

  Widget statsGraphBottomTitles(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mar 1';
        break;
      case 1:
        text = 'Mar 2';
        break;
      case 2:
        text = 'Mar 3';
        break;
      case 3:
        text = 'Mar 4';
        break;
      case 4:
        text = 'Mar 5';
        break;
      default:
        text = '';
        break;
    }
    return Center(child: TextView.subHeader(text, color: AppColors.pureBlack, fontFamily: Assets.poppinsRegular));
  }

  Widget statsGraphLeftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    return Padding(
      child: TextView.subHeader(meta.formattedValue, color: AppColors.pureBlack, fontFamily: Assets.poppinsRegular),
      padding: EdgeInsets.only(left: getWidth() * 0.02),
    );
  }
}