import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/widgets/common_widgets.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';

class BusinessRating extends StatelessWidget {
  final double? starRating;
  final bool? ignoreEdit;
  final Function? onPress;
  const BusinessRating({Key? key, this.starRating, this.ignoreEdit, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getWidth()*0.003),
          child: TextView.headerWithBlurRadius("$starRating ${Strings.customerRatings}", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize14),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: getHeight() * 0.002, vertical: getWidth() * 0.01),
            decoration: BoxDecoration(
              color: AppColors.boxGrey,
              borderRadius: BorderRadius.circular(getHeight() * 0.012),
            ),
            child: Row(
              children: [
                SizedBox(width: getWidth() * 0.04),
                CommonWidgets.getRating(
                  starRating: starRating,
                  ignoreEdit: ignoreEdit,
                  onPress: onPress,
                ),
                const Expanded(child: SizedBox()),
                TextView.caption("$starRating ${Strings.outOf5}", color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, lines: 1, fontSize: sizes.fontSize13),
                SizedBox(width: getWidth()*0.03,)
              ],
            )
        ),
      ],
    );
  }
}
