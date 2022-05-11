import 'package:flutter_app/model/businesses.dart';
import 'package:flutter_app/model/cause_detail.dart';
import 'package:flutter_app/model/causes_stats.dart';
import 'package:get/get.dart';
import '/network/remote_repository.dart';

class CausesDetailController extends GetxController {
  RxBool isFoodAndDrink = true.obs;
  RxBool isThingsToDo = false.obs;
  RxBool isRetail = false.obs;
  RxBool isServices = false.obs;
  late CauseDetail causeDetail;
  late CausesStats causesStats;
  List<Businesses>? causeBottomDetails = [];
  List<Businesses>? causeFeaturedList = [];
  RxBool isLoading = false.obs;
  RxBool isStatsLoading = false.obs;
  RxBool isCauseBottomLoading = false.obs;
  RxBool isFeaturedLoading = false.obs;

  setFoodAndDrinkTab() {
    isFoodAndDrink.value = true;
    isThingsToDo.value = false;
    isRetail.value = false;
    isServices.value = false;
  }

  setThingsToDoTab() {
    isFoodAndDrink.value = false;
    isThingsToDo.value = true;
    isRetail.value = false;
    isServices.value = false;
  }

  setRetailTab() {
    isFoodAndDrink.value = false;
    isThingsToDo.value = false;
    isRetail.value = true;
    isServices.value = false;
  }

  setServicesTab() {
    isFoodAndDrink.value = false;
    isThingsToDo.value = false;
    isRetail.value = false;
    isServices.value = true;
  }

  getCauseDetail(int id) async {
    isLoading.value = true;
    causeDetail = (await RemoteRepository.fetchCauseDetails(id, {}))!;
    isLoading.value = false;
  }

  getCauseFeatured(int id) async {
    isFeaturedLoading.value = true;
    causeFeaturedList = (await RemoteRepository.fetchBusinesses({
      'cause_id': id,
    }));
    isFeaturedLoading.value = false;
  }

  getCauseBottomDetails(int id, int parentId) async {
    isCauseBottomLoading.value = true;
    causeBottomDetails = await (RemoteRepository.fetchBusinesses({
      'cause_id': id,
      'parent_category_id': parentId,
    }));
    isCauseBottomLoading.value = false;
  }

  getCauseStats(int id) async {
    isStatsLoading.value = true;
    causesStats = (await RemoteRepository.fetchCausesStats(id, {}))!;
    isStatsLoading.value = false;
  }
}
