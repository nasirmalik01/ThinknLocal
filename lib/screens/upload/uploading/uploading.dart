import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/about_visit/about_visit.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';


class Uploading extends StatefulWidget {
  const Uploading({Key? key}) : super(key: key);

  @override
  _UploadingState createState() => _UploadingState();
}

class _UploadingState extends State<Uploading> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.appBackground,
        body: GestureDetector(
          onTap: () {

          },
          child: Container(
            height: sizes!.height,
            width: sizes!.width,
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
                        AppColors.gradientColor1,
                        AppColors.pureWhiteColor,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes!.width * 0.06),
                  child: Column(
                    children: [
                      SizedBox(height: getHeight() * 0.1),
                      Image.asset(Assets.uploadIcon,),
                      SizedBox(height: getHeight() * 0.01),
                      TextView.bold35Text("Uploading...", color: AppColors.greenColor),
                      SizedBox(height: getHeight() * 0.05),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: sizes!.width * 0.02),
                        height: getHeight() * 0.015,
                        width: getWidth(),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: AppColors.darkGrey,
                            border: Border.all(color: AppColors.borderColor),
                          borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.01)),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}