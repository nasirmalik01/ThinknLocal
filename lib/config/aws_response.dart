class UploadFileResponse<T> {
  int? statusCode;
  bool isSuccess;
  String? message;
  T? data;
  String? uploadId;

  UploadFileResponse(
      {this.statusCode, this.isSuccess = false, this.data, this.message, this.uploadId});
}
