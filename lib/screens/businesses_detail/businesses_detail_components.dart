import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/text_views.dart';

class BusinessesDetailComponents {
  Widget getBusinessesDetailImageContainer({
    required String? fullBoxImage,
    required String? logoImage,
    required String? name,
    required String? streetAddress,
    required String? address,
    required String? phoneNumber,
    required String? contributedAmount,
    required String? totalAmount,
    required String? joinDate,
    required Function onClickBox,
    required double completePercentage,
    required bool isFavorite,
    required Function onPressBackArrow,
    required Function onPressFavoriteIcon,
  }){
    bool isImageUrl = Uri.tryParse(fullBoxImage!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onClickBox.call(),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.greenColor,
            image: DecorationImage(
                image: isImageUrl ? NetworkImage(fullBoxImage): const AssetImage(Assets.dummyRestaurant) as ImageProvider,
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
                          size: getHeight() * 0.04,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.save_alt,
                            color: AppColors.pureWhiteColor,
                            size: getHeight() * 0.04,
                          ),
                          SizedBox(width: sizes.width * 0.03),
                          GestureDetector(
                            onTap: () => onPressFavoriteIcon(),
                            child: isFavorite? Icon(Icons.favorite, color: AppColors.greenColor, size: getHeight()*0.04,):
                            Icon(Icons.favorite_border, color: AppColors.pureWhiteColor, size: getHeight()*0.04,),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: getWidth()*0.03, top: getHeight()*0.09, right: getWidth()*0.03),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: getHeight()*0.09,
                              width: getWidth() * 0.18,
                              decoration: BoxDecoration(
                                  color: AppColors.blackColor,
                                  borderRadius: BorderRadius.circular(getHeight() * 0.02),
                                  image: DecorationImage(
                                      image: AssetImage(logoImage!),
                                      fit: BoxFit.cover)
                              ),
                            ),
                            SizedBox(width: getWidth() * 0.02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: getWidth() * 0.65,
                                  child:
                                  TextView.titleWithBlurRadius(name ?? "", Assets.poppinsMedium, color: AppColors.pureWhiteColor,  lines: 1, blurRadius: 5)
                                ),
                                SizedBox(height: getHeight() * 0.001),
                                SizedBox(
                                    width: getWidth() * 0.65,
                                    child:
                                    TextView.headerWithBlurRadius(
                                        streetAddress?? "",
                                        color: AppColors.pureWhiteColor,
                                        lines: 1,
                                        fontFamily: Assets.poppinsRegular,
                                        textDecoration: TextDecoration.underline
                                    )
                                ),
                                SizedBox(
                                    width: getWidth() * 0.65,
                                    child:
                                    TextView.headerWithBlurRadius(
                                        address?? "",
                                        color: AppColors.pureWhiteColor,
                                        lines: 1,
                                        fontFamily: Assets.poppinsRegular,
                                        textDecoration: TextDecoration.underline
                                    )
                                ),
                                SizedBox(height: getHeight() * 0.001),
                                SizedBox(
                                    width: getWidth() * 0.65,
                                    child:
                                    TextView.headerWithBlurRadius(
                                      phoneNumber?? "",
                                      color: AppColors.pureWhiteColor,
                                      lines: 1,
                                      fontFamily: Assets.poppinsRegular,
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(height: getHeight() * 0.02, thickness: getHeight() * 0.001 ,color: AppColors.pureWhiteColor)

                      ],
                    ),
                  ),
                ),
                //SizedBox(height: getHeight() * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: getWidth()*0.03, right: getWidth()*0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextView.headerWithBlurRadius("Contributed: ", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                          TextView.headerWithBlurRadius("\$$contributedAmount", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular),
                        ],
                      ),
                      TextView.headerWithBlurRadius("Joined $joinDate", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium),
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