class UploadFileResponse<T> {
  int? statusCode;
  bool isSuccess;
  String? message;
  T? data;

  UploadFileResponse(
      {this.statusCode, this.isSuccess = false, this.data, this.message});
}
