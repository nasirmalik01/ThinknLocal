import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/status_bar.dart';
import 'package:get/get.dart';

class CausesDetailController extends GetxController{
  RxBool isFoodAndDrink = true.obs;
  RxBool isThingsToDo = false.obs;
  RxBool isRetail = false.obs;
  RxBool isServices = false.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    setStatusBarColor(color: Colors.transparent);
    scrollController.addListener(scrollListener);
    super.onInit();
  }

  setFoodAndDrinkTab(){
    isFoodAndDrink.value = true;
    isThingsToDo.value = false;
    isRetail.value = false;
    isServices.value = false;
  }

  setThingsToDoTab(){
    isFoodAndDrink.value = false;
    isThingsToDo.value = true;
    isRetail.value = false;
    isServices.value = false;
  }

  setRetailTab(){
    isFoodAndDrink.value = false;
    isThingsToDo.value = false;
    isRetail.value = true;
    isServices.value = false;
  }

  setServicesTab(){
    isFoodAndDrink.value = false;
    isThingsToDo.value = false;
    isRetail.value = false;
    isServices.value = true;
  }

  scrollListener() {
    if (scrollController.position.isScrollingNotifier.value) {
      setStatusBarColor(color: Colors.black54, isTextColorLight: true);
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent && !scrollController.position.outOfRange) {
      setStatusBarColor(color: Colors.transparent);
    }
  }
}