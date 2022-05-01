import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:get/get.dart';

void errorMessage(dynamic e){
  if (kDebugMode) print('Error');
  if (e is DioError) {
    if(e.response!.data.toString().contains('email')){
      Get.back();
      showSnackBar(subTitle: 'Email ${e.response!.data['email'][0]}');
    }
    else if(e.response!.data.toString().contains('errors')){
      Get.back();
      showSnackBar(subTitle: 'Email or password is invalid');
    }
  }
}