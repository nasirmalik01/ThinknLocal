import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/model/follows.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get_it/get_it.dart';

class FollowsRemoteRepository{

  static Future<Follows?> fetchFollows() async {
    final response = await GetIt.I<RemoteServices>().getRequest(ApiEndPoints.follows, {});
    if (response == null) {
      return null;
    }
    return Follows.fromJson(response);
  }
}