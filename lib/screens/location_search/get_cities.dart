import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';

class GetCities extends StatelessWidget {
  final String? cityName;
  final String? distance;


  const GetCities({Key? key, this.cityName, this.distance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: getWidth() * 0.6,
            child: TextView.title(cityName ?? "", color: AppColors.blackColor, fontFamily: Assets.poppinsSemiBold, lines: 1, fontSize: sizes.fontSize15)),
        RichText(
          text: TextSpan(
              text: distance ?? "",
              style: TextStyle(
                color: AppColors.greenColor,
                fontSize: sizes.fontSize12,
                fontFamily: Assets.poppinsMedium,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: " Miles away",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: sizes.fontSize12,
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
