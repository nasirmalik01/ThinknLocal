import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/text_views.dart';

class BusinessesComponents {
  Widget businessCategoryIcon({
    required String image,
    required String label,
    required Function onPressCategory
  }) {
    return GestureDetector(
      onTap: () => onPressCategory(),
      child: Column(
        children: [
          Container(
            height: getHeight() * 0.055,
            width: getWidth() * 0.2,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: AppColors.pureWhiteColor,
            ),
            child: Center(
                child: Image.asset(image)),
          ),
          SizedBox(height: 0.3.h,),
          TextView.caption(label, color: AppColors.darkGrey, fontFamily: Assets.poppinsMedium)
        ],
      ),
    );
  }

  Widget typesFeaturedText({required String title, required bool isSelected}) {
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
            TextView.titleWithDecoration(
                title,
                color: isSelected ? AppColors.blackColor: AppColors.darkGrey,
                fontFamily: Assets.poppinsMedium
            ),
          ),

        ],
      ),
    );
  }
}