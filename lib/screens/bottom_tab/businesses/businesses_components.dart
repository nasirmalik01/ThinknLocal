import 'package:flutter/cupertino.dart';

import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/text_views.dart';

class BusinessesComponents {
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
}