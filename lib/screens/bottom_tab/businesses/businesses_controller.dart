import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/model/businesses.dart';
import 'package:flutter_app/network/remote_repositories/business_repository.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';

class BusinessesController extends GetxController{
  RxBool isFeatured = true.obs;
  RxBool isTrending = false.obs;
  RxBool isFavorites = false.obs;
  RxBool isPast = false.obs;
  RxBool isBusinessLoading = false.obs;
  RxBool isRecentlyAddedBusinessLoading = false.obs;
  RxBool isNearByBusinessLoading = false.obs;
  List<Businesses>? businessList = [];
  List<Businesses>? recentlyAddedBusinessList = [];
  List<Businesses>? nearbyBusinessList = [];
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    getBusinesses(Strings.featured);
    getRecentlyAddedBusinesses(Strings.featured);
    getNearbyBusinesses(Strings.featured);
    super.onInit();
  }

  setFeaturedTab(){
    isFeatured.value = true;
    isTrending.value = false;
    isFavorites.value = false;
    isPast.value = false;
    getBusinesses(Strings.featured);
    getRecentlyAddedBusinesses(Strings.featured);
    getNearbyBusinesses(Strings.featured);
  }

  setTrendingTab(){
    isFeatured.value = false;
    isTrending.value = true;
    isFavorites.value = false;
    isPast.value = false;
    getBusinesses(Strings.trending);
    getRecentlyAddedBusinesses(Strings.trending);
    getNearbyBusinesses(Strings.trending);
  }

  setFavoritesTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = true;
    isPast.value = false;
    getBusinesses(Strings.favorites);
    getRecentlyAddedBusinesses(Strings.favorites);
    getNearbyBusinesses(Strings.favorites);
  }

  setPostTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = false;
    getBusinesses(Strings.past);
    getRecentlyAddedBusinesses(Strings.past);
    getNearbyBusinesses(Strings.past);
    isPast.value = true;
  }

  getBusinesses(String selectedTab) async {
    isBusinessLoading.value = true;
    businessList =  await (BusinessRemoteRepository.fetchBusinesses({
      selectedTab: true
    }));
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

  getRecentlyAddedBusinesses(String selectedTab) async {
    isRecentlyAddedBusinessLoading.value = true;
    recentlyAddedBusinessList =  await (BusinessRemoteRepository.fetchBusinesses({
      selectedTab: true,
      Strings.recent: true
    }));
    isRecentlyAddedBusinessLoading.value = false;
  }

  getNearbyBusinesses(String selectedTab) async {
    isNearByBusinessLoading.value = true;
    nearbyBusinessList =  await (BusinessRemoteRepository.fetchBusinesses({
      selectedTab: true,
      Strings.nearby : true
    }));
    isNearByBusinessLoading.value = false;
  }
}