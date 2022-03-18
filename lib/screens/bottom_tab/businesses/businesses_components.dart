import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/text_views.dart';

class BusinessesComponents {
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

  Widget typesText({required String title, required bool isSelected}) {
    return SizedBox(
      height: sizes!.height * 0.04,
      //padding: EdgeInsets.symmetric(horizontal: sizes!.width * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: sizes!.height * 0.002,
            ),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                  color: isSelected ? AppColors.greenColor: AppColors.pureWhiteColor,
                  width: sizes!.width * 0.005, // This would be the width of the underline
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
    );
  }
  Widget getBusinessesContainer({
    required String? fullBoxImage,
    required String? logoImage,
    required String? name,
    required String? bookName,
    required String? streetAddress,
    required String? address,
    required String? phoneNumber,
    required Function onClickBox,
    required bool isFavorite,
  }){
    //bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onClickBox.call(),
      child: Container(
        width: getWidth() * 0.7,
        margin: EdgeInsets.symmetric(horizontal: getWidth()*0.01),
        decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.02)),
            image: DecorationImage(
                image: AssetImage(fullBoxImage!),
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
              Padding(
                padding: EdgeInsets.only(top: getHeight()*0.01, right: getHeight()*0.02),
                child: Align(
                  alignment: Alignment.topRight,
                    child: isFavorite? Icon(Icons.favorite, color: AppColors.greenColor, size: getHeight()*0.04,):
                    Icon(Icons.favorite_border, color: AppColors.pureWhiteColor, size: getHeight()*0.04,)
                )
              ),
              Container(
                padding: EdgeInsets.only(left: getWidth()*0.03,
                    top: getHeight()*0.04
                ),
                //width: getWidth()*0.65,
                child: Row(
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
                      children: [
                        SizedBox(
                            width: getWidth() * 0.45,
                            child:
                            TextView.getMediumText16(
                                name ?? "",
                                Assets.latoBold,
                                color: AppColors.pureWhiteColor,
                                lines: 1,
                                fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: getHeight() * 0.001),
                        SizedBox(
                            width: getWidth() * 0.45,
                            child:
                            TextView.semiBold10Text(
                              streetAddress?? "",
                              color: AppColors.pureWhiteColor,
                              lines: 1,
                              fontFamily: Assets.poppinsRegular,
                              textDecoration: TextDecoration.underline
                            )
                        ),
                        SizedBox(
                            width: getWidth() * 0.45,
                            child:
                            TextView.semiBold10Text(
                                address?? "",
                                color: AppColors.pureWhiteColor,
                                lines: 1,
                                fontFamily: Assets.poppinsRegular,
                                textDecoration: TextDecoration.underline
                            )
                        ),
                        SizedBox(height: getHeight() * 0.001),
                        SizedBox(
                            width: getWidth() * 0.45,
                            child:
                            TextView.semiBold10Text(
                                phoneNumber?? "",
                                color: AppColors.pureWhiteColor,
                                lines: 1,
                                fontFamily: Assets.latoRegular,
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: getHeight() * 0.01),

            ],
          ),
        ),
      ),
    );
  }

  Widget getRecentlyAddedContainer({
    String? fullImage,
    String? name,
    String? logoImage,
    required Function onPressFullContainer
  }){
    bool isImageUrl = Uri.tryParse(fullImage!)?.hasAbsolutePath ?? false;
    bool isImageUrlLogo = Uri.tryParse(logoImage!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onPressFullContainer.call(),
      child: Container(
        //height: getHeight()*0.2,
        width: getWidth() * 0.35,
        margin: EdgeInsets.symmetric(horizontal: getWidth()*0.01, vertical: getHeight()*0.007),
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
            padding: EdgeInsets.only(top: getHeight() * 0.015, left: getWidth() * 0.03, right: getWidth() * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: getHeight()*0.07,
                  width: getWidth() * 0.14,
                  decoration: BoxDecoration(
                      //color: AppColors.blackColor,
                      borderRadius: BorderRadius.circular(getHeight() * 0.01),
                      image: DecorationImage(
                          image: isImageUrlLogo ? NetworkImage(logoImage): const AssetImage(Assets.dummyRestaurantShortLogo) as ImageProvider,
                          fit: BoxFit.fill)
                  ),
                ),
                SizedBox(height: getHeight() * 0.015),
                TextView.bold12Text(name??"", color: AppColors.pureWhiteColor, lines: 1, fontFamily: Assets.latoBold),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get2TextRow({required String text1, required String text2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextView.getMediumText15(text1, color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
        TextView.bold12Text(text2, color: AppColors.greenColor, fontFamily: Assets.poppinsMedium, textDecoration: TextDecoration.underline),
      ],
    );
  }

  Widget nearByContainer({
    String? image,
    String? headerText,
    //String? categoryPercent,
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
                width: getWidth()*0.68,
                // color: AppColors.redDarkColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView.bold15Text(headerText??"", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                    SizedBox(height: getHeight() * 0.004),
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
                    SizedBox(height: getHeight() * 0.01),
                    TextView.semiBold10Text(
                      phoneNumber?? "",
                      color: AppColors.lightBlack,
                      lines: 1,
                      fontFamily: Assets.latoRegular,
                    ),
                    SizedBox(height: getHeight() * 0.005),

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
}