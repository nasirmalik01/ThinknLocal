import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/scan/contribution_controller.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:get/get.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';


class Uploading extends GetWidget<ContributionController> {
  const Uploading({Key? key}) : super(key: key);

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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
            child: Column(
              children: [
                SizedBox(height: getHeight() * 0.1),
                Stack(
                  children: [
                    Image.asset(Assets.uploadIcon,),
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
                TextView.header("Uploading...", color: AppColors.greenColor, fontSize: sizes.fontSize35),
                SizedBox(height: getHeight() * 0.04),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: sizes.width * 0.03),
                    alignment: Alignment.topCenter,
                    child: Obx(() => LinearProgressIndicator(
                      minHeight: getHeight()*0.01,
                      value: controller.fileUploadingProgress.value/100,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.greenColor),
                      backgroundColor: Colors.grey,
                    ))
                ),
                SizedBox(height: getHeight() * 0.04),
                SizedBox(
                  width: getWidth() * 0.7,
                    child: TextView.subTitle("Please wait while we upload your receipt",
                        color: AppColors.darkGrey,
                        lines: 2,
                        textAlign: TextAlign.center
                    )),
              ],
            ),
          ),

        ],
      ),
    );
  }
}