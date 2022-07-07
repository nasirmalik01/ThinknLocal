import 'dart:async';

import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/api_endpoints.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/local/my_hive.dart';
import 'package:thinknlocal_app/model/business_category.dart';
import 'package:thinknlocal_app/model/business_category_parent_type.dart';
import 'package:thinknlocal_app/model/business_detail.dart';
import 'package:thinknlocal_app/model/business_stats.dart';
import 'package:thinknlocal_app/model/businesses.dart';
import 'package:thinknlocal_app/network/remote_services.dart';

class BusinessRemoteRepository {
  static Future<List<Businesses>?> fetchBusinesses(Map<String, dynamic>? query) async {
    List<Businesses> businessList = [];
    locationParams(query!);
    final response = await getItLocator<RemoteServices>().getRequest(ApiEndPoints.businesses, query);
    if (response == null) {
      return null;
    }
    final List<dynamic> _businessDecodeList =
        response.map((item) => Businesses.fromJson(item)).toList();
    for (var businessItem in _businessDecodeList) {
      businessList.add(businessItem);
    }
    return businessList;
  }

  static Future<BusinessStats?> fetchBusinessStats(int id, Map<String, dynamic>? query) async {
      locationParams(query!);

    final response = await getItLocator<RemoteServices>().getRequest('${ApiEndPoints.businesses}/$id/${ApiEndPoints.stats}', query);
    if (response == null) {
      return null;
    }
    return BusinessStats.fromJson(response);
  }

  static Future<BusinessDetail?> fetchBusinessDetails(
      int id, Map<String, dynamic> query) async {
      locationParams(query);

    final response = await getItLocator<RemoteServices>().getRequest('${ApiEndPoints.businesses}/$id', query);

    if (response == null) {
      return null;
    }

    BusinessDetail _businessDetail = BusinessDetail.fromJson(response);
    final _dateTime =
        convertDateToString(dateTime: _businessDetail.createdAt.toString());
    _businessDetail.createdAt = _dateTime;
    return _businessDetail;
  }

  static Future<bool> followBusiness(int id) async {
    var completer = Completer<bool>();
    var result = await getItLocator<RemoteServices>().postRequest(
        '${ApiEndPoints.businesses}/$id/${ApiEndPoints.follow}', {});
    if (result == null) {
      completer.complete(false);
    } else {
      completer.complete(true);
    }
    return completer.future;
  }

  static Future<bool> unFollowBusiness(int id) async {
    var completer = Completer<bool>();
    var result = await getItLocator<RemoteServices>().postRequest(
        '${ApiEndPoints.businesses}/$id/${ApiEndPoints.unfollow}', {});
    if (result == null) {
      completer.complete(false);
    } else {
      completer.complete(true);
    }
    return completer.future;
  }

  static Future<List<BusinessCategoryModel>?> fetchBusinessCategories({required Map<String, dynamic> query}) async {
    List<BusinessCategoryModel> businessCategoryList = [];
    var location = MyHive.getLocation();
    var cityId = MyHive.getCityId();

    final response = await getItLocator<RemoteServices>().getRequest(ApiEndPoints.categories, {
      Strings.latitude: location.latitude,
      Strings.longitude: location.longitude,
      Strings.cityId: cityId
    });
    if (response == null) {
      return null;
    }
    final List<dynamic> _businessCategoryDecodeList = response.map((item) => BusinessCategoryModel.fromJson(item)).toList();
    for (var businessCategoryItem in _businessCategoryDecodeList) {
      businessCategoryList.add(businessCategoryItem);
    }
    return businessCategoryList;
  }

  static Future<List<BusinessCategoryParentType>?> fetchBusinessParentTypeCategories() async {
    List<BusinessCategoryParentType> businessCategoryList = [];
    var location = MyHive.getLocation();
    var cityId = MyHive.getCityId();


    final response = await getItLocator<RemoteServices>().getRequest(ApiEndPoints.categories, {
          Strings.parents: true,
          Strings.type: 'business',
          Strings.latitude: location.latitude,
          Strings.longitude: location.longitude,
          Strings.cityId: cityId
        });
    if (response == null) {
      return null;
    }
    final List<dynamic> _businessCategoryDecodeList = response
        .map((item) => BusinessCategoryParentType.fromJson(item))
        .toList();
    for (var businessCategoryItem in _businessCategoryDecodeList) {
      businessCategoryList.add(businessCategoryItem);
    }
    return businessCategoryList;
  }
}
