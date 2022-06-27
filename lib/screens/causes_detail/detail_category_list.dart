import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';
import 'package:sizer/sizer.dart';

class DetailCategoryList extends StatelessWidget {
  final String? image;
  final String? headerText;
  final String? categoryPercent;
  final String? streetAddress;
  final String? address;
  final String? phoneNumber;
  final Function onViewCourse;
  final Function()? onPhoneClick;
  final Function()? onAddressClick;
  final Function()? onShowRestrictionsTap;
  final bool isRestrictionsApply;

  const DetailCategoryList(
      {Key? key,
      required this.streetAddress,
      required this.address,
      required this.phoneNumber,
      required this.onViewCourse,
      required this.image,
      required this.headerText,
      required this.categoryPercent,
      this.onPhoneClick,
      this.onAddressClick,
      this.onShowRestrictionsTap,
      this.isRestrictionsApply = true
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 8.h,
              width: 8.h,
              decoration: BoxDecoration(
                color: AppColors.pureWhiteColor,
                  image: DecorationImage(
                      image: isImageUrl ? NetworkImage(image!): AssetImage(image!) as ImageProvider,
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.circular(getHeight() * 0.01)
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: getWidth()*0.03),
              width: getWidth()*0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: getWidth()*0.52,
                          child: TextView.headerWithBlurRadius(headerText??"", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize15)),
                      Container(
                        padding: EdgeInsets.only(top: 0.5.h, bottom: 0.5.h, left: getWidth() * 0.03, right: getWidth() * 0.03),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(getHeight() * 0.006),
                            color: AppColors.greenColor
                        ),
                        child: Center(child: TextView.header(categoryPercent ?? "", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsSemiBold, fontSize: sizes.fontSize14)),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: onAddressClick,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (streetAddress == '' || streetAddress == null)
                        ? const SizedBox()
                        : TextView.subHeader(
                            streetAddress ?? "",
                            color: AppColors.lightBlack,
                            lines: 1,
                            fontFamily: Assets.poppinsRegular,
                            textDecoration: TextDecoration.underline,
                            fontSize: sizes.fontSize12
                        ),
                        TextView.subHeader(
                            address?? "",
                            color: AppColors.lightBlack,
                            lines: 2,
                            fontFamily: Assets.poppinsRegular,
                            textDecoration: TextDecoration.underline,
                            fontSize: sizes.fontSize12
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.01),
                  GestureDetector(
                    onTap: onPhoneClick,
                    child: TextView.subHeader(
                      phoneNumber?? "",
                      color: AppColors.grayColor,
                      lines: 1,
                      fontFamily: Assets.poppinsRegular,
                      fontSize: sizes.fontSize11
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.008),
                  isRestrictionsApply
                   ? GestureDetector(
                    onTap: onShowRestrictionsTap,
                    child: SizedBox(
                        width: getWidth() * 0.45,
                        child: TextView.subHeader(
                            "* some restrictions apply",
                            color: AppColors.orangeColor,
                            lines: 1,
                            fontFamily: Assets.poppinsRegular,
                            textDecoration: TextDecoration.underline,
                            fontSize: sizes.fontSize12
                        )
                    ),
                  )
                  : const SizedBox(),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
