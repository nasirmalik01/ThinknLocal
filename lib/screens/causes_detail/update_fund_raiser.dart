import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';

class UpdateFundRaiser extends StatelessWidget {
  final String header;
  final String detail;
  final String date;


  const UpdateFundRaiser({Key? key, required this.header, required this.detail, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getHeight() * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView.subTitleWithBlurRadius(header, color: AppColors.greenColor, fontFamily: Assets.poppinsMedium, lines: 1, fontSize: sizes.fontSize15),
              TextView.caption(date, color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize13,)
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: getWidth() * 0.19),
            child: TextView.headerWithBlurRadius(detail, color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, lines: 2, fontSize: sizes.fontSize13,),
          ),
        ],
      ),
    );  }
}
