import 'package:flutter/material.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/text_views.dart';

class AccountComponents {
  Widget profileBox({
    @required String? name,
    @required String? email,
    @required String? nameShort,
    @required Function? onTapEdit,
  }) {
    return Column(
      children: [
        SizedBox(
          height: sizes.height * 0.25,
          width: sizes.width,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView.headerWithBlurRadius("Help", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, textDecoration: TextDecoration.underline),
                  TextView.headerWithBlurRadius("Sign out", color: AppColors.orangeColor, fontFamily: Assets.poppinsMedium, textDecoration: TextDecoration.underline),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: getHeight()*0.036),
              padding: EdgeInsets.symmetric(vertical: sizes.height * 0.03),
              height: sizes.height * 0.19,
              width: sizes.width * 0.88,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.pureWhiteColor,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: getHeight() * 0.01),
                  TextView.header(name, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize25),
                  SizedBox(height: getHeight() * 0.008),
                  TextView.headerWithBlurRadius(email, color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular),
                  SizedBox(height: getHeight() * 0.01),
                  GestureDetector(
                    onTap: () => onTapEdit!(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.edit, size: 15, color: AppColors.greenColor),
                        SizedBox(width: sizes.width * 0.015),
                        TextView.headerWithBlurRadius("Edit Account Info", color: AppColors.greenColor, textDecoration: TextDecoration.underline),
                      ],
                    ),
                  ),
                ],
              ),
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: sizes.height * 0.075,
                    width: sizes.width * 0.16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.greenColor,
                    ),
                  child: Center(child: TextView.header(nameShort, color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsSemiBold)),
              ),
                ],
              )
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
      height: sizes.height * 0.1,
      width: sizes.width,
      color: Colors.amber,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 25,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView.titleWithDecoration(title, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium),
              TextView.caption(description, color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular)
            ],
          ),

        ],
      ),
    );
  }

}