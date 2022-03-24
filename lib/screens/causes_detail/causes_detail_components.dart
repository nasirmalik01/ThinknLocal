import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/text_views.dart';

class CauseDetailComponents {
  Widget getCausesFundsContainer({
    required String? fullBoxImage,
    required String? logoImage,
    required String? name,
    required String? collectedAmount,
    required String? totalAmount,
    required String? endDate,
    required Function onClickBox,
    required double completePercentage,
    required bool isFavorite,
    required Function onPressBackArrow,
  }){
    //bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onClickBox.call(),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.greenColor,
            image: DecorationImage(
                image: AssetImage(fullBoxImage!),
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth()*0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: getWidth()*0.03, right: getWidth()*0.03, top: getHeight() * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => onPressBackArrow(),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.pureWhiteColor,
                          size: getHeight() * 0.03,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.ios_share,
                            color: AppColors.pureWhiteColor,
                            size: getHeight() * 0.03,
                          ),
                          SizedBox(width: sizes.width * 0.03),
                          isFavorite? Icon(Icons.favorite, color: AppColors.greenColor, size: getHeight()*0.03,):
                          Icon(Icons.favorite_border, color: AppColors.pureWhiteColor, size: getHeight()*0.03,)
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: getWidth()*0.03, top: getHeight()*0.14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: getHeight()*0.06,
                            width: getWidth() * 0.12,
                            decoration: BoxDecoration(
                                color: AppColors.blackColor,
                                borderRadius: BorderRadius.circular(getHeight() * 0.01),
                                image: DecorationImage(
                                    image: AssetImage(logoImage!),
                                    fit: BoxFit.cover)
                            ),
                          ),
                          SizedBox(width: getWidth() * 0.02),
                          SizedBox(
                              width: getWidth() * 0.7,
                              child: TextView.regular16Text(name??"", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium, lines: 2)),
                        ],
                      ),
                      SizedBox(height: getHeight()*0.01),

                    ],
                  ),
                ),
                LinearPercentIndicator(
                  padding: EdgeInsets.only(left: sizes.width * 0.03, right: sizes.width * 0.04),
                  barRadius: Radius.circular(sizes.height* 0.01),
                  lineHeight: sizes.height * 0.01,
                  percent: completePercentage,
                  backgroundColor: AppColors.pureWhiteColor,
                  progressColor: AppColors.greenColor,
                ),
                SizedBox(height: getHeight() * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: getWidth()*0.03, right: getWidth()*0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextView.bold12Text("Raised: ", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                          TextView.bold12Text("\$$collectedAmount", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular),
                          TextView.bold12Text(" of \$$totalAmount", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                        ],
                      ),
                      TextView.bold12Text("$endDate", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium),
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

  Widget descriptionOverview({
    required String heading,
    required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView.regular16Text(heading, color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
        SizedBox(height: getHeight() * 0.01),
        TextView.regular11Text(description, color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, lines: 3)
      ],
    );
  }

  Widget featuredContainer({
    required String? image,
    required String? name,
    required String? logoImage,
    required String? givingBack,
    required Function onPressFullContainer
  }) {
    bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onPressFullContainer.call(),
      child: Container(
        width: getWidth() * 0.43,
        margin: EdgeInsets.symmetric(horizontal: getWidth()*0.01, vertical: getHeight()*0.007),
        decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(getHeight() * 0.01),
            image: DecorationImage(
                image: isImageUrl ? NetworkImage(image): const AssetImage(Assets.dummyFeatured) as ImageProvider,
                fit: BoxFit.cover)
        ),
        child: Padding(
          padding: EdgeInsets.only(top: getHeight() * 0.08,),
          child: Container(
            height: getHeight()*0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(getHeight() * 0.01), bottomRight: Radius.circular(getHeight() * 0.01)),
              color: AppColors.blackColor.withOpacity(0.7),
            ),
            padding: EdgeInsets.only(left: getWidth() * 0.02, right: getWidth() * 0.02, top: getHeight() * 0.01),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: getHeight()*0.04,
                  width: getWidth() * 0.08,
                  decoration: BoxDecoration(
                      color: AppColors.blackColor,
                      borderRadius: BorderRadius.circular(getHeight() * 0.01),
                      image: DecorationImage(
                          image: AssetImage(logoImage!),
                          fit: BoxFit.cover)
                  ),
                ),
                SizedBox(width: getWidth() * 0.02),
                Column(
                  children: [
                    SizedBox(
                        width: getWidth() * 0.29,
                        child: TextView.regular11Text(name??"", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium, lines: 1)),
                    SizedBox(
                        width: getWidth() * 0.29,
                        child: TextView.regular11Text('Giving Back: $givingBack', color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium, lines: 1)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget typesText({required String title, required bool isSelected}) {
    return SizedBox(
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
            TextView.bold12Text(
                title,
                color: isSelected ? AppColors.blackColor: AppColors.darkGrey,
                fontFamily: Assets.poppinsMedium
            ),
          ),

        ],
      ),
    );
  }

  Widget overViewCategoryContainer({
    String? image,
    String? headerText,
    String? categoryPercent,
    required String? streetAddress,
    required String? address,
    required String? phoneNumber,
    required Function onViewCourse
  }){
    bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;
    return Column(
      children: [
        GestureDetector(
          onTap: ()=> onViewCourse.call(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: getHeight()*0.085,
                width: getWidth()*0.18,
                decoration: BoxDecoration(
                  //color: AppColors.lightGrey,
                    image: DecorationImage(
                        image: isImageUrl ? NetworkImage(image): AssetImage(image) as ImageProvider,
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(getHeight() * 0.01)
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: getWidth()*0.02),
                width: getWidth()*0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: getWidth()*0.52,
                            child: TextView.bold15Text(headerText??"", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium)),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: getHeight() * 0.01, horizontal: getWidth() * 0.03),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(getHeight() * 0.006),
                            color: AppColors.greenColor
                          ),
                          child: TextView.bold14Text(categoryPercent ?? "", color: AppColors.pureWhiteColor, fontFamily: Assets.latoBold),
                        ),
                      ],
                    ),
                    TextView.semiBold10Text(
                        streetAddress?? "",
                        color: AppColors.lightBlack,
                        lines: 1,
                        fontFamily: Assets.poppinsRegular,
                        textDecoration: TextDecoration.underline
                    ),
                    TextView.semiBold10Text(
                        address?? "",
                        color: AppColors.lightBlack,
                        lines: 1,
                        fontFamily: Assets.poppinsRegular,
                        textDecoration: TextDecoration.underline
                    ),
                    SizedBox(height: getHeight() * 0.004),
                    TextView.semiBold10Text(
                      phoneNumber?? "",
                      color: AppColors.lightBlack,
                      lines: 1,
                      fontFamily: Assets.latoRegular,
                    ),
                    SizedBox(height: getHeight() * 0.005),
                    SizedBox(
                        width: getWidth() * 0.45,
                        child:
                        TextView.semiBold10Text(
                            "some restrictions apply",
                            color: AppColors.orangeColor,
                            lines: 1,
                            fontFamily: Assets.poppinsRegular,
                            textDecoration: TextDecoration.underline
                        )
                    ),
                    SizedBox(height: getHeight() * 0.01),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(height: getHeight() * 0.02, thickness: getHeight() * 0.001 ,color: AppColors.borderColor),
        SizedBox(height: getHeight() * 0.008),
      ],
    );
  }

  Widget updateListTabContainer({
    required String header,
    required String detail,
    required String date
  }) {
    return Padding(
      padding: EdgeInsets.only(top: getHeight() * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //SizedBox(height: getHeight() * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView.getText13(header, color: AppColors.greenColor, fontFamily: Assets.poppinsMedium, lines: 1),
              TextView.regular11Text(date, color: AppColors.blackColor, fontFamily: Assets.poppinsMedium)
            ],
          ),
          TextView.bold12Text(detail, color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, lines: 2),
          SizedBox(height: getHeight() * 0.01),
          Divider(height: getHeight() * 0.02, thickness: getHeight() * 0.002 ,color: AppColors.borderColor),
        ],
      ),
    );
  }
}