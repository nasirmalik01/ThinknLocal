
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/res/res.dart';
import '../res/assets.dart';

class TextView {

  static Text getMediumText16(final text, final fontFamily,
      {@required final color,
      final TextAlign textAlign = TextAlign.start, final fontWeight,
      @required final lines}) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      style: TextStyle(
        fontSize: sizes!.fontSize16,
        fontWeight: fontWeight?? FontWeight.w500,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }

  static Text getMediumText18(
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
        fontSize: sizes!.fontSize18,
        fontFamily: fontFamily?? Assets.latoRegular,
        color: color,
      ),
    );
  }

  static Text getMediumText15(
      final text,
      {@required final color,
        final TextAlign textAlign = TextAlign.start,
        final fontFamily, final height,
        final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: height ?? getHeight() * 0.0018,
        fontSize: sizes!.fontSize15,
        fontFamily: fontFamily?? Assets.latoRegular,
        color: color,
      ),
    );
  }
  static Text getMediumText15UnderLine(
      final text,
      {@required final color,
        final TextAlign textAlign = TextAlign.start,
        final fontFamily, final TextDecoration textDecoration = TextDecoration.none,
        final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: textDecoration,
        fontSize: sizes!.fontSize15,
        fontFamily: fontFamily?? Assets.latoRegular,
        color: color,
      ),
    );
  }

  static Text getText13(
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
        fontSize: sizes!.fontSize13,
        fontFamily: fontFamily?? Assets.poppinsRegular,
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
        final fontFamily, final TextDecoration textDecoration = TextDecoration.none,
        final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: textDecoration,
        fontSize: sizes!.fontSize10,
        fontFamily: fontFamily?? Assets.latoRegular,
        color: color,
      ),
    );
  }


  static Text regular11Text(
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
        fontSize: sizes!.fontSize11,
        fontFamily: fontFamily?? Assets.latoRegular,
        color: color,
      ),
    );
  }

  static Text bold12Text(
      final text,
      {@required final color,
        final TextAlign textAlign = TextAlign.start,
        final fontFamily, final TextDecoration textDecoration = TextDecoration.none,
        final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: textDecoration,
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

  static Text bold14Text(
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
        fontSize: sizes!.fontSize14,
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

  static Text bold22Text(
      final text,
      {@required final color,
        final TextAlign textAlign = TextAlign.start,
        final fontFamily, final TextDecoration textDecoration = TextDecoration.none,
        final lines}) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: textDecoration,
        fontSize: sizes!.fontSize22,
        fontFamily: fontFamily?? Assets.poppinsSemiBold,
        color: color,
      ),
    );
  }

  static Text bold25Text(
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
        fontSize: sizes!.fontSize25,
        fontFamily: fontFamily?? Assets.latoBold,
        fontWeight: FontWeight.w700,
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
        fontFamily: fontFamily?? Assets.latoBold,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }

  static Text getText27(
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
        fontFamily: fontFamily?? Assets.poppinsMedium,
        color: color,
      ),
    );
  }

}
