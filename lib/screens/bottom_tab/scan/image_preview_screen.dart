import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:get/get.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen(
      {Key? key,
      required this.notSaveImage,
      required this.saveImage,
      required this.image})
      : super(key: key);
  final XFile image;
  final Function saveImage;
  final Function notSaveImage;

  @override
  _ImagePreviewScreenState createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.9),
        body: Stack(
          children: [
            Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  image: DecorationImage(
                      image: FileImage(File(widget.image.path)),
                      fit: BoxFit.contain),
                )),
            Container(
              width: getWidth(),
              height: getHeight(),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  top: BorderSide(
                      color: Colors.black.withOpacity(0.3),
                      width: getWidth() * 0.15),
                  bottom: BorderSide(
                      color: Colors.black.withOpacity(0.3),
                      width: getWidth() * 0.42),
                  right: BorderSide(
                      color: Colors.black.withOpacity(0.3),
                      width: getWidth() * 0.06),
                  left: BorderSide(
                      color: Colors.black.withOpacity(0.3),
                      width: getWidth() * 0.06),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              left: 0,
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.symmetric(vertical: getHeight() * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Button(
                        onPress: () {
                          widget.notSaveImage.call();
                        },
                        width: sizes.width * 0.4,
                        height: getHeight() * 0.08,
                        text: Strings.tryAgain,
                        btnColor: AppColors.darkGrey),
                    SizedBox(
                      width: getWidth() * .05,
                    ),
                    Button(
                        onPress: () async {
                          // Map<String, dynamic> _query = {
                          //   Strings.fileName: widget.image.name,
                          //   Strings.contentType: 'image/${widget.image.name.split('.')[1]}',
                          //   Strings.byteSize: 1234,
                          //   Strings.checksum: 1234,
                          // };
                          // await _contributionController.uploadDirectContributions(_query);

                          Get.toNamed(
                            Routes.aboutVisit,
                            arguments: widget.image,
                          );
                        },
                        width: sizes.width * 0.4,
                        height: getHeight() * 0.08,
                        text: Strings.looksGood,
                        btnColor: AppColors.greenColor),
                  ],
                ),
              ),
            ),
            cameraLabel(),
            Positioned(
              top: getHeight() * 0.087,
              right: getWidth() * 0.07,
              child: GestureDetector(
                onTap: () {
                  widget.notSaveImage.call();
                },
                child: SizedBox(
                  height: getHeight() * 0.05,
                  width: getHeight() * 0.05,
                  child: const Image(
                    image: AssetImage(Assets.cancelIcon),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cameraLabel() {
    return Positioned(
      bottom: getHeight() * 0.13,
      child: SizedBox(
        width: getWidth(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: getWidth() * 0.6,
                  child: RichText(
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: Strings.makeSure,
                        style: TextStyle(
                          color: AppColors.pureWhiteColor,
                          fontSize: sizes.fontSize16,
                          fontFamily: Assets.poppinsRegular,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "${Strings.lowerCaseBusinessName} ",
                            style: TextStyle(
                              color: AppColors.greenColor,
                              fontSize: sizes.fontSize16,
                              fontFamily: Assets.poppinsMedium,
                            ),
                          ),
                          TextSpan(
                            text: "${Strings.and} ",
                            style: TextStyle(
                              color: AppColors.pureWhiteColor,
                              fontSize: sizes.fontSize16,
                              fontFamily: Assets.poppinsRegular,
                            ),
                          ),
                          TextSpan(
                            text: "${Strings.total} ",
                            style: TextStyle(
                              color: AppColors.greenColor,
                              fontSize: sizes.fontSize16,
                              fontFamily: Assets.poppinsMedium,
                            ),
                          ),
                          TextSpan(
                            text: Strings.areClearlyVisible,
                            style: TextStyle(
                              color: AppColors.pureWhiteColor,
                              fontSize: sizes.fontSize16,
                              fontFamily: Assets.poppinsRegular,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
