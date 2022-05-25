import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';

class DialogButton extends StatelessWidget {
  final double ? width;
  final double ? height;
  final String ? text;
  final Function ? onPress;
  final Color ? btnColor;
  final Color ? textColor;
  final Color ? borderColor;


  const DialogButton(
      {Key? key, this.width,
        this.height,
        this.text,
        this.onPress,
        this.btnColor,
        this.textColor,
        this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //key: const Key('Main button'),
      onTap: (){
        onPress!.call();
      },
      child: Container(
        height: height?? getHeight() * 0.075,
        width:  width?? getWidth(),
        decoration: BoxDecoration(
          color: btnColor??AppColors.greenColor,
          border: Border.all(color: borderColor??Colors.transparent),
          borderRadius: BorderRadius.circular(getWidth()*.02,),
        ),
        child: Center(
            child: TextView.caption(
                text??"SUBMIT",
                color: textColor?? AppColors.pureWhiteColor,
                fontFamily: Assets.poppinsRegular,
                fontSize: sizes.fontSize14
            )
        ),
      ),
    );
  }
}