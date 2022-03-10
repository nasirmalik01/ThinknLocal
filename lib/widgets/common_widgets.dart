import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/text_views.dart';

import '../res/assets.dart';
import '../res/colors.dart';
import '../res/res.dart';


class CommonWidgets {
  static  Widget textField({
    TextEditingController ? textEditingController,
    bool ? obscureText,
    String?  hint,
    TextInputType? textInputType,
    double ? width,
    String ? icon,
    Color? borderColor,
    Color? bgColor,
    Color? textColor,
    Color? hintTextColor,
    Color? cursorColor
  }){
    return   Container(
      height: getHeight() * 0.07,
      width:  width??sizes!.width,
      decoration: BoxDecoration(
          color: bgColor?? AppColors.lightGrey,
          border: Border.all(color: borderColor?? AppColors.lightGrey),
          borderRadius: BorderRadius.all(Radius.circular(getHeight()*.01))
      ),
      child: Center(
        child: TextField(
          controller: textEditingController,
          obscureText:obscureText?? false,
          cursorHeight: getHeight()*.03,
          keyboardType: textInputType??TextInputType.text,
          cursorColor: cursorColor?? AppColors.lightBlack,
          style: TextStyle(
            color: textColor ?? AppColors.lightBlack,
            fontSize: sizes!.fontSize15,
            fontFamily:Assets.poppinsMedium,
          ),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: getWidth()*.02),
              hintText: hint??"",
              alignLabelWithHint: false,
              hintStyle: TextStyle(
                color: hintTextColor ?? AppColors.darkGrey,
                fontSize: sizes!.fontSize15,
                fontFamily:Assets.poppinsMedium,
              )
          ),
        ),
      ),
    );
  }

  static Widget getButton({
    double ? width,
    double ? height,
    String ? text,
    required Function ? onPress,
    Color ? btnColor,
    Color ? textColor,
    Color ? borderColor,
  }) {
    return GestureDetector(
      onTap: (){
        onPress!.call();
      },
      child: Container(
        height: height?? getHeight() * 0.07,
        width:  width??sizes!.width,
        decoration: BoxDecoration(
          color: btnColor??AppColors.greenColor,
          border: Border.all(color: borderColor??Colors.transparent),
          borderRadius: BorderRadius.circular(getWidth()*.02,),
        ),
        child: Center(
            child: TextView.getMediumText18(
              text??"SUBMIT",
              color: textColor?? AppColors.pureWhiteColor,
              fontFamily: Assets.poppinsMedium
            )
        ),
      ),
    );
  }
  
  static Widget getSmallButton({Color? borderColor, Color? fillColor}) {
    return Container(
      height: getHeight() * 0.03,
      width: getWidth() * 0.03,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fillColor?? AppColors.pureWhiteColor,
        border: Border.all(color: borderColor ?? AppColors.greenColor)
      ),
    );
  }

  static Widget searchLocation({TextEditingController? controller, String?  hint}) {
    return Container(
      padding: EdgeInsets.only(right: getWidth() * 0.02),
      //height: getHeight() * 0.06,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: AppColors.pureWhiteColor,
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        style: TextStyle(
            fontFamily: Assets.poppinsRegular,
            fontSize: sizes!.fontSize15,
            color: AppColors.lightBlack
        ),
        decoration: InputDecoration(
          hintText: hint ?? "Search",
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintStyle: TextStyle(
              fontFamily: Assets.poppinsRegular,
              fontSize: sizes!.fontSize15,
              color: AppColors.veryLightGrey
          ),
          prefixIcon: const Icon(
            Icons.search_outlined,
            color: AppColors.darkGrey,
          ),
        ),
      ),
    );
  }



}


