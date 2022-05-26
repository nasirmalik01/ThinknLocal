import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
  late List<Causes>? topCausesContainersList = [];
  late List<Causes>? upcomingCauses = [];
  late List<Causes>? recentlyStartedCauses = [];
  List<Cities> citiesList = [];
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxString locationAddress = Strings.noLocation.obs;


  @override
  void onInit() {
    getLocationAddress();
    initDynamicLinks();
    getCauses(Strings.featured);
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

  getCauses(String selectedTab) async {
    isTopCausesContainersList.value = true;
    topCausesContainersList =  await (CausesRemoteRepository.fetchCauses({
      selectedTab : true,
    },));
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

  getUpComingCauses() async {
    isUpcomingCausesLoading.value = true;
    upcomingCauses =  await (CausesRemoteRepository.fetchCauses({
      Strings.upcoming: true,
    }));
    isUpcomingCausesLoading.value = false;
  }

  getRecentlyStartedCauses() async {
    isRecentlyStartedCausesLoading.value = true;
    recentlyStartedCauses =  await (CausesRemoteRepository.fetchCauses({
      Strings.recent: true,
    }));
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


}