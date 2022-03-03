import 'package:flutter/material.dart';

class AppColors{

  static const darkBlueColor = Color.fromRGBO(5, 19, 57, 1);

  static const greenColor = Color.fromRGBO(0, 196, 140, 1);
  static const lightGrey = Color.fromRGBO(246, 246, 248, 1);
  static const darkGrey = Color.fromRGBO(141, 154, 174, 1);
  static const blackColor = Color.fromRGBO(48, 54, 63, 1);
  static const pureWhiteColor = Color.fromRGBO(255, 255, 255, 1);
  static const borderColor = Color.fromRGBO(210, 218, 225, 1);
  static const lightBlack = Color.fromRGBO(25, 31, 39, 1);
  static const gradientColor1 = Color.fromRGBO(125, 223, 195, 1);



}


extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}