import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

setStatusBarColor({required Color color, bool isTextColorLight = false}){
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: isTextColorLight ? Brightness.light : Brightness.dark
  ));
}