import 'package:dio/dio.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/model/business_detail.dart';
import 'package:flutter_app/model/business_stats.dart';
import 'package:flutter_app/model/businesses.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get_it/get_it.dart';

class BusinessRemoteRepository{
  static Future<List<Businesses>?> fetchBusinesses(Map<String, dynamic> query) async {
    List<Businesses> businessList = [];
    locationParams(query);
    final response = await GetIt.I<RemoteServices>().getRequest(ApiEndPoints.businesses, query);
    if (response == null) {
      return null;
    }
    final List<dynamic> _businessDecodeList = response.map((item) => Businesses.fromJson(item)).toList();
    for(var businessItem in _businessDecodeList){
      businessList.add(businessItem);
    }
    return businessList;
  }

  static Future<BusinessStats?> fetchBusinessStats(int id, Map<String, dynamic> query) async {
    locationParams(query);
    final response = await GetIt.I<RemoteServices>().getRequest('${ApiEndPoints.businesses}/$id/${ApiEndPoints.stats}', query);
    if (response == null) {
      return null;
    }
    return BusinessStats.fromJson(response);
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

  static Future<void> followBusiness(int id) async {
    await GetIt.I<RemoteServices>().postRequest('${ApiEndPoints.businesses}/$id/${ApiEndPoints.follow}', {});
  }

  static Future<void> unFollowBusiness(int id) async {
    await GetIt.I<RemoteServices>().postRequest('${ApiEndPoints.businesses}/$id/${ApiEndPoints.unfollow}', {});
  }
}