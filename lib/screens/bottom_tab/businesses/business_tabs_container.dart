import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:sizer/sizer.dart';

class BusinessTabContainer extends StatelessWidget {
  final String? fullBoxImage;
  final String? logoImage;
  final String? name;
  final String? bookName;
  final String? streetAddress;
  final String? address;
  final String? phoneNumber;
  final Function onClickBox;
  final bool isFavorite;
  final Function onPressFavoriteIcon;
  final int index;


  const BusinessTabContainer(
      {Key? key, this.fullBoxImage,
      this.logoImage,
      this.name,
      this.bookName,
      this.streetAddress,
      this.address,
      this.phoneNumber,
      required this.onClickBox,
      required this.isFavorite,
      required this.onPressFavoriteIcon,
      required this.index
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isImageUrl = Uri.tryParse(fullBoxImage!)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: ()=> onClickBox.call(),
      child: Container(
        width: getWidth() * 0.7,
        margin: EdgeInsets.only(left: index == 0 ? getWidth()*0.06 : getWidth()*0.03),
        decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.02)),
            image: DecorationImage(
                image: isImageUrl ? NetworkImage(fullBoxImage!) : AssetImage(fullBoxImage!) as ImageProvider,
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
          child: Padding(
            padding: EdgeInsets.only(left: getWidth()*0.03, bottom: 0.4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: SizedBox()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: getWidth()*0.15,
                      width: getWidth()*0.15,
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
                          TextView.titleWithBlurRadius(
                              name ?? "",
                              Assets.poppinsSemiBold,
                              color: AppColors.pureWhiteColor,
                              lines: 1,
                              fontWeight: FontWeight.w700,
                              blurRadius: 0
                          ),
                        ),
                        SizedBox(height: getHeight() * 0.001),
                        SizedBox(
                            width: getWidth() * 0.45,
                            child:
                            TextView.subHeader(
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
                            TextView.subHeader(
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
                            TextView.subHeader(
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
                SizedBox(height: getHeight() * 0.01),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
