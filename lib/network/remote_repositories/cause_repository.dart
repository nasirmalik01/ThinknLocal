import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/model/cause_detail.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/model/causes_stats.dart';
import 'package:flutter_app/model/update_causes.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get_it/get_it.dart';

import '../../constants/strings.dart';

class CausesRemoteRepository{
  static Future<List<Causes>?> fetchCauses(Map<String, dynamic> query) async {
    List<Causes> causesList = [];

    /// Passing location parameters
    locationParams(query);

    final response = await GetIt.I<RemoteServices>().getRequest(ApiEndPoints.causes, query);
    if (response == null) {
      return null;
    }

    /// Converting date to readable string
    final List<dynamic> causesDecodeList = response.map((item) => Causes.fromJson(item)).toList();
    for(var causesItem in causesDecodeList){
      final _endDateTime = convertDateToString(dateTime: causesItem.end.toString());
      final _startDateTime = convertDateToString(dateTime: causesItem.start.toString());
      causesItem.end = _endDateTime;
      causesItem.start = _startDateTime;
      causesList.add(causesItem);
    }
    return causesList;
  }

  static Future<CausesStats?> fetchCausesStats(int id, Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>().getRequest('${ApiEndPoints.causes}/$id/stats', query);
    if (response == null) {
      return null;
    }
    return CausesStats.fromJson(response);
  }

  static Future<CauseDetail?> fetchCauseDetails(int id, Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>().getRequest('${ApiEndPoints.causes}/$id', query);
    if (response == null) {
      return null;
    }

    CauseDetail _causeDetail = CauseDetail.fromJson(response);
    final _startDate = convertDateToString(dateTime: _causeDetail.start.toString());
    final _endDate = convertDateToString(dateTime: _causeDetail.end.toString());
    _causeDetail.start = _startDate;
    _causeDetail.end = _endDate;
    return _causeDetail;
  }

  static Future<void> followCause(int id) async {
    await GetIt.I<RemoteServices>().postRequest('${ApiEndPoints.causes}/$id/${ApiEndPoints.follow}', {});
  }

  static Future<void> unFollowCause(int id) async {
    await GetIt.I<RemoteServices>().postRequest('${ApiEndPoints.causes}/$id/${ApiEndPoints.unfollow}', {});
  }

  static Future<List<UpdateCauses>?> fetchUpdatedCauses(int id) async {
    List<UpdateCauses> _updateCauses = [];
    var location = MyHive.getLocation();
    final response = await GetIt.I<RemoteServices>().getRequest('${ApiEndPoints.causes}/$id/${ApiEndPoints.posts}', {
      Strings.latitude: location.latitude,
      Strings.longitude: location.longitude
    });
    if (response == null) {
      return null;
    }

    final List<dynamic> _updatedCausesDecodeList = response.map((item) => UpdateCauses.fromJson(item)).toList();
    for(var updateCausesItem in _updatedCausesDecodeList){
      _updateCauses.add(updateCausesItem);
    }
    return _updateCauses;
  }

}