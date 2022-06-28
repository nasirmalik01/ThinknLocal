import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';

// ignore: must_be_immutable
class BusinessDetailTopContainer extends StatelessWidget {
  final String? fullBoxImage;
  final String? logoImage;
  final String? name;
  final String? streetAddress;
  final String? address;
  final String? phoneNumber;
  String? contributedAmount;
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


  BusinessDetailTopContainer(
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
    contributedAmount = contributedAmount!.replaceAll('%', '');
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                  padding: EdgeInsets.only(left: getWidth()*0.03, top: getHeight() * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => onPressBackArrow(),
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getWidth()*0.03),
                        child: Row(
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
                            GestureDetector(
                              onTap: () => onPressFavoriteIcon(),
                              child: Container(
                                  color: Colors.transparent,
                                  alignment: Alignment.topLeft,
                                  width: getWidth()*0.1,
                                  height: getHeight(),
                                  child: isFavorite? Icon(Icons.favorite, color: AppColors.greenColor, size: getHeight()*0.03,):
                                  Icon(Icons.favorite_border, color: AppColors.pureWhiteColor, size: getHeight()*0.03,),
                              )
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth()*0.03),
                child: Container(
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
                                  color: AppColors.pureWhiteColor,
                                  borderRadius: BorderRadius.circular(getHeight() * 0.02),
                                  image: DecorationImage(
                                      image: NetworkImage(logoImage!),
                                      fit: BoxFit.contain)
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
                                          (streetAddress == '' || streetAddress == null)
                                          ? const SizedBox()
                                          : TextView.headerWithBlurRadius(
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
                                              lines: 2,
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
              ),
              //SizedBox(height: getHeight() * 0.01),
              Padding(
                padding: EdgeInsets.only(left: getWidth()*0.06, right: getWidth()*0.06, bottom: getHeight() * 0.025),
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
    );
  }
}
