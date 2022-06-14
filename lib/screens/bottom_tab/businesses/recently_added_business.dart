import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:sizer/sizer.dart';

class RecentlyAddedBusiness extends StatelessWidget {
  final String? fullImage;
  final String? name;
  final String? logoImage;
  final Function onPressFullContainer;
  final int index;

  const RecentlyAddedBusiness({Key? key, this.fullImage, this.name, this.logoImage, required this.onPressFullContainer, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isImageUrl = Uri.tryParse(fullImage!)?.hasAbsolutePath ?? false;
    bool isImageUrlLogo = Uri.tryParse(logoImage!)?.hasAbsolutePath ?? false;
    return Container(
      width: getWidth() * 0.39,
      margin: EdgeInsets.only(left: index == 0 ? getWidth()*0.06 : getWidth()*0.04),
      decoration: BoxDecoration(
          color: AppColors.pureWhiteColor,
          borderRadius: BorderRadius.circular(getHeight() * 0.015),
          image: DecorationImage(
              image: isImageUrl ? NetworkImage(fullImage!): AssetImage(fullImage!) as ImageProvider,
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
          padding: EdgeInsets.only(left: getWidth() * 0.03, right: getWidth() * 0.02, bottom: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: SizedBox()),
              Container(
                height: getWidth()*0.15,
                width: getWidth()*0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getHeight() * 0.01),
                    image: DecorationImage(
                        image: isImageUrlLogo ? NetworkImage(logoImage!) :  AssetImage(logoImage!) as ImageProvider,
                        fit: BoxFit.fill)
                ),
              ),
              SizedBox(height: getHeight() * 0.01),
              TextView.headerWithBlurRadius(name??"", color: AppColors.pureWhiteColor, lines: 1, fontFamily: Assets.poppinsSemiBold, blurRadius: 0),
            ],
          ),
        ),
      ),
    );
  }
}
