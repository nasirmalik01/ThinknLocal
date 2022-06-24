import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/network/network_exception.dart';
import 'package:thinknlocal_app/network/remote_services.dart';
import 'package:get/get.dart';

bool serverHandlingExceptions(dynamic e, int? statusCode, String error){
  if (e is DioError) {
        Map<String, dynamic> errorMessageMap = json.decode(e.response?.data);
        if (e.response!.data.toString().contains('email')) {
          Get.back();
          String errorMessage = errorMessageMap['email'][0];
          showSnackBar(subTitle: 'Email $errorMessage');
          return true;
        }
        if (e.response!.data.toString().contains('errors')) {
          Get.back();
          String errorMessage = errorMessageMap['errors'];
          showSnackBar(subTitle: errorMessage);
          return true;
        }
        if (e.response!.data.toString().contains('zip')) {
          RemoteServices.isZipRequired = true;
          return true;
        }
        final errorMessage = DioExceptions.fromDioError(e).toString();
        showSnackBar(subTitle: errorMessage);
        error = errorMessage;
        statusCode = e.response?.statusCode;
        Get.back();
        return true;
  }
  return false;
}