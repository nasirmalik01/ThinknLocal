import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/network/remote_services.dart';

class AuthRepository {
  static Future<dynamic> login(
      {required String email, required String password}) async {
    final response = await getItLocator<RemoteServices>()
        .postRequest(ApiEndPoints.authenticate, {
      Strings.email: email,
      Strings.password: password,
    });
    return response;
  }

  static Future<dynamic> setNewPassword({
    required String token,
    required String password,
    required String confrimPassowrd,
    required String email,
  }) async {
    final response = await getItLocator<RemoteServices>()
        .patchRequest(ApiEndPoints.resetPassword, {
      'reset_token': token,       
      'password': password,
      'password_confirmation': password,
      'email': email,
    });

    return response;
  }

  static Future<dynamic> verifyResetPin({
    required String email,
    required pin,
  }) async {
    final response = await getItLocator<RemoteServices>()
        .postRequest(ApiEndPoints.resetPin, {
      'email': email,
      'password_reset_code': pin,
    });
    return response;
  }

  static Future<dynamic> resetPassword({required String email}) async {
    final response =
        await getItLocator<RemoteServices>().postRequest('password_reset', {
      'email': email,
    });
    return response;
  }
}
