import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/config/aws_response.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/network/secure_http_client.dart';





class AWSService {
  Function(UploadFileResponse)? onUploadError;
  Function(UploadFileResponse)? onUploadComplete;
  Function(double)? onProgressChange;
  final Dio _dio = Dio(
  );

  Future<void> uploadFile(
    File image, {
    required Function(UploadFileResponse) onUploadError,
    required Function(UploadFileResponse) onUploadComplete,
    required Function(double) onProgressChange,
  }) async {
    /// set listeners
    this.onProgressChange = onProgressChange;
    this.onUploadError = onUploadError;
    this.onUploadComplete = onUploadComplete;

    try {
      var body = await getBodyPayload(image);
      Response? urlResponse = await generateUrl(
        body: body,
      );
      Map<String, dynamic> mapData = json.decode(urlResponse?.data);
      String dURL = mapData['upload_url'];
      var response = await _dio.put(
        dURL,
        options: Options(
          headers: {
            'Content-Type': body['content_type'],
            'Content-Length': body['byte_size'],
            'Content-MD5': body['checksum'],
            'x-amz-acl': 'public-read',
          },
        ),
        data: image.openRead(),
        onSendProgress: (rec, total) {
          double progress = (rec / total * 100).toDouble();
          onProgressChange.call(progress);
        },
      );
      if (response.statusCode == 200) {
        onUploadComplete.call(
          getFileResponse(
            r: response,
            uploadId: mapData['id'],
          ),
        );
      }
    } on DioError catch (e) {
      log(e.toString());
      onUploadError.call(getFileResponse(r: e));
    } on SocketException catch(e){
      onUploadError.call(getFileResponse(r: e));
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

  UploadFileResponse getFileResponse({dynamic r, String? uploadId}) {
    if (r is DioError) {
      DioError e = r;
      return UploadFileResponse(
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage ?? e.message,
        isSuccess: false,
        data: e.response?.data,
        uploadId: uploadId,
      );
    }else if(r is SocketException){
      return UploadFileResponse(
        statusCode: 501,
        isSuccess: false,
        message: 'No internet connection',
        data: {},
        uploadId: null,
      );
    } else {
      Response response = r;
      return UploadFileResponse(
        statusCode: response.statusCode,
        isSuccess: true,
        message: 'File Uploaded Successfully',

        /// [response.headers] because it container e-tag, id , etc related to file Uploading
        data: response.headers.map,
        uploadId: uploadId,
      );
    }
  }
}
