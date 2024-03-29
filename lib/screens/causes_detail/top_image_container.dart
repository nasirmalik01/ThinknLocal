import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';

class CausesDetailTopImageContainer extends StatelessWidget {
  final String? fullBoxImage;
  final String? logoImage;
  final String? name;
  final String? collectedAmount;
  final String? totalAmount;
  final String? endDate;
  final Function onClickBox;
  final double completePercentage;
  final bool isFavorite;
  final Function() onPressBackArrow;
  final Function onPressFavoriteIcon;
  final Function() onShareClick;


  const CausesDetailTopImageContainer(
      {Key? key, this.fullBoxImage,
      this.logoImage,
      this.name,
      this.collectedAmount,
      this.totalAmount,
      this.endDate,
      required this.onClickBox,
      required this.completePercentage,
      required this.isFavorite,
      required this.onPressBackArrow,
      required this.onPressFavoriteIcon,
      required this.onShareClick
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isImageUrl = Uri.tryParse(fullBoxImage!)?.hasAbsolutePath ?? false;
    dynamic _collectedFormattedAmount = commaFormatter(double.parse(collectedAmount!));
    dynamic _totalFormattedAmount = commaFormatter(double.parse(totalAmount!));

    return GestureDetector(
      onTap: ()=> onClickBox.call(),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.greenColor,
            image: DecorationImage(
                image: isImageUrl ? NetworkImage(fullBoxImage!): const AssetImage(Assets.causesDetailBgImage) as ImageProvider,
                fit: BoxFit.cover)
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
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
              Container(
                alignment: Alignment.topCenter,
                height: getHeight()*0.1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black54,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: getWidth()*0.04, top: getHeight() * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap:  onPressBackArrow,
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.topLeft,
                          width: getWidth()*0.15,
                          height: getHeight(),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.pureWhiteColor,
                            size: getHeight() * 0.03,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: onShareClick,
                            child: Container(
                              color: Colors.transparent,
                              alignment: Alignment.topRight,
                              width: getWidth()*0.1,
                              height: getHeight(),
                              child: Icon(
                                Icons.ios_share,
                                color: AppColors.pureWhiteColor,
                                size: getHeight() * 0.03,
                              ),
                            ),
                          ),
                          SizedBox(width: sizes.width * 0.03),
                          Padding(
                            padding: EdgeInsets.only(top: 0.5.h),
                            child: GestureDetector(
                                onTap: () => onPressFavoriteIcon(),
                                child: Container(
                                  color: Colors.transparent,
                                  alignment: Alignment.topLeft,
                                  width: getWidth()*0.1,
                                  height: getHeight(),
                                  child: isFavorite? Icon(Icons.favorite, color: AppColors.greenColor, size: getHeight()*0.03,):
                                  Icon(Icons.favorite_border, color: AppColors.pureWhiteColor, size: getHeight()*0.03,),
                                )
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth()*0.02),
                child: Container(
                  padding: EdgeInsets.only(left: getWidth()*0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: getHeight()*0.06,
                            width: getHeight()*0.06,
                            decoration: BoxDecoration(
                                color: AppColors.pureWhiteColor,
                                borderRadius: BorderRadius.circular(getHeight() * 0.01),
                                image: DecorationImage(
                                    image: NetworkImage(logoImage!),
                                    fit: BoxFit.contain)
                            ),
                          ),
                          SizedBox(width: getWidth() * 0.03),
                          SizedBox(
                              width: getWidth() * 0.7,
                              child: TextView.titleWithBlurRadius(name??"", Assets.poppinsMedium, color: AppColors.pureWhiteColor,  lines: 2, fontSize: sizes.fontSize18)),
                        ],
                      ),
                      SizedBox(height: getHeight()*0.01),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth()*0.02),
                child: LinearPercentIndicator(
                  padding: EdgeInsets.only(left: sizes.width * 0.03, right: sizes.width * 0.04),
                  barRadius: Radius.circular(sizes.height* 0.01),
                  lineHeight: sizes.height * 0.01,
                  percent: completePercentage,
                  backgroundColor: AppColors.pureWhiteColor,
                  progressColor: AppColors.greenColor,
                ),
              ),
              SizedBox(height: getHeight() * 0.01),
              Padding(
                padding: EdgeInsets.only(left: getWidth()*0.05, right: getWidth()*0.05, bottom: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        TextView.headerWithBlurRadius("Raised: ", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                        TextView.headerWithBlurRadius("\$$_collectedFormattedAmount", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular),
                        TextView.headerWithBlurRadius(" of \$$_totalFormattedAmount", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                      ],
                    ),
                    TextView.headerWithBlurRadius("$endDate", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium),
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
