import 'package:flutter/material.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/text_views.dart';

class BusinessesComponents {
  Widget getBusinessesCategoriesIcon({
    required String image,
    required String label,
    required Function onPressCategory
  }) {
    return GestureDetector(
      onTap: () => onPressCategory(),
      child: Column(
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
      ),
    );
  }

  Widget typesFeaturedText({required String title, required bool isSelected}) {
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
                  width: sizes.width * 0.005,
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
    required Function onPressFavoriteIcon,
  }){
    //bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onClickBox.call(),
      child: Container(
        width: getWidth() * 0.75,
        margin: EdgeInsets.only(left: getWidth()*0.06, right: getWidth()*0.005),
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
                    child: GestureDetector(
                      onTap: () => onPressFavoriteIcon(),
                      child: isFavorite? Icon(Icons.favorite, color: AppColors.greenColor, size: getHeight()*0.04,):
                      Icon(Icons.favorite_border, color: AppColors.pureWhiteColor, size: getHeight()*0.04,),
                    )
                )
              ),
              Container(
                padding: EdgeInsets.only(left: getWidth()*0.03,
                    top: getHeight()*0.04
                ),
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
                                Assets.poppinsSemiBold,
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
                                fontFamily: Assets.poppinsRegular,
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
            borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.015)),
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
            padding: EdgeInsets.only(top: getHeight() * 0.018, left: getWidth() * 0.03, right: getWidth() * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: getHeight()*0.07,
                  width: getWidth() * 0.14,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(getHeight() * 0.01),
                      image: DecorationImage(
                          image: isImageUrlLogo ? NetworkImage(logoImage): const AssetImage(Assets.dummyRestaurantShortLogo) as ImageProvider,
                          fit: BoxFit.fill)
                  ),
                ),
                SizedBox(height: getHeight() * 0.015),
                TextView.bold12Text(name??"", color: AppColors.pureWhiteColor, lines: 1, fontFamily: Assets.poppinsSemiBold),
              ],
            ),
          ),
        ),
      ),
    );
  }
}