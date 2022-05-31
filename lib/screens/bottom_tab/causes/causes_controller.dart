import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/config/push_notification_config.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/model/cities.dart';
import 'package:flutter_app/network/remote_repositories/cause_repository.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';

class CausesController extends GetxController{
  RxBool isFeatured = true.obs;
  RxBool isTrending = false.obs;
  RxBool isFavorites = false.obs;
  RxBool isPast = false.obs;
  RxBool isLocationLoading = false.obs;
  RxBool isUpcomingCausesLoading = false.obs;
  RxBool isRecentlyStartedCausesLoading = false.obs;
  RxBool isTopCausesContainersList = false.obs;
  RxBool isPaginatedLoading = false.obs;
  RxBool isNoMoreData = false.obs;
  late List<Causes>? topCausesContainersList = [];
  late List<Causes>? upcomingCauses = [];
  late List<Causes>? recentlyStartedCauses = [];
  List<Cities> citiesList = [];
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxString locationAddress = Strings.noLocation.obs;
  late ScrollController scrollController;
  RxInt pageIndex = 1.obs;


  @override
  void onInit() {
    scrollController = ScrollController();
    getLocationAddress();
    initDynamicLinks();
    getCauses(Strings.featured, page: 1);
    getUpComingCauses();
    getRecentlyStartedCauses();
    PushNotificationConfig.handleForeGroundPushNotifications();
    super.onInit();
  }

  setFeaturedTab(){
    isFeatured.value = true;
    isTrending.value = false;
    isFavorites.value = false;
    isPast.value = false;
    getCauses(Strings.featured);
  }

  setTrendingTab(){
    isFeatured.value = false;
    isTrending.value = true;
    isFavorites.value = false;
    isPast.value = false;
    getCauses(Strings.trending);
  }

  setFavoritesTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = true;
    isPast.value = false;
    getCauses(Strings.favorites);
  }

  setPastTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = false;
    isPast.value = true;
    getCauses(Strings.past);
  }

  getCauses(String selectedTab, {bool isPagination = false, int page = 1}) async {
    if(isPagination){
      handleCausePagination(selectedTab);
    } else {
      isTopCausesContainersList.value = true;
      isNoMoreData.value = false;
      topCausesContainersList =  await (CausesRemoteRepository.fetchCauses({
      selectedTab : true,
      Strings.page: page
    },));
    }
    if(RemoteServices.statusCode != 200 && RemoteServices.statusCode != 201 && RemoteServices.statusCode != 204){
      isError.value = true;
      isTopCausesContainersList.value = false;
      isUpcomingCausesLoading.value = false;
      isRecentlyStartedCausesLoading.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
    isTopCausesContainersList.value = false;
  }

  getUpComingCauses({bool isPagination = false, int page = 1}) async {
    if(isPagination){
      handleCausePagination(Strings.upcoming);
    }else {
      isUpcomingCausesLoading.value = true;
      upcomingCauses = await (CausesRemoteRepository.fetchCauses({
        Strings.upcoming: true,
      }));
    }
    isUpcomingCausesLoading.value = false;
  }

  getRecentlyStartedCauses({bool isPagination = false, int page = 1}) async {
    if(isPagination){
      handleCausePagination(Strings.recent);
    }else {
      isRecentlyStartedCausesLoading.value = true;
      recentlyStartedCauses = await (CausesRemoteRepository.fetchCauses({
        Strings.recent: true,
        Strings.page: page
      }));
    }
    isRecentlyStartedCausesLoading.value = false;
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri? deeplink = dynamicLinkData.link;

      if (deeplink != null) {
        handleDynamicLink(deeplink);
      }
    }).onError((error) {});
    final pendingDynamicLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if(pendingDynamicLink != null) {
      handleDynamicLink(pendingDynamicLink.link);
    }
  }

  getLocationAddress() async {
     Cities? _lowestDistanceCity = await getLowestDistanceCity();
     locationAddress.value = _lowestDistanceCity?.name ?? Strings.noLocation;
  }

  void handleDynamicLink(Uri url) {
    List<String> _splitDynamicLink = [];
    _splitDynamicLink.addAll(url.path.split('/'));
    String _category = _splitDynamicLink[1];
    if(_category == Strings.causes){
      Get.toNamed(Routes.causesDetailScreen, arguments: int.parse(_splitDynamicLink[2]));
    }else{
      Get.toNamed(Routes.businessDetailScreen, arguments: int.parse(_splitDynamicLink[2]));
    }
  }

  Future<void> setPagination({bool isFirst = false, bool isCauses = false, String? paramValue}) async{
    if(isFirst){
      pageIndex.value = 1;
    }
      // ignore: invalid_use_of_protected_member
    if (scrollController.hasListeners == false) {
          scrollController.addListener(() async {
            if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
              if(isNoMoreData.value == false) {
                pageIndex.value = pageIndex.value + 1;
                log('Index : ${pageIndex.value}');
                String _selectedCategory = getSelectedCategory();
                getCauses(isCauses ? _selectedCategory : paramValue!, isPagination: true);
            }
          }
        });
    }
  }

  handleCausePagination(String selectedTab) async{
    isPaginatedLoading.value = true;
    showLoadingDialog(message: Strings.loadingMoreData);
    List<Causes>? _paginatedList = [];
    _paginatedList = await (CausesRemoteRepository.fetchCauses({
      selectedTab: true,
      Strings.page: pageIndex.value
    },));
    if(RemoteServices.statusCode == 500){
      isNoMoreData.value = true;
    }
    Get.back();
    if(_paginatedList!=null) {
      topCausesContainersList!.addAll(_paginatedList);
    }
    isPaginatedLoading.value = false;
  }

  String getSelectedCategory(){
    String _selectedCategory = Strings.featured;
    if(isFeatured.value){
      _selectedCategory = Strings.featured;
    }
    else if(isTrending.value){
      _selectedCategory = Strings.trending;
    }
    else if(isFavorites.value){
      _selectedCategory = Strings.favorites;
    }
    else{
      _selectedCategory = Strings.past;
    }
    return _selectedCategory;
  }
}