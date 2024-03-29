import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

class CausesFundContainer extends StatelessWidget {
  final String fullBoxImage;
  final String logoImage;
  final String name;
  final String collectedAmount;
  final String totalAmount;
  final String endDate;
  final Function onClickBox;
  final double completePercentage;
  final int index;
  final String dateStatus;

  const CausesFundContainer(
      {Key? key, required this.fullBoxImage,
      required this.logoImage,
      required this.name,
      required this.collectedAmount,
      required this.totalAmount,
      required this.endDate,
      required this.onClickBox,
      required this.completePercentage,
      required this.index,
      required this.dateStatus
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isImageUrl = Uri.tryParse(fullBoxImage)?.hasAbsolutePath ?? false;
    dynamic _collectedFormattedAmount = commaFormatter(double.parse(collectedAmount));
    dynamic _totalFormattedAmount = commaFormatter(double.parse(totalAmount));

    return GestureDetector(
      onTap: ()=> onClickBox.call(),
      child: Container(
        width: getWidth() * 0.7,
        margin: EdgeInsets.only(left: index == 0 ? getWidth()*0.06 : getWidth()*0.03),
        decoration: BoxDecoration(
            color: AppColors.pureWhiteColor,
            borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.02)),
            image: DecorationImage(
                image: isImageUrl ? NetworkImage(fullBoxImage) : AssetImage(fullBoxImage) as ImageProvider,
                fit: BoxFit.cover)
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.02)),
            gradient: const LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppColors.blackColor,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: SizedBox()),
              Container(
                padding: EdgeInsets.only(left: getWidth()*0.03),
                child: SizedBox(
                  width: getWidth()*0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: getWidth()*0.12,
                            width: getWidth()*0.12,
                            decoration: BoxDecoration(
                                color: AppColors.pureWhiteColor,
                                borderRadius: BorderRadius.circular(getHeight() * 0.01),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        logoImage,
                                    ),
                                    fit: BoxFit.contain,
                                )
                            ),
                          ),
                          SizedBox(width: getWidth() * 0.03),
                          SizedBox(
                              width: getWidth() * 0.5,
                              child: TextView.headerWithBlurRadius(name, color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium, lines: 2, blurRadius: 0, fontSize: sizes.fontSize16)),
                        ],
                      ),
                      SizedBox(height: getHeight()*0.015),
                    ],
                  ),
                ),
              ),
              LinearPercentIndicator(
                padding: EdgeInsets.only(left: sizes.width * 0.03, right: sizes.width * 0.04),
                barRadius: Radius.circular(sizes.height* 0.05),
                lineHeight: sizes.height * 0.01,
                percent: completePercentage,
                backgroundColor: AppColors.pureWhiteColor,
                progressColor: AppColors.greenColor,
              ),
              SizedBox(height: getHeight() * 0.01),
              Padding(
                padding: EdgeInsets.only(left: getWidth()*0.03, right: getWidth()*0.03, bottom: 0.8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        TextView.subHeader("\$$_collectedFormattedAmount", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular),
                        TextView.subHeader(" ${Strings.of} \$$_totalFormattedAmount", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                      ],
                    ),
                    TextView.subHeader("$dateStatus $endDate", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
