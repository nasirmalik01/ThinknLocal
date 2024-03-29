import 'package:dio/dio.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/routes.dart';
import 'package:get/get.dart';

class DioExceptions implements Exception {
  var message = '';

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(dioError.response?.statusCode, dioError.response?.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    String message = '';
    switch (statusCode) {
      case 400:
        message = 'Bad request';
        break;
      case 401:
        message = 'You are not logged in';
        Get.offAllNamed(Routes.loginScreen, arguments: true);
        showSnackBar(subTitle: 'You are not logged in');
        break;
      case 403:
        message = 'Forbidden! You are running an outdated app version and must upgrade';
        if (Get.currentRoute != Routes.updateRequiredScreen) {
          showSnackBar(subTitle: 'You are running an outdated app version and must upgrade');
          Routes.offAllTo(Routes.updateRequiredScreen);
        }
        break;
      case 422:
        message = 'Form data is invalid';
        break;
        case 404:
        message = 'Requested page is not available';
        break;
      case 408:
        message = 'No internet connection';
        break;
      case 500:
        message = 'Internal server error, Try Again!';
        if(Get.isDialogOpen!){
          Get.back();
        }
        showSnackBar(subTitle: message);
        break;
        case 503:
        message = 'Service unavailable! Application under maintenance.';
        if (Get.currentRoute != Routes.underMaintenanceScreen) {
          showSnackBar(subTitle: 'Service unavailable! Application under maintenance.');
          Routes.offAllTo(Routes.underMaintenanceScreen);
        }
        break;
      default:
        message = 'Oops something went wrong';
        Get.offAllNamed(Routes.somethingWrongScreen);
        break;
    }
    return message;
  }

  @override
  String toString() => message;
}