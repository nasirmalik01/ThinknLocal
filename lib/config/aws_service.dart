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
      var body = await getBodyPayload(image);
      Response? urlResponse = await generateUrl(
        body: body,
      );
      Map<String, dynamic> mapData = json.decode(urlResponse?.data);
      String dURL = mapData['upload_url'];
      var response = await _dio.put(
        dURL,
        options: Options(headers: mapData['headers']),
        data: image.readAsBytesSync(),
        onSendProgress: (rec, total) {
          double progress = (rec / total * 100).toDouble();
          log('Uploading : $progress $rec bytes');
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

  Future<String> generateMd5(String filePath) async {
    var hash = await md5.bind(File(filePath).openRead()).first;
    return base64.encode(hash.bytes);
  }

  Future<Map<String, dynamic>> getBodyPayload(File image) async {
    final bytes = getImageSizeInBytes(image);
    String fileName = image.path.split('/').last;
    String getExt = PreferenceUtils.getImgExtension(image.path);
    String md5Hash = await generateMd5(image.path);

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
