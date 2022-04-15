import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';

class AccountSettingCard extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? leadingIcon;
  final Function(bool value) onChange;
  final bool? switchValue;

  const AccountSettingCard({Key? key, this.title, this.subTitle, this.leadingIcon, required this.onChange, this.switchValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getHeight() * 0.08,
          width: getWidth(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: sizes.width * 0.02),
              SizedBox(
                  height: getHeight() * 0.04,
                  width: getWidth() * 0.06,
                  child: Image.asset(leadingIcon!, color: switchValue! ? AppColors.greenColor: AppColors.darkGrey,)),
              SizedBox(width: sizes.width * 0.05),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView.titleWithDecoration(title, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                      SizedBox(
                          width: sizes.width * 0.45,
                          child: TextView.caption(subTitle, color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 2))
                    ],
                  ),
                  SizedBox(width: sizes.width * 0.1),
                  CupertinoSwitch(activeColor: AppColors.greenColor ,value: switchValue!, onChanged: (bool value) { onChange(value); }),
                ],
              ),
            ],
          ),

        ),
        Divider(height: getHeight() * 0.03, thickness: getHeight() * 0.001 ,color: AppColors.borderColor),
      ],
    );
  }
}
