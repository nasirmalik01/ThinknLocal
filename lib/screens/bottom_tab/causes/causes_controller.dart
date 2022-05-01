import 'package:flutter_app/model/causess.dart';
import 'package:flutter_app/network/remote_repository.dart';
import 'package:get/get.dart';

class CausesController extends GetxController{
  RxBool isFeatured = true.obs;
  RxBool isTrending = false.obs;
  RxBool isFavorites = false.obs;
  RxBool isPast = false.obs;
  RxBool isUpcomingCausesLoading = false.obs;
  RxBool isRecentlyStartedCausesLoading = false.obs;
  RxBool isTopCausesContainersList = false.obs;
  late List<Causes>? topCausesContainersList = [];
  late List<Causes>? upcomingCauses = [];
  late List<Causes>? recentlyStartedCauses = [];


  @override
  void onInit() {
    getTopCausesContainersList('featured');
    getUpComingCauses('featured');
    getRecentlyStartedCauses('featured');
    super.onInit();
  }

  setFeaturedTab(){
    isFeatured.value = true;
    isTrending.value = false;
    isFavorites.value = false;
    isPast.value = false;
    getTopCausesContainersList('featured');
    getUpComingCauses('featured');
    getRecentlyStartedCauses('featured');
  }

  setTrendingTab(){
    isFeatured.value = false;
    isTrending.value = true;
    isFavorites.value = false;
    isPast.value = false;
    getTopCausesContainersList('trending');
    getUpComingCauses('trending');
    getRecentlyStartedCauses('trending');
  }

  setFavoritesTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = true;
    isPast.value = false;
    getTopCausesContainersList('favorites');
    getUpComingCauses('favorites');
    getRecentlyStartedCauses('favorites');
  }

  setPostTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = false;
    isPast.value = true;
    getTopCausesContainersList('past');
    getUpComingCauses('past');
    getRecentlyStartedCauses('past');
  }

  getTopCausesContainersList(String selectedTab) async {
    isTopCausesContainersList.value = true;
    topCausesContainersList =  await (RemoteRepository.fetchCauses({
      selectedTab : true,
      'recent': true
    },
        isEndDate: true
    ));
    isTopCausesContainersList.value = false;
  }

  getUpComingCauses(String selectedTab) async {
    isUpcomingCausesLoading.value = true;
    upcomingCauses =  await (RemoteRepository.fetchCauses({
      selectedTab : true,
      'upcoming': ''
    }));
    isUpcomingCausesLoading.value = false;
  }

  getRecentlyStartedCauses(String selectedTab) async {
    isRecentlyStartedCausesLoading.value = true;
    recentlyStartedCauses =  await (RemoteRepository.fetchCauses({
      selectedTab : true,
      'recent': true,
    }));
    isRecentlyStartedCausesLoading.value = false;
  }


}