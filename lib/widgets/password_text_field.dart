import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController ? textEditingController;
  final bool ? obscureText;
  final String?  hint;
  final TextInputType? textInputType;
  final double ? width;
  final String ? icon;
  final Color? borderColor;
  final Color? bgColor;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? cursorColor;
  final bool? hidePassword;
  final Function? clickIcon;


  const PasswordTextField(
      {Key? key, this.textEditingController,
      this.obscureText,
      this.hint,
      this.textInputType,
      this.width,
      this.icon,
      this.borderColor,
      this.bgColor,
      this.textColor,
      this.hintTextColor,
      this.cursorColor,
      this.hidePassword,
      this.clickIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight() * 0.07,
      width:  width??sizes.width,
      decoration: BoxDecoration(
          color: bgColor?? AppColors.lightGrey,
          border: Border.all(color: borderColor?? AppColors.lightGrey),
          borderRadius: BorderRadius.all(Radius.circular(getHeight()*.01))
      ),
      child: Center(
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: textEditingController,
          obscureText: hidePassword!,
          cursorHeight: getHeight()*.03,
          keyboardType: textInputType??TextInputType.text,
          cursorColor: cursorColor?? AppColors.lightBlack,
          style: TextStyle(
            color: textColor ?? AppColors.lightBlack,
            fontSize: sizes.fontSize15,
            fontFamily:Assets.poppinsMedium,
          ),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: getWidth()*.02),
            hintText: hint??"",
            alignLabelWithHint: false,
            hintStyle: TextStyle(
              color: hintTextColor ?? AppColors.darkGrey,
              fontSize: sizes.fontSize15,
              fontFamily:Assets.poppinsMedium,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                hidePassword!
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: AppColors.darkGrey,
              ),
              onPressed: () {
                if (clickIcon != null) {
                  clickIcon!.call();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
