import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/model/businesses.dart';
import 'package:flutter_app/model/cause_detail.dart';
import 'package:flutter_app/model/causes_stats.dart';
import 'package:flutter_app/model/chart_stats_model.dart';
import 'package:flutter_app/model/follows.dart';
import 'package:flutter_app/network/remote_repositories/business_repository.dart';
import 'package:flutter_app/network/remote_repositories/cause_repository.dart';
import 'package:flutter_app/network/remote_repositories/follows_repository.dart';
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
  Follows? follows;
  RxBool isLoading = false.obs;
  RxBool isStatsLoading = false.obs;
  RxBool isCauseBottomLoading = false.obs;
  RxBool isFeaturedLoading = false.obs;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isCauseFollowed = false.obs;
  List<ChartData> causesStatsHistory = <ChartData>[];

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
    if (RemoteServices.statusCode != 200 &&
        RemoteServices.statusCode != 201 &&
        RemoteServices.statusCode != 204) {
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
    causeFeaturedList = (await BusinessRemoteRepository.fetchBusinesses(
        {Strings.causeId: id, Strings.featured: true}));
    isFeaturedLoading.value = false;
  }

  getCauseBottomDetails(int id, int parentId) async {
    isCauseBottomLoading.value = true;
    causeBottomDetails = await (BusinessRemoteRepository.fetchBusinesses({
      Strings.causeId: id,
      Strings.parentCategoryId: parentId,
    }));
    isCauseBottomLoading.value = false;
  }

  getCauseStats(int id) async {
    isStatsLoading.value = true;
    causesStats = (await CausesRemoteRepository.fetchCausesStats(id, {}));
    if (causesStats?.history?.isNotEmpty ?? false) {
      causesStatsHistory.clear();
      for (var item in causesStats!.history!) {
        causesStatsHistory.add(ChartData(item.date!, item.amount));
      }
    }
    update(['causesBuilder']);
    isStatsLoading.value = false;
  }

  followCauses(int id) async {
    if (isCauseFollowed.value) {
      isCauseFollowed.value = false;
      await CausesRemoteRepository.unFollowCause(id);
    } else {
      isCauseFollowed.value = true;
      await CausesRemoteRepository.followCause(id);
    }
  }

  getFollowCause(int id) async {
    follows = await FollowsRemoteRepository.fetchFollows();
    for (var cause in follows!.causes!) {
      if (cause.toString().contains(id.toString())) {
        isCauseFollowed.value = true;
      }
    }
  }
}
