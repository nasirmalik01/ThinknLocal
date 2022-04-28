import 'package:flutter_app/model/Causess.dart';
import 'package:flutter_app/model/account.dart';
import 'package:flutter_app/model/business_stats.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get_it/get_it.dart';

class RemoteRepository{

  static Future<Account?> fetchProfileInfo(Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>().getRequest('me', query);
    if (response == null) {
      return null;
    }
    return Account.fromJson(response);
  }

  static Future<BusinessStats?> fetchBusinessStats(Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>().getRequest('businesses/23/stats', query);

    if (response == null) {
      return null;
    }
    return BusinessStats.fromJson(response);
  }

  static Future<Causess?> fetchCauses(Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>().getRequest('causes', {});

    if (response == null) {
      return null;
    }
    return Causess.fromJson(response);
  }
}