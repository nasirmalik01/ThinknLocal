
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/res/res.dart';
import '../res/assets.dart';

class TextView {

  static Text getExtraLargeText(
      final text, final fontFamily,
      {@required final color,
      final TextAlign textAlign = TextAlign.start,
      @required final lines}) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      style: TextStyle(
        fontSize: sizes!.fontSize24,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }

  static Text getMediumText16(final text, final fontFamily,
      {@required final color,
      final TextAlign textAlign = TextAlign.start,
      @required final lines}) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      style: TextStyle(
        fontSize: sizes!.fontSize16,
        // fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }
  static Text getRegularText(final text, final fontFamily,
      {@required final color,
      final TextAlign textAlign = TextAlign.start,
      @required final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        // fontSize: sizes!.regularFontSize,
        fontSize: sizes!.fontSize12,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }

  static Text semiBold10Text(
  final text,
      {@required final color,
        final TextAlign textAlign = TextAlign.start,
        final fontFamily,
        final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: sizes!.fontSize10,
        fontFamily: fontFamily?? Assets.latoRegular,
        color: color,
      ),
    );
  }

  static Text regular12Text(
      final text,
      {@required final color,
        final TextAlign textAlign = TextAlign.start,
        final fontFamily,
        final height,
        final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      textWidthBasis: TextWidthBasis.values[1],
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: sizes!.fontSize12,
        fontFamily: fontFamily?? Assets.latoRegular,
        color: color,
        height: height
      ),
    );
  }

  static Text bold12Text(
      final text,
      {@required final color,
        final TextAlign textAlign = TextAlign.start,
        final fontFamily,
        final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: sizes!.fontSize12,
        fontFamily: fontFamily?? Assets.latoRegular,
        color: color,
      ),
    );
  }

  static Text bold15Text(
      final text,
      {@required final color,
        final TextAlign textAlign = TextAlign.start,
        final fontFamily,
        final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: sizes!.fontSize15,
        fontFamily: fontFamily?? Assets.latoRegular,
        color: color,
      ),
    );
  }

  static Text regular16Text(
      final text,
      {@required final color,
        final TextAlign textAlign = TextAlign.start,
        final fontFamily,
        final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: sizes!.fontSize16,
        fontFamily: fontFamily?? Assets.latoRegular,
        color: color,
      ),
    );
  }

  static Text bold20Text(
      final text,
      {@required final color,
        final TextAlign textAlign = TextAlign.start,
        final fontFamily,
        final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: sizes!.fontSize20,
        fontFamily: fontFamily?? Assets.latoRegular,
        color: color,
      ),
    );
  }

  static Text bold24Text(
      final text,
      {@required final color,
        final TextAlign textAlign = TextAlign.start,
        final fontFamily,
        final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: sizes!.fontSize24,
        fontFamily: fontFamily?? Assets.latoRegular,
        color: color,
      ),
    );
  }

  static Text bold30Text(
      final text,
      {@required final color,
        final TextAlign textAlign = TextAlign.start,
        final fontFamily,
        final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: sizes!.fontSize30,
        fontFamily: fontFamily?? Assets.latoRegular,
        color: color,
      ),
    );
  }

}
