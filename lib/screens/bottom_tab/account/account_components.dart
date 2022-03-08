import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/text_views.dart';

class AccountComponents {
  Widget profileBox({
    @required String? name,
    @required String? email,
    @required String? nameShort,
  }) {
    return Column(
      children: [
        Container(
          height: sizes!.height * 0.25,
          width: sizes!.width,

          //color: Colors.amber,
          child: Stack(
              alignment: Alignment.center,
            children: [
              Positioned(
                top: sizes!.height * 0.03,
                child: Container(
                padding: EdgeInsets.symmetric(vertical: sizes!.height * 0.03),
                height: sizes!.height * 0.2,
                width: sizes!.width * 0.88,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.pureWhiteColor,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      blurRadius: 2,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: getHeight() * 0.02),
                    TextView.bold25Text(name, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium),
                    SizedBox(height: getHeight() * 0.008),
                    TextView.bold12Text(email, color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular),
                    SizedBox(height: getHeight() * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.edit, size: 15, color: AppColors.greenColor),
                        SizedBox(width: sizes!.width * 0.015),
                        TextView.bold12Text("Edit Account Info", color: AppColors.greenColor, textDecoration: TextDecoration.underline),
                      ],
                    ),
                  ],
                ),
            ),
              ),
              Positioned(
                top: sizes!.heightRatio * 0,
                right: sizes!.width * 0.37,
                child: Container(
                  height: sizes!.height * 0.065,
                  width: sizes!.width * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.greenColor,
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: AppColors.shadowColor,
                    //     blurRadius: 2,
                    //     offset: Offset(0, 0),
                    //   ),
                    // ],
                  ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextView.bold30Text(nameShort, color: AppColors.pureWhiteColor, fontFamily: Assets.latoBold),
                ),
              ),)
            ]
          ),
        ),
      ],
    );
  }

  Widget accountSettingCard({
    required icon,
    @required String? title,
    @required String? description
  }) {
    return Container(
      height: sizes!.height * 0.1,
      width: sizes!.width,
      color: Colors.amber,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 25,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView.getMediumText15(title, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium),
              TextView.regular11Text(description, color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular)
            ],
          ),

        ],
      ),
    );
  }

}