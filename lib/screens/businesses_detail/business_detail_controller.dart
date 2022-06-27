import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/common/utils.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/model/business_detail.dart';
import 'package:thinknlocal_app/model/business_stats.dart';
import 'package:thinknlocal_app/model/causes.dart';
import 'package:thinknlocal_app/model/chart_stats_model.dart';
import 'package:thinknlocal_app/model/follows.dart';
import 'package:thinknlocal_app/network/remote_repositories/business_repository.dart';
import 'package:thinknlocal_app/network/remote_repositories/cause_repository.dart';
import 'package:thinknlocal_app/network/remote_repositories/follows_repository.dart';
import 'package:thinknlocal_app/network/remote_services.dart';
import 'package:get/get.dart';

class BusinessDetailController extends GetxController
    with GetTickerProviderStateMixin {
  BusinessDetail? businessDetail;
  late BusinessStats? businessStats;
  List<Causes>? recentlyFundedBusinessCausesList = [];
  List<Causes>? pastFundedBusinessCausesList = [];
  List<bool> isCauseFollowed = [];
  Follows? follows;
  RxBool isLoading = false.obs;
  RxBool isStatsLoading = false.obs;
  RxBool isBusinessFollowed = false.obs;
  RxBool isRecentlyFundedBusinessCauses = false.obs;
  RxBool isPastFundedBusinessCauses = false.obs;
  TabController? tabController;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  List<ChartData> businessStatsHistory = <ChartData>[];
  final bool _isUserAuthenticated = PreferenceUtils.isUserAuthenticated();


  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  getBusinessDetails({required int id}) async {
    isLoading.value = true;
    businessDetail =
        (await BusinessRemoteRepository.fetchBusinessDetails(id, {}));
    if (RemoteServices.statusCode != 200 &&
        RemoteServices.statusCode != 201 &&
        RemoteServices.statusCode != 204) {
      isError.value = true;
      isLoading.value = false;
      isStatsLoading.value = false;
      isRecentlyFundedBusinessCauses.value = false;
      isStatsLoading.value = false;
      isPastFundedBusinessCauses.value = false;
      isPastFundedBusinessCauses.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
    isLoading.value = false;
  }

  getBusinessStats({required int id}) async {
    isStatsLoading.value = true;
    businessStats = (await BusinessRemoteRepository.fetchBusinessStats(id, {}));
    if (businessStats?.history?.isNotEmpty ?? false) {
      businessStatsHistory.clear();
      for (var item in businessStats!.history!) {
        List<String> splitDate = item.date!.split(' ');
        item.date = splitDate[0];
        businessStatsHistory.add(ChartData(item.date!, item.amount));
      }
    }
    update(['businessBuilder']);
    isStatsLoading.value = false;
  }

  followBusiness(int id) async {
    if (isBusinessFollowed.value) {
      isBusinessFollowed.value = false;
      await BusinessRemoteRepository.unFollowBusiness(id);
    }else{
      if(_isUserAuthenticated) {
        isBusinessFollowed.value = true;
        await BusinessRemoteRepository.followBusiness(id);
      }
      else{
         userNotLoggedIn();
      }
    }
  }

  getRecentlyFundedBusinessCauses({required int id}) async {
    isRecentlyFundedBusinessCauses.value = true;
    recentlyFundedBusinessCausesList =
        (await CausesRemoteRepository.fetchCauses({
      Strings.businessId: id,
      Strings.recent: true,
    }));
    if(_isUserAuthenticated){
      List<int> followCauseIds = [];
      follows = await FollowsRemoteRepository.fetchFollows();
      for(var cause in follows!.causes!){
        followCauseIds.add(cause);
      }
      for(var _recentlyFundedBusiness in recentlyFundedBusinessCausesList!){
        for(int i=0; i<followCauseIds.length; i++){
          if(_recentlyFundedBusiness.id.toString().contains(followCauseIds[i].toString())){
            _recentlyFundedBusiness.isFavorite = true;
          }
        }
      }
    }
    isRecentlyFundedBusinessCauses.value = false;
  }

  getPastFundedBusinessCauses({required int id}) async {
    isPastFundedBusinessCauses.value = true;
    pastFundedBusinessCausesList = (await CausesRemoteRepository.fetchCauses({
      Strings.businessId: id,
      Strings.past: true,
    }));
    isPastFundedBusinessCauses.value = false;
  }

  getFollowBusiness({required int id}) async {
    isBusinessFollowed.value = false;
    follows = await FollowsRemoteRepository.fetchFollows();
    for (var business in follows!.businesses!) {
      if (business.toString().contains(id.toString())) {
        isBusinessFollowed.value = true;
      }
    }
  }

  followCauses(int id, bool isFollowed) async {
    if (isFollowed) {
      await CausesRemoteRepository.unFollowCause(id);
    }else{
      if(_isUserAuthenticated){
        await CausesRemoteRepository.followCause(id);
      }
      else{
        userNotLoggedIn();
      }
    }
  }
}
