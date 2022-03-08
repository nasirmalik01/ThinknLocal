import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/text_views.dart';

class NotificationComponents {
  Widget notificationCard({
    @required String? image,
    @required String? text,
    @required String? subText,
    @required String? date,
    @required Function? onPressNotification
  }) {

    bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 5),
      child: GestureDetector(
        onTap: () => onPressNotification!(),
        child: Column(
          children: [
            Container(
              width: sizes!.width * 0.90,
              //height: sizes!.height * 0.12,
              padding: EdgeInsets.only(top: sizes!.heightRatio * 10, bottom: sizes!.heightRatio * 10, left: sizes!.heightRatio * 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: sizes!.width * 0.16,

                    child: Image(
                      image: AssetImage(image),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: sizes!.width * 0.03),
                  SizedBox(
                    width: sizes!.width * 0.67,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: sizes!.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView.getMediumText15(text, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                            TextView.bold12Text(date, color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 1),
                          ],
                        ),
                        SizedBox(height: sizes!.height * 0.01),
                        TextView.bold12Text(subText, color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 5,
              color: AppColors.borderColor,
            ),
          ],
        ),
      ),
    );
  }
}
