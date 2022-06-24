import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/widgets/button.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';

class NetworkErrorException extends StatelessWidget {
  final String exceptionMessage;
  final Function() onPress;
  const NetworkErrorException({required this.exceptionMessage, required this.onPress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth()*0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
                height: getHeight()*0.25,
                width: getHeight()*0.25,
                image: const AssetImage(Assets.warningIcon)),
            TextView.subTitle(exceptionMessage, color: Colors.black, fontSize: sizes.fontSize18, isEllipses: false, textAlign: TextAlign.center),
            SizedBox(height: getHeight()*0.05,),
            Button(text: Strings.tryAgain, width: MediaQuery.of(context).size.width * 0.8, height: MediaQuery.of(context).size.height * 0.07, btnColor: AppColors.greenColor, textColor: AppColors.pureWhiteColor, onPress: onPress,)
          ],
        ),
      ),
    );
  }
}
