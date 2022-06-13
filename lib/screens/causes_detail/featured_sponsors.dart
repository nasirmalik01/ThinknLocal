import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:sizer/sizer.dart';

class FeaturedSponsors extends StatelessWidget {
  final String? image;
  final String? name;
  final String? logoImage;
  final String? givingBack;
  final Function onPressFullContainer;

  const FeaturedSponsors(
      {Key? key, this.image,
      this.name,
      this.logoImage,
      this.givingBack,
      required this.onPressFullContainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onPressFullContainer.call(),
      child: Container(
        width: getWidth() * 0.41,
        margin: EdgeInsets.only(right: getWidth()*0.04, top: getHeight()*0.007, bottom: getHeight()*0.007,),
        decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(getHeight() * 0.01),
            image: DecorationImage(
                image: isImageUrl ? NetworkImage(image!): AssetImage(image!) as ImageProvider,
                fit: BoxFit.cover)
        ),
        child: Padding(
          padding: EdgeInsets.only(top: getHeight() * 0.09,),
          child: Container(
            height: getHeight()*0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(getHeight() * 0.01), bottomRight: Radius.circular(getHeight() * 0.01)),
              color: AppColors.blackColor.withOpacity(0.7),
            ),
            padding: EdgeInsets.only(left: getWidth() * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: getHeight()*0.038,
                  width: getWidth() * 0.075,
                  decoration: BoxDecoration(
                      color: AppColors.blackColor,
                      borderRadius: BorderRadius.circular(0.8.h),
                      image: DecorationImage(
                          image: NetworkImage(logoImage!),
                          fit: BoxFit.fill)
                  ),
                ),
                SizedBox(width: getWidth() * 0.02),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: getWidth() * 0.29,
                        child: TextView.caption(name??"", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium, lines: 1)),
                    SizedBox(
                        width: getWidth() * 0.29,
                        child: TextView.caption(givingBack, color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium, lines: 1)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
