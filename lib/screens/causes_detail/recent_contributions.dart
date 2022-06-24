import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';

class RecentContributions extends StatelessWidget {
  final String? contributorName;
  final String? amount;


  const RecentContributions({Key? key, this.contributorName, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: getWidth() * 0.55,
            child: TextView.subTitleWithBlurRadius(contributorName ?? "", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, lines: 1, fontSize: sizes.fontSize15)),
        RichText(
          text: TextSpan(
              text: "Contributed: ",
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: sizes.fontSize11,
                fontFamily: Assets.poppinsRegular,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '\$ $amount',
                  style: TextStyle(
                    color: AppColors.greenColor,
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
