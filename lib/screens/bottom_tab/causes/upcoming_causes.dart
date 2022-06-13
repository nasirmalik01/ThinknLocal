import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';

class UpcomingCauses extends StatelessWidget {
  final String? image;
  final String? headerText;
  final String? description;
  final String? totalAmount;
  final String? date;
  final Function() onViewCourse;


  const UpcomingCauses(
      {Key? key, this.image,
      this.headerText,
      this.description,
      this.totalAmount,
      this.date,
      required this.onViewCourse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: getHeight()*0.085,
              width: getWidth()*0.18,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: isImageUrl ? NetworkImage(image!): const AssetImage(Assets.dummyLogo) as ImageProvider,
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(getHeight() * 0.01)
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: getWidth()*0.02),
              width: getWidth()*0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView.caption(headerText??"", color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, fontSize: sizes.fontSize12),
                  SizedBox(height: getHeight()*0.003),
                  TextView.titleWithDecoration(description??"", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 2, height: getHeight() * 0.0016),
                  SizedBox(height: getHeight()*0.006),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: '${Strings.raising} ',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: sizes.fontSize11,
                              fontFamily: Assets.poppinsRegular,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '\$$totalAmount',
                                style: TextStyle(
                                  color: AppColors.greenColor,
                                  fontSize: sizes.fontSize11,
                                  fontFamily: Assets.poppinsMedium,
                                ),
                              ),
                              TextSpan(
                                text: ';',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: sizes.fontSize11,
                                  fontFamily: Assets.poppinsMedium,
                                ),
                              ),
                              TextSpan(
                                text: ' ${Strings.starting} ',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: sizes.fontSize11,
                                  fontFamily: Assets.poppinsRegular,
                                ),
                              ),
                              TextSpan(
                                text: date,
                                style: TextStyle(
                                  color: AppColors.greenColor,
                                  fontSize: sizes.fontSize11,
                                  fontFamily: Assets.poppinsMedium,
                                ),
                              )
                            ]
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
