import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/model/Causess.dart';
import 'package:flutter_app/network/remote_repository.dart';
import 'package:get/get.dart';

class CausesController extends GetxController{
  RxBool isFeatured = true.obs;
  RxBool isTrending = false.obs;
  RxBool isFavorites = false.obs;
  RxBool isPast = false.obs;
  late Causess? causess;


  @override
  void onInit() {
    getUpComingCauses();
    print(MyHive.getToken());
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

  getUpComingCauses() async {
    causess =  await (RemoteRepository.fetchCauses({'upcoming': ''}));
  }

}