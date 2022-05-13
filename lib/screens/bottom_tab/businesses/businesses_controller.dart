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
    getBusinesses();
    getRecentlyAddedBusinesses();
    getNearbyBusinesses();
    super.onInit();
  }

  setFeaturedTab(){
    isFeatured.value = true;
    isTrending.value = false;
    isFavorites.value = false;
    isPast.value = false;
  }

  setTrendingTab(){
    isFeatured.value = false;
    isTrending.value = true;
    isFavorites.value = false;
    isPast.value = false;
  }

  setFavoritesTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = true;
    isPast.value = false;
  }

  setPostTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = false;
    isPast.value = true;
  }

  getBusinesses() async {
    isBusinessLoading.value = true;
    businessList =  await (BusinessRemoteRepository.fetchBusinesses({}));
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

  getRecentlyAddedBusinesses() async {
    isRecentlyAddedBusinessLoading.value = true;
    recentlyAddedBusinessList =  await (BusinessRemoteRepository.fetchBusinesses({}));
    isRecentlyAddedBusinessLoading.value = false;
  }

  getNearbyBusinesses() async {
    isNearByBusinessLoading.value = true;
    nearbyBusinessList =  await (BusinessRemoteRepository.fetchBusinesses({
      Strings.nearby : true
    }));
    isNearByBusinessLoading.value = false;
  }
}