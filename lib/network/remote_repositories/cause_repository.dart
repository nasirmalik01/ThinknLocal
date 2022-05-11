import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/model/cause_detail.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/model/causes_stats.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get_it/get_it.dart';

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
}