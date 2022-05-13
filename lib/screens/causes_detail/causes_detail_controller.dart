import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/model/businesses.dart';
import 'package:flutter_app/model/cause_detail.dart';
import 'package:flutter_app/model/causes_stats.dart';
import 'package:flutter_app/network/remote_repositories/business_repository.dart';
import 'package:flutter_app/network/remote_repositories/cause_repository.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';

class CausesDetailController extends GetxController {
  RxBool isFoodAndDrink = true.obs;
  RxBool isThingsToDo = false.obs;
  RxBool isRetail = false.obs;
  RxBool isServices = false.obs;
  CauseDetail? causeDetail;
  CausesStats? causesStats;
  List<Businesses>? causeBottomDetails = [];
  List<Businesses>? causeFeaturedList = [];
  RxBool isLoading = false.obs;
  RxBool isStatsLoading = false.obs;
  RxBool isCauseBottomLoading = false.obs;
  RxBool isFeaturedLoading = false.obs;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isCauseFollowed = false.obs;

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
    causeDetail = (await CausesRemoteRepository.fetchCauseDetails(id, {}));
    if(RemoteServices.statusCode != 200 && RemoteServices.statusCode != 201 && RemoteServices.statusCode != 204){
      isError.value = true;
      isLoading.value = false;
      isFeaturedLoading.value = false;
      isCauseBottomLoading.value = false;
      isStatsLoading.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
    isLoading.value = false;
  }

  getCauseFeatured(int id) async {
    isFeaturedLoading.value = true;
    causeFeaturedList = (await BusinessRemoteRepository.fetchBusinesses({
      Strings.causeId: id,
    }));
    isFeaturedLoading.value = false;
  }

  getCauseBottomDetails(int id, int parentId) async {
    isCauseBottomLoading.value = true;
    causeBottomDetails = await (BusinessRemoteRepository.fetchBusinesses({
      Strings.cause: id,
      Strings.parentCategoryId: parentId,
    }));
    isCauseBottomLoading.value = false;
  }

  getCauseStats(int id) async {
    isStatsLoading.value = true;
    causesStats = (await CausesRemoteRepository.fetchCausesStats(id, {}));
    isStatsLoading.value = false;
  }

  followCauses(int id) async {
    if(isCauseFollowed.value) {
      await CausesRemoteRepository.unFollowCause(id);
      isCauseFollowed.value = false;
    }else{
      await CausesRemoteRepository.followCause(id);
      isCauseFollowed.value = true;
    }
  }
}
