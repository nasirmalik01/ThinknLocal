import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/about_visit/about_visit.dart';
import 'package:flutter_app/widgets/text_views.dart';

import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';
import '../bottom_tab_new.dart';
import 'image_preview_screen.dart';


class CameraScreen extends StatefulWidget {
  const CameraScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);
  final CameraDescription camera;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  List<XFile> videos = [];
  bool isFirst = false;

  @override
  void initState() {
    super.initState();
    setCameraResolution();
    _controller.initialize().then((value) => {
      if (mounted) {setState(() {})}
    });
    isFirst = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setCameraResolution() {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.ultraHigh,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute (builder: (_) => BottomTabNew(pageIndex: 0)), (route) => false);
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body:
          _cameraView()
        ),
      ),
    );
  }
  Widget _cameraView() {
    return Stack(
      children: [
        SizedBox(
            width: getWidth(),
            height: getHeight(),
            child: CameraPreview(_controller)),
        cameraScreenControl()
      ],
    );
  }

  Widget cameraScreenControl() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
          color: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05, vertical: getHeight() * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                  Icons.photo_library,
                  size: getHeight() * 0.08,
                  color: AppColors.pureWhiteColor
              ),
              _cameraButton(onClick: () {
                _takePicture();
              }),
              GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute (builder: (_) => BottomTabNew(pageIndex: 0)), (route) => false);
                  },
                  child: TextView.getMediumText18("Cancel", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium))
            ],
          )),
    );
  }


  Widget _cameraButton({required Function onClick}) {
    return GestureDetector(
      onTap: () {
        onClick.call();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.pureWhiteColor, width: getWidth() * 0.01),
            shape: BoxShape.circle),
        child: Center(
          child: Icon(
            Icons.circle,
            color: AppColors.pureWhiteColor,
            size: getWidth() * 0.18,
          ),
        ),
      ),
    );
  }

  void _takePicture() async {
    XFile value = await _controller.takePicture();
    isFirst = true;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImagePreviewScreen(
              xFile: value,
              notSaveImage: () {
                Navigator.pop(context);
              },
              saveImage: ()async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AboutVisit()));
              },
            )));
  }

}

Future<bool> showExitPopup(context) async {
  return await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: SizedBox(
            height: getHeight() * 0.28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.warning_rounded,
                    color: AppColors.greenColor, size: getHeight() * 0.05),
                SizedBox(height: getHeight() * 0.02),
                TextView.getMediumText18(
                    "Do you want to exit?", fontFamily: Assets.poppinsSemiBold,
                    color: AppColors.blackColor),
                SizedBox(height: getHeight() * 0.01),
                TextView.bold15Text("Images will not be saved. Do you still want to exit?", textAlign: TextAlign.center,
                    color: AppColors.blackColor, fontFamily: Assets.poppinsRegular, lines: 2),
                SizedBox(height: getHeight() * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child:
                            TextView.bold15Text("Yes", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium),
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.greenColor),
                      ),
                    ),
                    SizedBox(width: getWidth() * 0.04),
                    Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child:
                          TextView.bold15Text("No", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.pureWhiteColor,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}