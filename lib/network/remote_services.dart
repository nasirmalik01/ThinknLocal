// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/common/registration_exceptions.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/network/network_exception.dart';
import 'package:flutter_app/network/secure_http_client.dart';
import 'package:get/get.dart';

class RemoteServices  {
  static String error = '';
  static int? statusCode = 200;


  Future<dynamic> postRequest(String endPoint, Map<String, dynamic> map, {void Function(int, int)? uploadFile}) async {
    dynamic resJson;
    try {
      dynamic _result = await MySecureHttpClient.getClient().post(endPoint, data: map, onSendProgress: uploadFile);
      if (_result.statusCode == 200 || _result.statusCode == 201) {
        resJson = json.decode(_result.toString());
        return resJson;
      }
    }
    catch (e) {
      serverHandlingExceptions(e, statusCode, error);
    }
  }

  Future<dynamic> getRequest(String endPoint, Map<String, dynamic> map) async {
    dynamic resJson;
    try {
      dynamic _result = await MySecureHttpClient.getClient().get(endPoint, queryParameters: map);
      log('status_code: ${_result.statusCode}');
      if (_result.statusCode == 200) {
          statusCode = 200;
          resJson = json.decode(_result.toString());
          return resJson;
      }
    }
    catch (e) {
     if(e is DioError){
       final errorMessage = DioExceptions.fromDioError(e).toString();
       showSnackBar(subTitle: errorMessage);
       error = errorMessage;
       statusCode = e.response?.statusCode;
       if (kDebugMode) print(errorMessage);
     }
    }
  }
}
