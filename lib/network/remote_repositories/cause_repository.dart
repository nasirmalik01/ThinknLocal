import 'dart:async';

import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/model/cause_advertisement.dart';
import 'package:flutter_app/model/cause_detail.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/model/causes_stats.dart';
import 'package:flutter_app/model/update_causes.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get_it/get_it.dart';

class CausesRemoteRepository {
  static Future<List<Causes>?> fetchCauses(Map<String, dynamic>? query) async {
    List<Causes> causesList = [];

    /// Passing location parameters
    if (query == null) {
      /// Works in test cases
      locationParams(query!);
    }else{
      /// Works in app flow
      locationParams(query);
    }

    final response = await getItLocator<RemoteServices>().getRequest(ApiEndPoints.causes, query);
    if (response == null) {
      return null;
    }

    /// Converting date to readable string
    final List<dynamic> causesDecodeList =
        response.map((item) => Causes.fromJson(item)).toList();
    for (var causesItem in causesDecodeList) {
      final _endDateTime =
          convertDateToString(dateTime: causesItem.end.toString());
      final _startDateTime =
          convertDateToString(dateTime: causesItem.start.toString());
      causesItem.end = _endDateTime;
      causesItem.start = _startDateTime;
      causesList.add(causesItem);
    }
    return causesList;
  }

  static Future<CausesStats?> fetchCausesStats(
      int id, Map<String, dynamic> query) async {
    final response = await getItLocator<RemoteServices>()
        .getRequest('${ApiEndPoints.causes}/$id/stats', query);
    if (response == null) {
      return null;
    }
    return CausesStats.fromJson(response);
  }

  static Future<CauseDetail?> fetchCauseDetails(
      int id, Map<String, dynamic> query) async {
    final response = await getItLocator<RemoteServices>()
        .getRequest('${ApiEndPoints.causes}/$id', query);
    if (response == null) {
      return null;
    }

    CauseDetail _causeDetail = CauseDetail.fromJson(response);
    final _startDate =
        convertDateToString(dateTime: _causeDetail.start.toString());
    final _endDate = convertDateToString(dateTime: _causeDetail.end.toString());
    _causeDetail.start = _startDate;
    _causeDetail.end = _endDate;
    return _causeDetail;
  }

  static Future<bool> followCause(int id) async {
    var completer = Completer<bool>();
    var result = await getItLocator<RemoteServices>()
        .postRequest('${ApiEndPoints.causes}/$id/${ApiEndPoints.follow}', {});
    if (result == null) {
      completer.complete(false);
    } else {
      completer.complete(true);
    }
    return completer.future;
  }

  static Future<bool> unFollowCause(int id) async {
    var completer = Completer<bool>();
    var result = await getItLocator<RemoteServices>()
        .postRequest('${ApiEndPoints.causes}/$id/${ApiEndPoints.unfollow}', {});
    if (result == null) {
      completer.complete(false);
    } else {
      completer.complete(true);
    }
    return completer.future;
  }

  static Future<List<CauseAdvertisement>?> fetchCauseAdvertisements(
      int id) async {
    List<CauseAdvertisement> _causeAdvertisements = [];
    var location = MyHive.getLocation();
    final response = await GetIt.I<RemoteServices>().getRequest(
        '${ApiEndPoints.causes}/$id/${ApiEndPoints.advertisements}', {
      Strings.latitude: location.latitude,
      Strings.longitude: location.longitude,
      Strings.corporate: true
    });
    if (response == null) {
      return null;
    }

    final List<dynamic> _causeAdvertisementsList =
        response.map((item) => CauseAdvertisement.fromJson(item)).toList();
    for (var _causeAdvertisementItem in _causeAdvertisementsList) {
      _causeAdvertisements.add(_causeAdvertisementItem);
    }
    return _causeAdvertisements;
  }

  static Future<List<UpdateCauses>?> fetchUpdatedCauses(int id) async {
    List<UpdateCauses> _updateCauses = [];
    var location = MyHive.getLocation();
    final response = await GetIt.I<RemoteServices>().getRequest(
        '${ApiEndPoints.causes}/$id/${ApiEndPoints.posts}', {
      Strings.latitude: location.latitude,
      Strings.longitude: location.longitude
    });
    if (response == null) {
      return null;
    }

    final List<dynamic> _updatedCausesDecodeList =
        response.map((item) => UpdateCauses.fromJson(item)).toList();
    for (var updateCausesItem in _updatedCausesDecodeList) {
      _updateCauses.add(updateCausesItem);
    }
    return _updateCauses;
  }
}
