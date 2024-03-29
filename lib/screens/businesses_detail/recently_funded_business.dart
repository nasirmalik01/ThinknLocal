import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';

class RecentlyFundedBusiness extends StatelessWidget {
  final String? fullImage;
  final String? name;
  final String? logoImage;
  final String? endDate;
  final String raisedAmount;
  final String dateStatus;
  final String totalAmount;
  final bool isFavorite;
  final Function onPressFullContainer;
  final Function() onFavPress;
  final List<Color> colors;
  final int index;
  final List recentlyFundedBusinessList;



  const RecentlyFundedBusiness(
      {Key? key, this.fullImage,
      this.name,
      this.logoImage,
      this.endDate,
      required this.raisedAmount,
      required this.totalAmount,
      required this.isFavorite,
      required this.onPressFullContainer,
      required this.onFavPress,
      required this.colors,
      required this.index,
      required this.recentlyFundedBusinessList,
      required this.dateStatus,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isImageUrl = Uri.tryParse(fullImage!)?.hasAbsolutePath ?? false;
    bool isImageUrlLogo = Uri.tryParse(logoImage!)?.hasAbsolutePath ?? false;
    return Container(
      width: getWidth() * 0.39,
      margin: EdgeInsets.only(left: index == 0 ? getWidth()*0.06 : getWidth()*0.04, right: index == recentlyFundedBusinessList.length - 1 ? getWidth() * 0.05 : 0),
      decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(getHeight() * 0.015),
          image: DecorationImage(
              image: isImageUrl ? NetworkImage(fullImage!) : AssetImage(fullImage!) as ImageProvider,
              fit: BoxFit.cover)
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.01)),
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: colors
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
                      color: AppColors.pureWhiteColor,
                        borderRadius: BorderRadius.circular(getHeight() * 0.01),
                        image: DecorationImage(
                            image: isImageUrlLogo ? NetworkImage(logoImage!): AssetImage(logoImage!) as ImageProvider,
                            fit: BoxFit.contain)
                    ),
                  ),
                  GestureDetector(
                      onTap: onFavPress,
                      child: (isFavorite? Icon(Icons.favorite, color: AppColors.greenColor, size: getHeight()*0.03,): Icon(Icons.favorite_border, color: AppColors.pureWhiteColor, size: getHeight()*0.03,)))
                ],
              ),
              SizedBox(height: getHeight() * 0.01),
              TextView.subTitleWithBlurRadius(name??"", color: AppColors.pureWhiteColor, lines: 2, fontFamily: Assets.poppinsMedium, blurRadius: 0),
              SizedBox(height: getHeight() * 0.001),
              TextView.caption('\$$raisedAmount ${Strings.of} \$$totalAmount', color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium, lines: 1),
              SizedBox(height: getHeight() * 0.001),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "$dateStatus ",
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
    );
  }
}
