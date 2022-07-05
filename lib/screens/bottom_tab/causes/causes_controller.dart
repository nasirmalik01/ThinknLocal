import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/config/firebase_dynamic_links.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/enums/cause_request_type.dart';
import 'package:thinknlocal_app/local/my_hive.dart';
import 'package:thinknlocal_app/model/causes.dart';
import 'package:thinknlocal_app/model/cities.dart';
import 'package:thinknlocal_app/network/remote_repositories/cause_repository.dart';
import 'package:thinknlocal_app/network/remote_services.dart';
import 'package:thinknlocal_app/screens/location_search/location_search_controller.dart';
import 'package:get/get.dart';

class CausesController extends GetxController {
  RxBool isFeatured = true.obs;
  RxBool isTrending = false.obs;
  RxBool isFavorites = false.obs;
  RxBool isPast = false.obs;
  RxBool isLocationLoading = false.obs;
  RxBool isUpcomingCausesLoading = false.obs;
  RxBool isRecentlyStartedCausesLoading = false.obs;
  RxBool isTopCausesContainersList = false.obs;
  RxBool isPaginatedLoading = false.obs;
  late List<Causes>? topCausesContainersList = [];
  late List<Causes>? upcomingCauses = [];
  late List<Causes>? recentlyStartedCauses = [];
  List<Cities> citiesList = [];
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxString locationAddress = Strings.noLocation.obs;
  late ScrollController scrollController;
  RxInt pageIndex = 1.obs;
  Rx<CauseRequestType> requestType = CauseRequestType.none.obs;
  RxString selectedCategory = Strings.featured.obs;

  @override
  void onInit() {
    scrollController = ScrollController();
    getLocationAddress();
    getCauses(Strings.featured, page: 1);
    getUpComingCauses();
    FirebaseDynamicApi.initDynamicLinks();
    getRecentlyStartedCauses();
    super.onInit();
  }

  setFeaturedTab() {
    isFeatured.value = true;
    isTrending.value = false;
    isFavorites.value = false;
    isPast.value = false;
    selectedCategory.value = Strings.featured;
    getCauses(Strings.featured);
  }

  setTrendingTab() {
    isFeatured.value = false;
    isTrending.value = true;
    isFavorites.value = false;
    isPast.value = false;
    selectedCategory.value = Strings.trending;
    getCauses(Strings.trending);
  }

  setFavoritesTab() {
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = true;
    isPast.value = false;
    selectedCategory.value = Strings.favorite;
    getCauses(Strings.favorite);
  }

  setPastTab() {
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = false;
    isPast.value = true;
    selectedCategory.value = Strings.past;
    getCauses(Strings.past);
  }

  getCauses(String selectedTab, {bool isPagination = false, int page = 1}) async {
    if (isPagination) {
      List<Causes>? paginatedList = await handleCausePagination(selectedTab);
      if (paginatedList != null) {
        topCausesContainersList!.addAll(paginatedList);
      }
    }
    else {
      isTopCausesContainersList.value = true;
      topCausesContainersList = await (CausesRemoteRepository.fetchCauses({
        selectedTab: true,
        Strings.page: page,
      },
      ));
    }
    if (RemoteServices.statusCode != 200 &&
        RemoteServices.statusCode != 201 &&
        RemoteServices.statusCode != 204) {
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
    if (isPagination) {
      List<Causes>? paginatedList =
          await handleCausePagination(Strings.upcoming);
      if (paginatedList != null) {
        upcomingCauses!.addAll(paginatedList);
      }
    } else {
      isUpcomingCausesLoading.value = true;
      upcomingCauses = await (CausesRemoteRepository.fetchCauses({
        Strings.upcoming: true,
      }));
    }
    isUpcomingCausesLoading.value = false;
  }

  getRecentlyStartedCauses({bool isPagination = false, int page = 1}) async {
    if (isPagination) {
      List<Causes>? paginatedList = await handleCausePagination(Strings.recent);
      if (paginatedList != null) {
        recentlyStartedCauses!.addAll(paginatedList);
      }
    } else {
      isRecentlyStartedCausesLoading.value = true;
      recentlyStartedCauses = await (CausesRemoteRepository.fetchCauses(
          {Strings.recent: true, Strings.page: page}));
    }
    isRecentlyStartedCausesLoading.value = false;
  }



  getLocationAddress() async {
    final LocationSearchController _locationSearchController =
        Get.find<LocationSearchController>();
    _locationSearchController.locationAddress.value =
        MyHive.getLocationAddress();
  }



  Future<void> setPagination({bool isFirst = false}) async {
    if (isFirst) {
      pageIndex.value = 1;
      update();
    }
    // ignore: invalid_use_of_protected_member
    if (scrollController.hasListeners == false) {
      scrollController.addListener(() async {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (RemoteServices.isNextPage == true) {
            pageIndex.value = pageIndex.value + 1;
            log('Index : ${pageIndex.value}');
            String _selectedCategory = getSelectedCategory();
            switch (requestType.value) {
              case CauseRequestType.causes:
                getCauses(_selectedCategory, isPagination: true);
                break;
              case CauseRequestType.upcoming:
                getUpComingCauses(isPagination: true);
                break;
              case CauseRequestType.recent:
                getRecentlyStartedCauses(isPagination: true);
                break;
              default:
                break;
            }
          }
        }
      });
    }
  }

  Future<List<Causes>?> handleCausePagination(String selectedTab) async {
    isPaginatedLoading.value = true;
    showLoadingDialog(message: Strings.loadingMoreData);
    List<Causes>? _paginatedList = [];
    _paginatedList = await (CausesRemoteRepository.fetchCauses(
      {selectedTab: true, Strings.page: pageIndex.value},
    ));
    Get.back();
    isPaginatedLoading.value = false;
    return _paginatedList;
  }

  String getSelectedCategory() {
    if (isFeatured.value == true) {
      selectedCategory.value = Strings.featured;
    } else if (isTrending.value == true) {
      selectedCategory.value = Strings.trending;
    } else if (isFavorites.value == true) {
      selectedCategory.value = Strings.favorites;
    } else {
      selectedCategory.value = Strings.past;
    }
    return selectedCategory.value;
  }

}
