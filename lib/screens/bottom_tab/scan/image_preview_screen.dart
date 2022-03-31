import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen(
      {Key? key,
        required this.notSaveImage,
        required this.saveImage,
        required this.xFile})
      : super(key: key);
  final XFile xFile;
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
                      image: FileImage(File(widget.xFile.path)),
                      fit: BoxFit.contain),
                )
            ),
            Positioned(
              right: 0,
              bottom: 0,
              left: 0,
              child: Container(
                width: 100,
                //height: getHeight(),
                color: Colors.black,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //_acceptButton(),
                    CommonWidgets.getButton(
                        onPress: () {
                          widget.notSaveImage.call();
                        },
                        width: sizes.width * 0.4, height: getHeight() * 0.08,
                        text: "Try Again", btnColor: AppColors.darkGrey),
                    SizedBox(
                      width: getWidth() * .05,
                    ),
                    CommonWidgets.getButton(
                        onPress: () {
                          widget.saveImage.call();
                        },
                        width: sizes.width * 0.4, height: getHeight() * 0.08,
                        text: "Looks Good!", btnColor: AppColors.greenColor),
                    //_cancelButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _acceptButton() {
    return GestureDetector(
      onTap: () {
        widget.saveImage.call();
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.lightGreenAccent, width: 2),
            shape: BoxShape.circle),
        child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.lightGreenAccent,
              size: 40,
            )),
      ),
    );
  }

  Widget _cancelButton() {
    return GestureDetector(
      onTap: () {
        widget.notSaveImage.call();
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrange, width: 2),
            shape: BoxShape.circle),
        child: const Center(
            child: Icon(
              Icons.refresh,
              color: Colors.deepOrange,
              size: 40,
            )),
      ),
    );
  }
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }
}
