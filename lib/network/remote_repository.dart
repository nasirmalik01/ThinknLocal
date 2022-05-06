import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/model/causess.dart';
import 'package:flutter_app/model/account.dart';
import 'package:flutter_app/model/business_stats.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get_it/get_it.dart';

class RemoteRepository{

  static Future<Account?> fetchProfileInfo(Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>().getRequest(me, query);
    if (response == null) {
      return null;
    }
    return Account.fromJson(response);
  }

  static Future<BusinessStats?> fetchBusinessStats(Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>().getRequest(businessStats, query);

    if (response == null) {
      return null;
    }
    return BusinessStats.fromJson(response);
  }

  static Future<List<Causes>?> fetchCauses(Map<String, dynamic> query, {bool isEndDate = false}) async {
    List<Causes> causesList = [];
    final response = await GetIt.I<RemoteServices>().getRequest(causes, query);

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

  static Future<List<Causes>?> fetchBusinesses(Map<String, dynamic> query, {bool isEndDate = false}) async {
    List<Causes> causesList = [];
    final response = await GetIt.I<RemoteServices>().getRequest(businesses, query);

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
}