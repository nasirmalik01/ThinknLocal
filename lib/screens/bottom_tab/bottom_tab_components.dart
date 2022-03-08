import 'package:flutter/cupertino.dart';

import '../../res/assets.dart';
import '../../res/res.dart';

class BottomTabComponents {
  // Widget getBottomTabText({String ? text}){
  //   return Text(text??"",
  //     maxLines: 1,
  //     style: TextStyle(
  //       fontFamily: Assets.latoBold,
  //       fontSize: sizes?.mediumFontSize,
  //     ),
  //   );
  // }

  Widget getBottomTabIcons({String ? icon, final color}){
    return Image(
      image: AssetImage(icon??""),
      height: 22,
      width: 22,
      color: color,
    );
  }
}