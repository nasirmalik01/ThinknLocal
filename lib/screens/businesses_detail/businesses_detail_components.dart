import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/text_views.dart';

class BusinessesDetailComponents {
  Widget ratingContainer({required double? starRating, ignoreEdit, Function? onPress}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView.headerWithBlurRadius("40 customer ratings", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
        Container(
          width: getWidth(),
          padding: EdgeInsets.symmetric(horizontal: getHeight() * 0.002, vertical: getWidth() * 0.02),
          decoration: BoxDecoration(
            color: AppColors.boxGrey,
            borderRadius: BorderRadius.circular(getHeight() * 0.01),
          ),
          child: Row(
            children: [
              SizedBox(width: getWidth() * 0.04),
              CommonWidgets.getRating(
                starRating: starRating,
                ignoreEdit: ignoreEdit,
                onPress: onPress,
              ),
              SizedBox(width: getWidth() * 0.05),
              TextView.caption("4.5 out of 5", color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, lines: 1),
            ],
          )
        ),
      ],
    );
  }



  Widget recentlyFundedContainer({
    required String? fullImage,
    required String? name,
    required String? logoImage,
    required String? endDate,
    required String raisedAmount,
    required String totalAmount,
    required bool isFavorite,
    required Function onPressFullContainer
  }){
    bool isImageUrl = Uri.tryParse(fullImage!)?.hasAbsolutePath ?? false;
    bool isImageUrlLogo = Uri.tryParse(logoImage!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onPressFullContainer.call(),
      child: Container(
        width: getWidth() * 0.39,
        margin: EdgeInsets.only(left: getWidth()*0.06, right: getWidth()*0.005),
        decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(getHeight() * 0.015),
            image: DecorationImage(
                image: isImageUrl ? NetworkImage(fullImage): const AssetImage(Assets.dummyRestaurantShort) as ImageProvider,
                fit: BoxFit.cover)
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.01)),
            gradient: const LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppColors.greenColor,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: getHeight() * 0.01, left: getWidth() * 0.025, right: getWidth() * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: getHeight()*0.05,
                      width: getWidth() * 0.11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(getHeight() * 0.01),
                          image: DecorationImage(
                              image: isImageUrlLogo ? NetworkImage(logoImage): const AssetImage(Assets.dummyRestaurantShortLogo) as ImageProvider,
                              fit: BoxFit.fill)
                      ),
                    ),
                    isFavorite? Icon(Icons.favorite, color: AppColors.greenColor, size: getHeight()*0.03,):
                    Icon(Icons.favorite_border, color: AppColors.pureWhiteColor, size: getHeight()*0.03,)
                  ],
                ),
                SizedBox(height: getHeight() * 0.01),
                TextView.subTitleWithBlurRadius(name??"", color: AppColors.pureWhiteColor, lines: 2, fontFamily: Assets.poppinsMedium, blurRadius: 5),
                SizedBox(height: getHeight() * 0.001),
                TextView.caption('\$$raisedAmount of \$$totalAmount', color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium, lines: 1),
                SizedBox(height: getHeight() * 0.001),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Ends ",
                          style: TextStyle(
                            color: AppColors.pureWhiteColor,
                            fontSize: sizes.fontSize11,
                            fontFamily: Assets.poppinsRegular,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: endDate,
                              style: TextStyle(
                                color: AppColors.pureWhiteColor,
                                fontSize: sizes.fontSize11,
                                fontFamily: Assets.poppinsMedium,
                              ),
                            ),
                          ]
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}