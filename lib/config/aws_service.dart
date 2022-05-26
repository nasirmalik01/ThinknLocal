import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/network/secure_http_client.dart';

class AWSService {
  Function(String)? onUploadError;
  Function(String)? onUploadComplete;
  Function(double)? onProgressChange;
  final String _bucketName = 'thinknlocal-staging';
  final Dio _dio = Dio(
    BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 60 * 1000 // 60 seconds
        ),
  );

  Future<void> uploadFile(
    File image,
  ) async {
    try {
      Response? urlResponse = await generateUrl(
        body: getBodyPayload(image),
      );
      Map<String, dynamic> mapData = json.decode(urlResponse?.data);
      String dURL = mapData['upload_url'];
      var response = await _dio.put(
        dURL,
        data: image.readAsBytesSync().lengthInBytes,
        onSendProgress: (rec, total) {
          double progress = (rec / total * 100).toDouble();
          log('Uploading : $progress');
        },
      );
      if (response.statusCode == 200) {
        log(response.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Response?> generateUrl({Map<String, dynamic>? body}) async {
    try {
      Response response = await MySecureHttpClient.getClient().post(
        ApiEndPoints.uploadContributions,
        data: body,
      );
      return response;
    } on DioError catch (e) {
      log('Error : $e');
      return null;
    }
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Map<String, dynamic> getBodyPayload(File image) {
    final bytes = getImageSizeInBytes(image);
    String fileName = image.path.split('/').last;
    String getExt = PreferenceUtils.getImgExtension(image.path);
    String md5Hash = generateMd5(image.path);

    return {
      'file_name': fileName,
      'content_type': getExt,
      'byte_size': bytes,
      'checksum': md5Hash,
    };
  }

  int getImageSizeInBytes(File image) {
    return image.readAsBytesSync().lengthInBytes;
  }

//   final bytes = image.readAsBytesSync().lengthInBytes;
// final kb = bytes / 1024;
// final mb = kb / 1024;
}
