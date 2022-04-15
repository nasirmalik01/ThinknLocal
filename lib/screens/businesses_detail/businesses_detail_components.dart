import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/text_views.dart';

class BusinessesDetailComponents {
  Widget ratingContainer({required double? starRating, ignoreEdit, Function? onPress}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView.headerWithBlurRadius("40 customer ratings", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
        Container(
          width: getWidth(),
          padding: EdgeInsets.symmetric(horizontal: getHeight() * 0.002, vertical: getWidth() * 0.02),
          decoration: BoxDecoration(
            color: AppColors.boxGrey,
            borderRadius: BorderRadius.circular(getHeight() * 0.01),
          ),
          child: Row(
            children: [
              SizedBox(width: getWidth() * 0.04),
              CommonWidgets.getRating(
                starRating: starRating,
                ignoreEdit: ignoreEdit,
                onPress: onPress,
              ),
              SizedBox(width: getWidth() * 0.05),
              TextView.caption("4.5 out of 5", color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, lines: 1),
            ],
          )
        ),
      ],
    );
  }

}