import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';

class BusinessDetailTopContainer extends StatelessWidget {
  final String? fullBoxImage;
  final String? logoImage;
  final String? name;
  final String? streetAddress;
  final String? address;
  final String? phoneNumber;
  final String? contributedAmount;
  final String? totalAmount;
  final String? joinDate;
  final Function onClickBox;
  final double completePercentage;
  final bool isFavorite;
  final Function onPressBackArrow;
  final Function onPressFavoriteIcon;
  final Function()? onShareClick;
  final Function()? onPhoneClick;
  final Function()? onAddressClick;


  const BusinessDetailTopContainer(
      {Key? key, this.fullBoxImage,
      this.logoImage,
      this.name,
      this.streetAddress,
      this.address,
      this.phoneNumber,
      this.contributedAmount,
      this.totalAmount,
      this.joinDate,
      required this.onClickBox,
      required this.completePercentage,
      required this.isFavorite,
      required this.onPressBackArrow,
      required this.onPressFavoriteIcon,
      required this.onShareClick,
      this.onPhoneClick,
      this.onAddressClick
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isImageUrl = Uri.tryParse(fullBoxImage!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onClickBox.call(),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.greenColor,
            image: DecorationImage(
                image: isImageUrl ? NetworkImage(fullBoxImage!): const AssetImage(Assets.dummyRestaurant) as ImageProvider,
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
                          GestureDetector(
                            onTap: onShareClick,
                            child: Icon(
                              Icons.ios_share,
                              color: AppColors.pureWhiteColor,
                              size: getHeight() * 0.03,
                            ),
                          ),
                          SizedBox(width: sizes.width * 0.03),
                          GestureDetector(
                            onTap: () => onPressFavoriteIcon(),
                            child: isFavorite? Icon(Icons.favorite, color: AppColors.greenColor, size: getHeight()*0.03,):
                            Icon(Icons.favorite_border, color: AppColors.pureWhiteColor, size: getHeight()*0.03,),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                Container(
                  padding: EdgeInsets.only(left: getWidth()*0.03, right: getWidth()*0.03),
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
                                      image: NetworkImage(logoImage!),
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
                                    TextView.titleWithBlurRadius(name ?? "", Assets.poppinsMedium, color: AppColors.pureWhiteColor,  lines: 1, blurRadius: 0)
                                ),
                                SizedBox(height: getHeight() * 0.001),
                                GestureDetector(
                                  onTap: onAddressClick,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
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
                                    ],
                                  ),
                                ),
                                SizedBox(height: getHeight() * 0.005),
                                GestureDetector(
                                  onTap: onPhoneClick,
                                  child: SizedBox(
                                      width: getWidth() * 0.65,
                                      child:
                                      TextView.headerWithBlurRadius(
                                        phoneNumber?? "",
                                        color: AppColors.pureWhiteColor,
                                        lines: 1,
                                        fontFamily: Assets.poppinsRegular,
                                      )
                                  ),
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
                  padding: EdgeInsets.only(left: getWidth()*0.03, right: getWidth()*0.03, bottom: getHeight() * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextView.headerWithBlurRadius("${Strings.contributed}: ", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                          TextView.headerWithBlurRadius("\$$contributedAmount", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular),
                        ],
                      ),
                      TextView.headerWithBlurRadius("${Strings.joined} $joinDate", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium),
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
