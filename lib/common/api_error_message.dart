import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:get/get.dart';

void errorMessage(dynamic e){
  if (kDebugMode) print('Error');
  if (e is DioError) {
    Map<String, dynamic> errorMessageMap = json.decode(e.response!.data);
    if(e.response!.data.toString().contains('email')){
      Get.back();
      String errorMessage = errorMessageMap['email'][0];
      showSnackBar(subTitle: 'Email $errorMessage');
    }
    else if(e.response!.data.toString().contains('errors')){
      Get.back();
      String errorMessage = errorMessageMap['errors'];
      showSnackBar(subTitle: errorMessage);
    }
  }
}