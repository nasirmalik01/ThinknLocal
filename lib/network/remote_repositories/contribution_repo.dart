import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/network/secure_http_client.dart';

class ContributionRepo {
  Future<Response?> generateUrl({Map<String, dynamic>? query}) async {
    try {
      Response response = await MySecureHttpClient.getClient().post(
        ApiEndPoints.uploadContributions,
      );
      return response;
    } on DioError catch (e) {
      log('Error : $e');
      return null;
    }
  }
}
