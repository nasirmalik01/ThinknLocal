import 'dart:developer';

import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/model/business_detail.dart';
import 'package:flutter_app/model/businesses.dart';
import 'package:flutter_app/model/contributions.dart';
import 'package:flutter_app/model/dummy/business.dart';
import 'package:flutter_app/model/dummy/business_stats.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/model/dummy/account.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get_it/get_it.dart';

class RemoteRepository{

  static Future<Account?> fetchProfileInfo(Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>().getRequest(ApiEndPoints.me, query);
    if (response == null) {
      return null;
    }
    return Account.fromJson(response);
  }

  static Future<BusinessStats?> fetchBusinessStats(int id, Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>().getRequest('${ApiEndPoints.businesses}/$id/stats', query);

    if (response == null) {
      return null;
    }
    return BusinessStats.fromJson(response);
  }

  static Future<List<Causes>?> fetchCauses(Map<String, dynamic> query, {bool isEndDate = false}) async {
    List<Causes> causesList = [];
    final response = await GetIt.I<RemoteServices>().getRequest(ApiEndPoints.causes, query);

    if (response == null) {
      return null;
    }

    final List<dynamic> causesDecodeList = response.map((item) => Causes.fromJson(item)).toList();
    for(var causesItem in causesDecodeList){
      final dateTime = convertDateToString(dateTime: isEndDate ? causesItem.end.toString() : causesItem.start.toString());
     if(isEndDate){
       causesItem.end = dateTime;
     }else{
       causesItem.start = dateTime;
     }
      causesList.add(causesItem);
    }

    return causesList;
  }

  static Future<List<Businesses>?> fetchBusinesses(Map<String, dynamic> query) async {
    List<Businesses> businessList = [];
    final response = await GetIt.I<RemoteServices>().getRequest(ApiEndPoints.businesses, query);

    if (response == null) {
      return null;
    }

    // List

    final List<dynamic> _businessDecodeList = response.map((item) => Businesses.fromJson(item)).toList();
    for(var businessItem in _businessDecodeList){
      businessList.add(businessItem);
    }
    return businessList;
  }

  static Future<List<Contributions>?> fetchContributions(Map<String, dynamic> query) async {
    List<Contributions> contributionsList = [];
    final response = await GetIt.I<RemoteServices>().getRequest(ApiEndPoints.contributions, query);
    log('RES: $response');

    if (response == null) {
      return null;
    }

    final List<dynamic> _contributionsDecodeList = response.map((item) => Contributions.fromJson(item)).toList();
    for(var contributionItem in _contributionsDecodeList){
      contributionsList.add(contributionItem);
    }
    return contributionsList;
  }

  static Future<BusinessDetail?> fetchBusinessDetails(int id, Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>().getRequest('${ApiEndPoints.businesses}/$id', query);

    if (response == null) {
      return null;
    }

    BusinessDetail _businessDetail = BusinessDetail.fromJson(response);
    final _dateTime = convertDateToString(dateTime: _businessDetail.createdAt.toString());
    _businessDetail.createdAt = _dateTime;
    return _businessDetail;
  }

}