import 'package:flutter/services.dart';
import 'package:flutter_app/constants/colors.dart';

class SystemChromeConfig{

  static setOverLayStyle(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.pureWhiteColor,
        statusBarIconBrightness: Brightness.dark
    ));
  }

  static setOrientation(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}