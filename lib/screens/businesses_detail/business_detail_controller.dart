import 'package:flutter/material.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/model/business_detail.dart';
import 'package:flutter_app/model/business_stats.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/network/remote_repositories/business_repository.dart';
import 'package:flutter_app/network/remote_repositories/cause_repository.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';

class BusinessDetailController extends GetxController with GetTickerProviderStateMixin{
  BusinessDetail? businessDetail;
  late BusinessStats? businessStats;
  List<Causes>? recentlyFundedBusinessCausesList = [];
  List<Causes>? pastFundedBusinessCausesList = [];
  RxBool isLoading = false.obs;
  RxBool isStatsLoading = false.obs;
  RxBool isBusinessFollowed = false.obs;
  RxBool isRecentlyFundedBusinessCauses = false.obs;
  RxBool isPastFundedBusinessCauses = false.obs;
  TabController? tabController;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;


  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  getBusinessDetails({required int id}) async {
    isLoading.value = true;
    businessDetail = (await BusinessRemoteRepository.fetchBusinessDetails(id, {}));
    if(RemoteServices.statusCode != 200 && RemoteServices.statusCode != 201 && RemoteServices.statusCode != 204){
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
    isStatsLoading.value = false;
  }

  followBusiness(int id) async {
    if(isBusinessFollowed.value) {
      await BusinessRemoteRepository.unFollowBusiness(id);
      isBusinessFollowed.value = false;
    }else{
      await BusinessRemoteRepository.followBusiness(id);
      isBusinessFollowed.value = true;
    }
  }

  getRecentlyFundedBusinessCauses({required int id}) async {
    isRecentlyFundedBusinessCauses.value = true;
    recentlyFundedBusinessCausesList = (await CausesRemoteRepository.fetchCauses({
      Strings.businessId: id,
      Strings.recent: true,
    }));
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

}