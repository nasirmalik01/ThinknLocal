import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/res/res.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';

class TextView {
  static Text titleWithDecoration(final text, {@required final color, final TextAlign textAlign = TextAlign.start, double? fontSize, final fontFamily, final height, final TextDecoration textDecoration = TextDecoration.none, final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: height ?? getHeight() * 0.0018,
        decoration: textDecoration,
        fontSize: fontSize ?? sizes.fontSize15,
        fontFamily: fontFamily?? Assets.poppinsRegular,
        color: color,
      ),
    );
  }

  static Text titleWithBlurRadius(final text, final fontFamily, {@required final color, final TextAlign textAlign = TextAlign.start, final fontWeight, final shadowColor = AppColors.pureWhiteColor, final  double blurRadius = 0, @required final lines, final fontSize, final isUnderLine = false}) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      style: TextStyle(
        fontSize: fontSize ?? sizes.fontSize16,
        fontWeight: fontWeight?? FontWeight.w500,
        fontFamily: fontFamily,
        color: color,
        decoration: isUnderLine ? TextDecoration.underline : TextDecoration.none,
        shadows: [
          Shadow(
            color: shadowColor,
            blurRadius: blurRadius,
          ),
        ],
      ),
    );
  }

  static Text title(final text, {@required final color, final TextAlign textAlign = TextAlign.start, final fontFamily, final lines, final fontSize}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize ?? sizes.fontSize18,
        fontFamily: fontFamily?? Assets.poppinsRegular,
        color: color,
      ),
    );
  }

  static Text subTitle(final text, {@required final color, final TextAlign textAlign = TextAlign.start, final fontFamily, final lines, bool isSetFontWeight = true, final fontSize}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize ?? sizes.fontSize20,
        fontFamily: fontFamily?? Assets.poppinsMedium,
        fontWeight: isSetFontWeight ? FontWeight.w400 : FontWeight.normal,
        color: color,
      ),
    );
  }

  static Text subTitleWithBlurRadius(final text, {@required final color, final TextAlign textAlign = TextAlign.start, final fontFamily, final shadowColor = AppColors.pureWhiteColor, final  double blurRadius = 0, final lines, final fontSize}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize ?? sizes.fontSize13,
        fontFamily: fontFamily?? Assets.poppinsRegular,
        color: color,
        shadows: [
          Shadow(
            color: shadowColor,
            blurRadius: blurRadius,
          ),
        ],
      ),
    );
  }

  static Text subHeader(final text, {@required final color, final TextAlign textAlign = TextAlign.start, final fontFamily, final TextDecoration textDecoration = TextDecoration.none, final lines, final fontSize}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: textDecoration,
        fontSize: fontSize ?? sizes.fontSize10,
        fontFamily: fontFamily?? Assets.poppinsRegular,
        color: color,
      ),
    );
  }

  static Text caption(final text, {@required final color, final TextAlign textAlign = TextAlign.start, final fontFamily, final lines, final fontSize, bool isEllipsis = true}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: isEllipsis ? TextOverflow.ellipsis : TextOverflow.visible,
      style: TextStyle(
        fontSize: fontSize ?? sizes.fontSize11,
        fontFamily: fontFamily?? Assets.poppinsRegular,
        color: color,
      ),
    );
  }

  static Text header(final text, {@required final color, final TextAlign textAlign = TextAlign.start, final fontFamily, final lines, final fontSize, final TextDecoration textDecoration = TextDecoration.none,}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: textDecoration,
        fontSize: fontSize ?? sizes.fontSize30,
        fontFamily: fontFamily?? Assets.poppinsSemiBold,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }

  static Text headerWithBlurRadius(final text, {@required final color, final TextAlign textAlign = TextAlign.start, final shadowColor = AppColors.pureWhiteColor, final  double blurRadius = 0, final fontFamily, final TextDecoration textDecoration = TextDecoration.none, final lines, final fontSize}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: textDecoration,
        fontSize: fontSize ?? sizes.fontSize12,
        fontFamily: fontFamily?? Assets.poppinsRegular,
        color: color,
        shadows: [
          Shadow(
            color: shadowColor,
            blurRadius: blurRadius,
          ),
        ],
      ),
    );
  }
}
