import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/model/causes.dart';
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
    getCauses(Strings.featured);
    getUpComingCauses(Strings.featured);
    getRecentlyStartedCauses(Strings.featured);
    super.onInit();
  }

  setFeaturedTab(){
    isFeatured.value = true;
    isTrending.value = false;
    isFavorites.value = false;
    isPast.value = false;
    getCauses(Strings.featured);
    getUpComingCauses(Strings.featured);
    getRecentlyStartedCauses(Strings.featured);
  }

  setTrendingTab(){
    isFeatured.value = false;
    isTrending.value = true;
    isFavorites.value = false;
    isPast.value = false;
    getCauses(Strings.trending);
    getUpComingCauses(Strings.trending);
    getRecentlyStartedCauses(Strings.trending);
  }

  setFavoritesTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = true;
    isPast.value = false;
    getCauses(Strings.favorites);
    getUpComingCauses(Strings.favorites);
    getRecentlyStartedCauses(Strings.favorites);
  }

  setPostTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = false;
    isPast.value = true;
    getCauses(Strings.past);
    getUpComingCauses(Strings.past);
    getRecentlyStartedCauses(Strings.past);
  }

  getCauses(String selectedTab) async {
    isTopCausesContainersList.value = true;
    topCausesContainersList =  await (RemoteRepository.fetchCauses({
      selectedTab : true,
      Strings.recent: true
    },
        isEndDate: true
    ));
    isTopCausesContainersList.value = false;
  }

  getUpComingCauses(String selectedTab) async {
    isUpcomingCausesLoading.value = true;
    upcomingCauses =  await (RemoteRepository.fetchCauses({
      selectedTab : true,
      Strings.upcoming: ''
    }));
    isUpcomingCausesLoading.value = false;
  }

  getRecentlyStartedCauses(String selectedTab) async {
    isRecentlyStartedCausesLoading.value = true;
    recentlyStartedCauses =  await (RemoteRepository.fetchCauses({
      selectedTab : true,
      Strings.recent: true,
    }));
    isRecentlyStartedCausesLoading.value = false;
  }

}