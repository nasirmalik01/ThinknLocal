import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/model/dummy/account.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get_it/get_it.dart';

class ProfileRemoteRepository{

  static Future<Account?> fetchProfileInfo(Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>().getRequest(ApiEndPoints.me, query);
    if (response == null) {
      return null;
    }
    return Account.fromJson(response);
  }
}