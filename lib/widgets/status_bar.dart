import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

setStatusBarColor({required Color color}){
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: Brightness.dark
  ));
}