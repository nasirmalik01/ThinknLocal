import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/bottom_tab_new.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';


class UploadFailed extends StatelessWidget {
  final Function()? onTryAgainClick;
  const UploadFailed({this.onTryAgainClick, Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
        height: sizes.height,
        width: sizes.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: getHeight() * 0.1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.lightGreenColor,
                        AppColors.pureWhiteColor,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: getWidth()*0.05,
                  top: getHeight()*0.045,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const SizedBox(
                      child: Icon(Icons.close),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
              child: Column(
                children: [
                  SizedBox(height: getHeight() * 0.1),
                  Stack(
                    children: [
                      Image.asset(Assets.uploadIconOrange,),
                      const Positioned(
                        bottom: 0,
                        child: Image(
                          image: AssetImage(Assets.blurEffect),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getHeight() * 0.01),
                  TextView.header("Upload Failed", color: AppColors.orangeColor, fontSize: sizes.fontSize35),
                  SizedBox(height: getHeight() * 0.04),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: sizes.width * 0.03),
                    height: getHeight() * 0.013,
                    width: getWidth(),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.01)),
                    ),

                  ),
                  SizedBox(height: getHeight() * 0.04),
                  SizedBox(
                      width: getWidth() * 0.8,
                      child: TextView.subTitle(
                          "Something went wrong, please try again",
                          color: AppColors.darkGrey,
                          lines: 2,
                          textAlign: TextAlign.center
                      )),
                  SizedBox(height: getHeight() * 0.08),
                  Button(
                    onPress: onTryAgainClick,
                    text: "Try Again",
                    btnColor: AppColors.greenColor,
                    textColor: AppColors.pureWhiteColor
                  )
                ],
              ),
            ),
          ],
        ),
    );
  }
}