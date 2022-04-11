import 'package:get/get.dart';

class CausesController extends GetxController{
  RxBool isFeatured = true.obs;
  RxBool isTrending = false.obs;
  RxBool isFavorites = false.obs;
  RxBool isPost = false.obs;

  setFeaturedTab(){
    isFeatured.value = true;
    isTrending.value = false;
    isFavorites.value = false;
    isPost.value = false;
  }

  setTrendingTab(){
    isFeatured.value = false;
    isTrending.value = true;
    isFavorites.value = false;
    isPost.value = false;
  }

  setFavoritesTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = true;
    isPost.value = false;
  }

  setPostTab(){
    isFeatured.value = false;
    isTrending.value = false;
    isFavorites.value = false;
    isPost.value = true;
  }
}