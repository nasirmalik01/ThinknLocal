import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/enums/business_request_type.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/model/businesses.dart';
import 'package:flutter_app/network/remote_repositories/business_repository.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:flutter_app/screens/location_search/location_search_controller.dart';
import 'package:get/get.dart';

class BusinessesController extends GetxController{
  RxBool isFeatured = true.obs;
  RxBool isTrending = false.obs;
  RxBool isFavorites = false.obs;
  RxBool isPast = false.obs;
  RxBool isBusinessLoading = false.obs;
  RxBool isRecentlyAddedBusinessLoading = false.obs;
  RxBool isNearByBusinessLoading = false.obs;
  RxBool isPaginatedLoading = false.obs;
  List<Businesses>? businessList = [];
  List<Businesses>? recentlyAddedBusinessList = [];
  RxString locationAddress = Strings.noLocation.obs;
  List<Businesses>? nearbyBusinessList = [];
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  late ScrollController scrollController;
  RxInt pageIndex = 1.obs;
  Rx<BusinessRequestType> requestType = BusinessRequestType.none.obs;
  RxString selectedCategory = Strings.featured.obs;

  @override
  void onInit() {
    scrollController = ScrollController();
    getLocationAddress();
    getBusinesses(Strings.featured);
    getRecentlyAddedBusinesses();
    getNearbyBusinesses();
    super.onInit();
  }

  setFeaturedTab(){
    isFeatured.value = true;
    isTrending.value = false;
    isFavorites.value = false;
    isPast.value = false;
    selectedCategory.value = Strings.featured;
    getBusinesses(Strings.featured);
  }

  setTrendingTab(){
    isFeatured.value = false;
    isTrending.value = true;
    isFavorites.value = false;
    isPast.value = false;
    selectedCategory.value = Strings.trending;
    getBusinesses(Strings.trending);
  }

  setFavoritesTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = true;
    isPast.value = false;
    selectedCategory.value = Strings.favorite;
    getBusinesses(Strings.favorite);
  }

  setPastTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = false;
    isPast.value = true;
    getBusinesses(Strings.past);
  }

  getBusinesses(String selectedTab, {bool isPagination = false, int page = 1}) async {
    if(isPagination){
      List<Businesses>? paginatedList = await handleBusinessPagination(selectedTab);
      if(paginatedList!=null) {
        businessList!.addAll(paginatedList);
      }
    }else {
      isBusinessLoading.value = true;
      businessList = await (BusinessRemoteRepository.fetchBusinesses({
        selectedTab: true,
        Strings.page: page
      }));
    }
    if(RemoteServices.statusCode != 200 && RemoteServices.statusCode != 201 && RemoteServices.statusCode != 204){
      isError.value = true;
      isBusinessLoading.value = false;
      isRecentlyAddedBusinessLoading.value = false;
      isNearByBusinessLoading.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
    isBusinessLoading.value = false;
  }

  getRecentlyAddedBusinesses({bool isPagination = false, int page = 1}) async {
    if(isPagination){
      List<Businesses>? paginatedList = await handleBusinessPagination(Strings.recent);
      if(paginatedList!=null) {
        recentlyAddedBusinessList!.addAll(paginatedList);
      }
    }else {
      isRecentlyAddedBusinessLoading.value = true;
      recentlyAddedBusinessList = await (BusinessRemoteRepository.fetchBusinesses({
        Strings.recent: true,
        Strings.page: page
      }));
    }
    isRecentlyAddedBusinessLoading.value = false;
  }

  getNearbyBusinesses({bool isPagination = false, int page = 1}) async {
    if(isPagination){
      List<Businesses>? paginatedList = await handleBusinessPagination(Strings.nearby);
      if(paginatedList!=null) {
        nearbyBusinessList!.addAll(paginatedList);
      }
    }else {
      isNearByBusinessLoading.value = true;
      nearbyBusinessList = await (BusinessRemoteRepository.fetchBusinesses({
        Strings.nearby: true,
        Strings.page: page
      }));
    }
    isNearByBusinessLoading.value = false;
  }

  getLocationAddress() async {
    final LocationSearchController _locationSearchController = Get.find<LocationSearchController>();
    _locationSearchController.locationAddress.value = MyHive.getLocationAddress();
  }

  Future<void> setPagination({bool isFirst = false,}) async{
    if(isFirst){
      pageIndex.value = 1;
      update();
    }
    // ignore: invalid_use_of_protected_member
    if (scrollController.hasListeners == false) {
      scrollController.addListener(() async {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          if(RemoteServices.isNextPage == true) {
            pageIndex.value = pageIndex.value + 1;
            log('Index : ${pageIndex.value}');
            String _selectedCategory = getSelectedCategory();
            switch(requestType.value){
              case BusinessRequestType.business:
                 getBusinesses(_selectedCategory, isPagination: true);
                break;
              case BusinessRequestType.recent:
                getRecentlyAddedBusinesses(isPagination: true);
                break;
              case BusinessRequestType.nearby:
                getNearbyBusinesses(isPagination: true);
                break;
              default:break;
            }
          }
        }
      });
    }
  }

  Future<List<Businesses>?> handleBusinessPagination(String selectedTab) async{
    isPaginatedLoading.value = true;
    showLoadingDialog(message: Strings.loadingMoreData);
    List<Businesses>? _paginatedList = [];
    _paginatedList = await (BusinessRemoteRepository.fetchBusinesses({
      selectedTab: true,
      Strings.page: pageIndex.value
    },));
    Get.back();
    isPaginatedLoading.value = false;
    return _paginatedList;
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