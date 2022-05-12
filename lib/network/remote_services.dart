// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/common/api_error_message.dart';
import 'package:flutter_app/network/network_exception.dart';
import 'package:flutter_app/network/secure_http_client.dart';

class RemoteServices  {
  Future<dynamic> postRequest(String endPoint, Map<String, dynamic> map) async {
    dynamic resJson;
    try {
      dynamic _result = await MySecureHttpClient.getClient().post(endPoint, data: map);
      if (_result.statusCode == 200 || _result.statusCode == 201) {
        resJson = json.decode(_result.toString());
        return resJson;
      }
    } catch (e) {
      errorMessage(e);
    }
  }

  Future<dynamic> getRequest(String endPoint, Map<String, dynamic> map) async {
    dynamic resJson;
    try {
      dynamic _result = await MySecureHttpClient.getClient().get(endPoint, queryParameters: map);
      log('status_code: ${_result.statusCode}');
      if (_result.statusCode == 200) {
          resJson = json.decode(_result.toString());
        return resJson;
      }
    }
    catch (e) {
      if (kDebugMode) print(e.toString());
      if (e is DioError) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        if (kDebugMode) print(errorMessage);
      }
    }
  }
}
