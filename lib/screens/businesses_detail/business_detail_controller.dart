import 'package:flutter/material.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/model/business_detail.dart';
import 'package:flutter_app/model/business_stats.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/network/remote_repository.dart';
import 'package:get/get.dart';

class BusinessDetailController extends GetxController with GetTickerProviderStateMixin{
  late BusinessDetail businessDetail;
  late BusinessStats businessStats;
  List<Causes> recentlyFundedBusinessCausesList = [];
  List<Causes> pastFundedBusinessCausesList = [];
  RxBool isLoading = false.obs;
  RxBool isStatsLoading = false.obs;
  RxBool isBusinessFollowed = false.obs;
  RxBool isRecentlyFundedBusinessCauses = false.obs;
  RxBool isPastFundedBusinessCauses = false.obs;
  TabController? tabController;


  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  getBusinessDetails({required int id}) async {
    isLoading.value = true;
    businessDetail = (await RemoteRepository.fetchBusinessDetails(id, {}))!;
    isLoading.value = false;
  }

  getBusinessStats({required int id}) async {
    isStatsLoading.value = true;
    businessStats = (await RemoteRepository.fetchBusinessStats(id, {}))!;
    isStatsLoading.value = false;
  }

  followBusiness(int id) async {
    if(isBusinessFollowed.value) {
      await RemoteRepository.unFollowBusiness(id);
      isBusinessFollowed.value = false;
    }else{
      await RemoteRepository.followBusiness(id);
      isBusinessFollowed.value = true;
    }
  }

  getRecentlyFundedBusinessCauses({required int id}) async {
    isRecentlyFundedBusinessCauses.value = true;
    recentlyFundedBusinessCausesList = (await RemoteRepository.fetchCauses({
      Strings.businessId: id,
      Strings.recent: true,
    }))!;
    isRecentlyFundedBusinessCauses.value = false;
  }

  getPastFundedBusinessCauses({required int id}) async {
    isPastFundedBusinessCauses.value = true;
    pastFundedBusinessCausesList = (await RemoteRepository.fetchCauses({
      Strings.businessId: id,
      Strings.past: true,
    }))!;
    isPastFundedBusinessCauses.value = false;
  }

}