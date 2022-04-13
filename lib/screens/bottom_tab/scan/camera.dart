import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/about_visit/about_visit.dart';
import 'package:flutter_app/widgets/text_views.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
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

  @override
  void initState() {
    super.initState();
    setCameraResolution();
    _controller.initialize().then((value) => {
      if (mounted) {setState(() {})}
    });
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
    return WillPopScope(
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
    );
  }
  Widget _cameraView() {
    return Stack(
      children: [
        SizedBox(
            width: getWidth(),
            height: getHeight(),
            child:
            CameraPreview(_controller)),
        Container(
          width: getWidth(),
          height: getHeight(),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                top: BorderSide(
                  color: Colors.black.withOpacity(0.3),
                  width: getWidth() * 0.15
                ),
                bottom: BorderSide(
                    color: Colors.black.withOpacity(0.3),
                    width: getWidth() * 0.4
                ),
                right: BorderSide(
                    color: Colors.black.withOpacity(0.3),
                    width: getWidth() * 0.06
                ),
                left: BorderSide(
                    color: Colors.black.withOpacity(0.3),
                    width: getWidth() * 0.06
                ),
              ),
          ),
        ),

        cameraScreenWidgets(),
        cameraLabelText()
      ],
    );
  }

  Widget cameraLabelText() {
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
                          text: "Make sure ",
                          style: TextStyle(
                            color: AppColors.pureWhiteColor,
                            fontSize: sizes.fontSize16,
                            fontFamily: Assets.poppinsRegular,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "business name, ",
                              style: TextStyle(
                                color: AppColors.greenColor,
                                fontSize: sizes.fontSize16,
                                fontFamily: Assets.poppinsMedium,
                              ),
                            ),
                            TextSpan(
                              text: "and ",
                              style: TextStyle(
                                color: AppColors.pureWhiteColor,
                                fontSize: sizes.fontSize16,
                                fontFamily: Assets.poppinsRegular,
                              ),
                            ),
                            TextSpan(
                              text: "total ",
                              style: TextStyle(
                                color: AppColors.greenColor,
                                fontSize: sizes.fontSize16,
                                fontFamily: Assets.poppinsMedium,
                              ),
                            ),
                            TextSpan(
                              text: "are clearly visible",
                              style: TextStyle(
                                color: AppColors.pureWhiteColor,
                                fontSize: sizes.fontSize16,
                                fontFamily: Assets.poppinsRegular,
                              ),
                            ),


                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }

  Widget cameraScreenWidgets() {
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
                  child: TextView.title("Cancel", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium))
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