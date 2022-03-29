import 'package:flutter/material.dart';
import 'package:flutter_app/screens/upload/uploading_success/uploading_success.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/text_views.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';


class UploadingFailed extends StatefulWidget {
  const UploadingFailed({Key? key}) : super(key: key);

  @override
  _UploadingFailedState createState() => _UploadingFailedState();
}

class _UploadingFailedState extends State<UploadingFailed> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.appBackground,
        body: Container(
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
                      AppColors.gradientColor1,
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
                    Image.asset(Assets.uploadIconOrange,),
                    SizedBox(height: getHeight() * 0.01),
                    TextView.bold35Text("Upload Failed", color: AppColors.orangeColor),
                    SizedBox(height: getHeight() * 0.04),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: sizes.width * 0.03),
                      height: getHeight() * 0.013,
                      width: getWidth(),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: AppColors.borderColor,
                        //border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.01)),
                      ),

                    ),
                    SizedBox(height: getHeight() * 0.04),
                    SizedBox(
                        width: getWidth() * 0.8,
                        child: TextView.getText20(
                            "Something went wrong, please try again",
                            color: AppColors.darkGrey,
                            lines: 2,
                            textAlign: TextAlign.center
                        )),
                    SizedBox(height: getHeight() * 0.08),
                    CommonWidgets.getButton(
                      onPress: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const UploadSuccess()));
                      },
                      text: "Try Again",
                      btnColor: AppColors.greenColor,
                      textColor: AppColors.pureWhiteColor
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}