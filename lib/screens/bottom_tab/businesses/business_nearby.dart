import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';

class BusinessNearBy extends StatelessWidget {
  final String? image;
  final String? headerText;
  final String? streetAddress;
  final String? address;
  final String? phoneNumber;
  final Function onViewCourse;
  final bool isBusinessCategory;


  const BusinessNearBy(
      {Key? key, this.image,
      this.headerText,
      this.streetAddress,
      this.address,
      this.phoneNumber,
      required this.onViewCourse,
      this.isBusinessCategory = false
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
              height: getHeight()*0.075,
              width: getHeight()*0.075,
              decoration: BoxDecoration(
                color: AppColors.pureWhiteColor,
                  image: DecorationImage(
                      image: isImageUrl ? NetworkImage(image!): AssetImage(image!) as ImageProvider,
                      fit: BoxFit.contain),
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
                  TextView.headerWithBlurRadius(headerText??"", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: isBusinessCategory ? sizes.fontSize16 : sizes.fontSize15),
                  SizedBox(height: getHeight() * 0.004),
                  (streetAddress == '' || streetAddress == null)
                  ? const SizedBox()
                  : TextView.subHeader(
                      streetAddress,
                      color: AppColors.lightBlack,
                      lines: 1,
                      fontFamily: Assets.poppinsRegular,
                      textDecoration: TextDecoration.underline,
                      fontSize: isBusinessCategory ? sizes.fontSize11 : sizes.fontSize10
                  ),
                  (address == '' || address == null)
                  ? const SizedBox()
                  : TextView.subHeader(
                      address,
                      color: AppColors.lightBlack,
                      lines: 2,
                      fontFamily: Assets.poppinsRegular,
                      textDecoration: TextDecoration.underline,
                      fontSize: isBusinessCategory ? sizes.fontSize11 : sizes.fontSize10
                  ),
                  SizedBox(height: getHeight() * 0.01),
                  (phoneNumber == '' || phoneNumber == null)
                  ? const SizedBox()
                  : TextView.subHeader(
                    phoneNumber ?? "",
                    color: AppColors.grayColor,
                    lines: 1,
                    fontFamily: Assets.poppinsRegular,
                      fontSize: isBusinessCategory ? sizes.fontSize11 : sizes.fontSize10
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
