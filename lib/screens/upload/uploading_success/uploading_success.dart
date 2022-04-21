import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/text_views.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';
import '../../bottom_tab/bottom_tab_new.dart';


class UploadSuccess extends StatefulWidget {
  const UploadSuccess({Key? key}) : super(key: key);

  @override
  _UploadSuccessState createState() => _UploadSuccessState();
}

class _UploadSuccessState extends State<UploadSuccess> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(
                    height: getHeight() * 0.2,
                    width: getWidth() * 0.35,
                    child: Stack(children: [
                      Stack(
                        children: [
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Image.asset(Assets.uploadIcon,)),
                          const Positioned(
                            bottom: 0,
                            child: Image(
                              image: AssetImage(Assets.blurEffect),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                              width: getWidth() * 0.15,
                              child: Image.asset(Assets.successIcon)))
                    ]),
                  ),
                  SizedBox(height: getHeight() * 0.01),
                  TextView.header("Success!", color: AppColors.greenColor, fontSize: sizes.fontSize35),
                  SizedBox(height: getHeight() * 0.04),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: sizes.width * 0.03),
                    height: getHeight() * 0.013,
                    width: getWidth(),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.01)),
                    ),

                  ),
                  SizedBox(height: getHeight() * 0.04),
                  SizedBox(
                      width: getWidth() * 0.8,
                      child: TextView.subTitle(
                          "Successfully uploaded your receipt. Thanks for your contribution!",
                          color: AppColors.darkGrey,
                          lines: 3,
                          textAlign: TextAlign.center
                      )),
                  SizedBox(height: getHeight() * 0.08),
                  CommonWidgets.getButton(
                      onPress: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute (builder: (_) => const BottomTabNew(pageIndex: 0)), (route) => false);
                      },
                      text: "Finish",
                      btnColor: AppColors.greenColor,
                      textColor: AppColors.pureWhiteColor
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}