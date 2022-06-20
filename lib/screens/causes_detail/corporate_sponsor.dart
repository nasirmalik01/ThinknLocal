import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';

class CorporateSponsor extends StatelessWidget {
  final String backgroundImage;
  final String icon;
  final String title;
  final String summary;
  const CorporateSponsor({Key? key, required this.backgroundImage, required this.icon, required this.title, required this.summary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView.titleWithDecoration(Strings.corporateSponsors, color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize17),
          SizedBox(height: getHeight() * 0.01),
          Container(
            height: getHeight()*0.14,
            width: getWidth(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getHeight()*0.02),
              color: AppColors.pureWhiteColor,
              image: DecorationImage(
                  image: NetworkImage(
                    backgroundImage
                  ),
                fit: BoxFit.cover
              )
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
              child: Padding(
                padding: EdgeInsets.only(left: getWidth()*0.05, bottom: getHeight()*0.01),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                   Container(
                     height: getHeight()*0.09,
                     width: getHeight()*0.09,
                     decoration: BoxDecoration(
                         color: AppColors.pureWhiteColor,
                         borderRadius: BorderRadius.circular(getHeight()*0.02),
                       border: Border.all(
                         width: 2,
                         color: AppColors.pureWhiteColor
                       ),
                         image: DecorationImage(
                             image: NetworkImage(icon),
                             fit: BoxFit.contain
                         )
                     ),
                   ),
                    SizedBox(width: getWidth()*0.04,),
                    Padding(
                      padding: EdgeInsets.only(bottom: getHeight()*0.005),
                      child: SizedBox(
                        width: getWidth()*0.55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextView.titleWithBlurRadius(title, Assets.poppinsMedium, color: AppColors.pureWhiteColor, fontSize: sizes.fontSize18, lines: 1),
                            TextView.caption(summary, color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular, lines: 1, fontSize: sizes.fontSize12, isEllipsis: true)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: sizes.height * 0.04),
        ],
      ),
    );
  }
}
