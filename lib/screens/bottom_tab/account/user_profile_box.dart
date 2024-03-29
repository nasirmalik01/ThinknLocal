import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/constants/routes.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/local/my_hive.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';
import 'package:get/get.dart';


class UserProfileBox extends StatelessWidget {
  final String? name;
  final String? email;
  final String? nameShort;
  final Function? onTapEdit;
  final Function()? onHelpClick;

  const UserProfileBox({Key? key, this.name, this.email, this.nameShort, this.onTapEdit, this.onHelpClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizes.height * 0.25,
      width: sizes.width,
      child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: onHelpClick,
                    child: TextView.headerWithBlurRadius(Strings.help, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, textDecoration: TextDecoration.underline)),
                GestureDetector(
                    onTap: (){
                      MyHive.setToken(Strings.dummyToken);
                      Get.offAllNamed(Routes.loginScreen, arguments: true);
                    },
                    child: TextView.headerWithBlurRadius(Strings.signOut, color: AppColors.orangeColor, fontFamily: Assets.poppinsMedium, textDecoration: TextDecoration.underline)),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: getHeight()*0.036),
              padding: EdgeInsets.symmetric(vertical: sizes.height * 0.03),
              height: sizes.height * 0.195,
              width: sizes.width * 0.88,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.pureWhiteColor,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: getHeight() * 0.01),
                  TextView.header(name, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize25),
                  SizedBox(height: getHeight() * 0.008),
                  TextView.headerWithBlurRadius(email, color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular),
                  SizedBox(height: getHeight() * 0.01),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onTapEdit!(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.edit, size: 15, color: AppColors.greenColor),
                          SizedBox(width: sizes.width * 0.015),
                          TextView.headerWithBlurRadius(Strings.editAccountInfo, color: AppColors.greenColor, textDecoration: TextDecoration.underline),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: sizes.height * 0.075,
                  width: sizes.width * 0.16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.greenColor,
                  ),
                  child: Center(child: TextView.header(nameShort, color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsSemiBold)),
                ),
              ],
            )
          ]
      ),
    );
  }
}
