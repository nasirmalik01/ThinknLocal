import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/api_endpoints.dart';
import 'package:thinknlocal_app/model/account.dart';
import 'package:thinknlocal_app/network/remote_services.dart';
import 'package:get_it/get_it.dart';

class ProfileRemoteRepository {
  static Future<Account?> fetchProfileInfo(Map<String, dynamic> query) async {
    final response =
        await getItLocator<RemoteServices>().getRequest(ApiEndPoints.me, query);
    if (response == null) {
      return null;
    }
    return Account.fromJson(response);
  }

  static Future<Account?> editAccountInfo(Map<String, dynamic> body) async {
    final response = await GetIt.I<RemoteServices>()
        .patchRequest(ApiEndPoints.profile, body);
    if (response == null) {
      return null;
    }
    return Account.fromJson(response);
  }
}
