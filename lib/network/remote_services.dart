// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/common/registration_exceptions.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/network/network_exception.dart';
import 'package:flutter_app/network/secure_http_client.dart';

class RemoteServices {
  static String error = '';
  static int? statusCode = 200;
  static bool isNextPage = false;
  static bool isZipRequired = false;
  bool appUnderMaintenance = false;

  Future<dynamic> postRequest(String endPoint, Map<String, dynamic> map, {void Function(int, int)? uploadFile}) async {
    dynamic resJson;
    isZipRequired = false;
    try {
      dynamic _result = await MySecureHttpClient.getClient().post(endPoint, data: map, onSendProgress: uploadFile);
      if (_result.statusCode == 200 || _result.statusCode == 201) {
        resJson = json.decode(_result.toString());
        return resJson;
      }
    } catch (e) {
      final _isServerException = serverHandlingExceptions(e, statusCode, error);
      if(_isServerException) return;
      if (e is DioError) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        log('error in post request: $errorMessage');
        showSnackBar(subTitle: errorMessage);
        error = errorMessage;
        statusCode = e.response?.statusCode;
        if (kDebugMode) print(errorMessage);
      }
    }
  }

  Future<dynamic> getRequest(String endPoint, Map<String, dynamic> map) async {
    dynamic resJson;
    try {
      Response _result = await MySecureHttpClient.getClient().get(endPoint, queryParameters: map);
      checkNextPage(_result.headers);
      log('status_code: ${_result.statusCode}');
      if (_result.statusCode == 200) {
        statusCode = 200;
        resJson = json.decode(_result.toString());
        return resJson;
      }
    } catch (e) {
      if (e is DioError) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        log('error: $errorMessage');
        error = errorMessage;
        statusCode = e.response?.statusCode;
        if (kDebugMode) print(errorMessage);
      }
    }
  }

  Future<dynamic> patchRequest(
      String endPoint, Map<String, dynamic> map) async {
    dynamic resJson;
    try {
      dynamic _result = await MySecureHttpClient.getClient().patch(endPoint, data: map);
      if (_result.statusCode == 200 || _result.statusCode == 201) {
        resJson = json.decode(_result.toString());
        return resJson;
      }
    }
    catch (e) {
      serverHandlingExceptions(e, statusCode, error);
      throw Exception(e.toString());
    }
  }

  checkNextPage(Headers headers){
    if(headers.toString().contains(Strings.next)){
      isNextPage = true;
    }else{
      isNextPage = false;
    }
  }
}
