import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';

Widget customTabBar({required String title, required bool isSelected, Function()? onTap, bool isDetail = false}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
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
                  width: sizes.width * 0.005, // This would be the width of the underline
                ))
            ),
            child:
            TextView.titleWithDecoration(
                title,
                color: isSelected ? AppColors.blackColor: AppColors.darkGrey,
                fontFamily: Assets.poppinsMedium,
                fontSize: isDetail ? sizes.fontSize14 : sizes.fontSize18
            ),
          ),
        ],
      ),
    ),
  );
}
