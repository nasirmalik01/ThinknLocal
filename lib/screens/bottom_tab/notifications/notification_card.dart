import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';

class NotificationCard extends StatelessWidget {
  final String? image;
  final String? text;
  final String? subText;
  final String? date;
  final Function? onPressNotification;
  final bool isSentReceipts;


  const NotificationCard(
      {Key? key, this.image,
      this.text,
      this.subText,
      this.date,
      this.onPressNotification,
      this.isSentReceipts = false
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressNotification!(),
      child: Column(
        children: [
          Container(
            width: sizes.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: sizes.width * 0.16,
                  height: sizes.width * 0.16,
                  child: Image(
                    image: AssetImage(image!),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(width: sizes.width * 0.03),
                SizedBox(
                  width: sizes.width * 0.70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView.titleWithDecoration(text, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                          TextView.headerWithBlurRadius(date, color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 1),
                        ],
                      ),
                      SizedBox(height: sizes.height * 0.005),
                      TextView.headerWithBlurRadius(subText, color: isSentReceipts ? AppColors.greenColor : AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getHeight() * 0.01),
        ],
      ),
    );
  }
}
