import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/local/user_location.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/network/remote_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class CausesController extends GetxController{
  RxBool isFeatured = true.obs;
  RxBool isTrending = false.obs;
  RxBool isFavorites = false.obs;
  RxBool isPast = false.obs;
  RxString locationAddress = 'No location'.obs;
  RxBool isUpcomingCausesLoading = false.obs;
  RxBool isRecentlyStartedCausesLoading = false.obs;
  RxBool isTopCausesContainersList = false.obs;
  late List<Causes>? topCausesContainersList = [];
  late List<Causes>? upcomingCauses = [];
  late List<Causes>? recentlyStartedCauses = [];


  @override
  void onInit() {
    getLocationAddress();
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

  setPastTab(){
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
      Strings.active: true
    },));
    isTopCausesContainersList.value = false;
  }

  getUpComingCauses(String selectedTab) async {
    isUpcomingCausesLoading.value = true;
    upcomingCauses =  await (RemoteRepository.fetchCauses({
      selectedTab : true,
      Strings.upcoming: '',
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

  getLocationAddress() async {
    if (MyHive.getLocation() != null) {
      locationAddress.value = await findAddress(MyHive.getLocation());
    }
  }

  Future<String> findAddress(UserLocation type) async {
    var placeMarkers = await placemarkFromCoordinates(type.latitude, type.longitude);
    var completeAddress = '${placeMarkers.first.street},${placeMarkers.first.locality},${placeMarkers.first.country}';
    return completeAddress;
  }

}