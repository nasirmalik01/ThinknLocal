import 'package:flutter/cupertino.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/text_views.dart';

class LocationSearchComponents {
  Widget getCitiesContainer({
    String? cityName,
    String? distance,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: getWidth() * 0.6,
            child: TextView.bold15Text(cityName ?? "", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, lines: 1)),
        RichText(
          text: TextSpan(
              text: distance ?? "",
              style: TextStyle(
                color: AppColors.greenColor,
                fontSize: sizes.fontSize11,
                fontFamily: Assets.poppinsMedium,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: " Miles away",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: sizes.fontSize11,
                    fontFamily: Assets.poppinsMedium,
                  ),
                ),
              ]
          ),
        ),

      ],
    );
  }
}