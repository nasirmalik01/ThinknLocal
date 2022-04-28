import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/network/network_exception.dart';
import 'package:flutter_app/network/secure_http_client.dart';
import 'package:get/get.dart';

class RemoteServices  {
  late final secureRepository;
  late final InsecureClient;

  void init(){
    secureRepository = MySecureHttpClient.getClient();
    InsecureClient = MySecureHttpClient.getInsecureClient();
  }

  Future<dynamic> postRequest(String endPoint, Map<String, dynamic> map) async {
    dynamic resJson;
    try {
      dynamic _user = await secureRepository.post(endPoint, data: map);
      if (_user.statusCode == 200 || _user.statusCode == 201) {
        resJson = json.decode(_user.toString());
        // print('Response: $resJson');
        return resJson;
      }
    } catch (e) {
      if (kDebugMode) print('Error');
      if (e is DioError) {
        if(e.response!.data.toString().contains('email')){
          Get.back();
          showSnackBar(subTitle: 'Email ${e.response!.data['email'][0]}');
        }
        else if(e.response!.data.toString().contains('errors')){
          Get.back();
          showSnackBar(subTitle: '${e.response!.data['errors']}');
        }
      }
    }
  }

  Future<dynamic> getRequest(String endPoint, Map<String, dynamic> map) async {
    dynamic resJson;
    try {
      // String token = MyHive.getToken();
      // secureRepository!.options.headers['authorization'] = token;
      // debugPrint('Token: $token}');
      dynamic _user = await secureRepository.get(endPoint, queryParameters: map);
      print('status_code: ${_user.statusCode}');
      if (_user.statusCode == 200) {
        if (_user.data is List) {
          for (var userData in _user.data) {
            resJson = json.decode(userData.toString());
          }
        }
        else {
          resJson = json.decode(_user.toString());
        }
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
