import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/text_views.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CausesComponents {
  Widget getIconsContainer({required String image, required String label}) {
    return Column(
      children: [
        Container(
          height: getHeight() * 0.07,
          width: getWidth() * 0.2,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: AppColors.pureWhiteColor,
          ),
          child: Center(
              child: Image.asset(image)),
        ),
        TextView.regular11Text(label, color: AppColors.darkGrey, fontFamily: Assets.poppinsMedium)
      ],
    );
  }

  Widget typesFeaturedText({required String title, required bool isSelected, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: sizes.height * 0.04,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(
                  bottom: sizes.height * 0.002,
                ),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      color: isSelected ? AppColors.greenColor: AppColors.pureWhiteColor,
                      width: sizes.width * 0.005, // This would be the width of the underline
                    ))
                ),
              child:
              TextView.getMediumText15(
                title,
                color: isSelected ? AppColors.blackColor: AppColors.darkGrey,
                fontFamily: Assets.poppinsMedium
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget getCausesFundsContainer({
    required String? fullBoxImage,
    required String? logoImage,
    required String? name,
    required String? collectedAmount,
    required String? totalAmount,
    required String? endDate,
    required Function onClickBox,
    required double completePercentage,
  }){
    bool isImageUrl = Uri.tryParse(fullBoxImage!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onClickBox.call(),
      child: Container(
        width: getWidth() * 0.7,
        margin: EdgeInsets.only(right: getWidth()*0.04),
        decoration: BoxDecoration(
            color: AppColors.greenColor,
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
                            height: 5.6.h,
                            width: 5.6.h,
                            decoration: BoxDecoration(
                                color: AppColors.blackColor,
                                borderRadius: BorderRadius.circular(getHeight() * 0.01),
                                image: DecorationImage(
                                    image: AssetImage(logoImage!),
                                    fit: BoxFit.cover)
                            ),
                          ),
                          SizedBox(width: getWidth() * 0.03),
                          SizedBox(
                            width: getWidth() * 0.5,
                              child: TextView.bold15Text(name??"", color: AppColors.pureWhiteColor,
                                  fontFamily: Assets.poppinsMedium, lines: 2, blurRadius: 5)),
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
                        TextView.semiBold10Text("\$$collectedAmount", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular),
                        TextView.semiBold10Text(" of \$$totalAmount", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                      ],
                    ),
                    TextView.semiBold10Text("Ends $endDate", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium),
                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRecentlyStartedContainer({
    String? image,
    String? name,
    required List<Color> colors,
    required Function onPressFullContainer
  }){
    bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onPressFullContainer.call(),
      child: Container(
        width: getWidth() * 0.40,
        margin: EdgeInsets.only(right: getWidth()*0.03),
        decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(getHeight() * 0.015),
            image: DecorationImage(
                image: isImageUrl ? NetworkImage(image): AssetImage(image) as ImageProvider,
                fit: BoxFit.cover)
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.015)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: getHeight() * 0.08, left: getWidth() * 0.03, right: getWidth() * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    name??"",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    height: getHeight() * 0.0015,
                    fontSize: sizes.fontSize15,
                    fontFamily: Assets.poppinsMedium,
                    color: AppColors.pureWhiteColor,
                    shadows: const [
                      Shadow(
                          blurRadius: 5,
                          //offset: Offset(0.0, 1)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}