import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/common/utils.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/model/business_category.dart';
import 'package:thinknlocal_app/model/businesses.dart';
import 'package:thinknlocal_app/model/cause_advertisement.dart';
import 'package:thinknlocal_app/model/cause_detail.dart';
import 'package:thinknlocal_app/model/causes_stats.dart';
import 'package:thinknlocal_app/model/chart_stats_model.dart';
import 'package:thinknlocal_app/model/follows.dart';
import 'package:thinknlocal_app/model/update_causes.dart';
import 'package:thinknlocal_app/network/remote_repositories/business_repository.dart';
import 'package:thinknlocal_app/network/remote_repositories/cause_repository.dart';
import 'package:thinknlocal_app/network/remote_repositories/follows_repository.dart';
import 'package:thinknlocal_app/network/remote_services.dart';
import 'package:get/get.dart';

class CausesDetailController extends GetxController {
  RxBool isFoodAndDrink = true.obs;
  RxBool isThingsToDo = false.obs;
  RxBool isRetail = false.obs;
  RxBool isServices = false.obs;
  CauseDetail? causeDetail;
  CausesStats? causesStats;
  RxList<Businesses>? causeBottomDetails = <Businesses>[].obs;
  List<Businesses>? causeFeaturedList = [];
  List<UpdateCauses>? updatedCausesList = [];
  List<CauseAdvertisement>? causeAdvertisementList = [];
  List<CauseAdvertisement>? causeFeaturedAdvertisementList = [];
  List<BusinessCategoryModel>? businessCategoryList = [];
  Follows? follows;
  RxBool isLoading = false.obs;
  RxBool isBottomTabLoading = false.obs;
  RxBool isStatsLoading = false.obs;
  RxBool isCauseBottomLoading = false.obs;
  RxBool isFeaturedLoading = false.obs;
  RxBool isCauseUpdate = false.obs;
  RxBool isCauseAdvertisementLoading = false.obs;
  RxBool isCauseFeaturedAdvertisementLoading = false.obs;
  RxBool isBusinessCategoryLoading = false.obs;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isCauseFollowed = false.obs;
  final bool _isUserAuthenticated = PreferenceUtils.isUserAuthenticated();
  List<ChartData> causesStatsHistory = <ChartData>[];
  RxInt foodDrinkId = 0.obs;
  RxInt thingsToDoId = 0.obs;
  RxInt retailId = 0.obs;
  RxInt servicesId = 0.obs;

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

  getCauseBottomDetails(int id, int parentId, {bool isBottomTab = false}) async {
    if(isBottomTab){
      isBottomTabLoading.value = true;
    }
    else{
      isBottomTabLoading.value = true;
      isCauseBottomLoading.value = true;
    }
    causeBottomDetails?.clear();
    causeBottomDetails?.value = (await (BusinessRemoteRepository.fetchBusinesses({
      Strings.causeId: id,
      Strings.parentCategoryId: parentId,
    }))) ?? [];
    if(isBottomTab){
      isBottomTabLoading.value = false;
    }
    else{
      isBottomTabLoading.value = false;
      isCauseBottomLoading.value = false;
    }
  }

  fetchBusinessCategories() async {
    isBusinessCategoryLoading.value = true;
    businessCategoryList =  await BusinessRemoteRepository.fetchBusinessCategories();
    for(BusinessCategoryModel businessCategoryModel in businessCategoryList!){
       switch(businessCategoryModel.parent?.name ?? ''){
         case Strings.foodDrink:
           foodDrinkId.value = businessCategoryModel.parent!.id!;
           break;
         case Strings.toDoThings:
           thingsToDoId.value = businessCategoryModel.parent!.id!;
           break;
         case Strings.retail:
           retailId.value = businessCategoryModel.parent!.id!;
           break;
         case Strings.personalServices:
           servicesId.value = businessCategoryModel.parent!.id!;
           break;
         default:
           break;
       }
    }
    isBusinessCategoryLoading.value = false;
  }

  getCauseStats(int id) async {
    isStatsLoading.value = true;
    causesStats = (await CausesRemoteRepository.fetchCausesStats(id, {}));
    if (causesStats?.history?.isNotEmpty ?? false) {
      causesStatsHistory.clear();
      for (var item in causesStats!.history!) {
        List<String> splitDate = item.date!.split(' ');
        item.date = splitDate[0];
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
    }else{
      if(_isUserAuthenticated) {
        isCauseFollowed.value = true;
        await CausesRemoteRepository.followCause(id);
      }
      else{
        userNotLoggedIn();
      }
    }
  }

  getFollowCause(int id) async {
    isCauseFollowed.value = false;
    follows = await FollowsRemoteRepository.fetchFollows();
    for (var cause in follows!.causes!) {
      if (cause.toString().contains(id.toString())) {
        isCauseFollowed.value = true;
      }
    }
  }

  getUpdatedCauses(int id) async {
    isCauseUpdate.value = true;
    updatedCausesList =  await CausesRemoteRepository.fetchUpdatedCauses(id);
    isCauseUpdate.value = false;
  }

  getCauseAdvertisements(int id) async {
    isCauseAdvertisementLoading.value = true;
    causeAdvertisementList =  await CausesRemoteRepository.fetchCauseAdvertisements(id, Strings.corporate);
    isCauseAdvertisementLoading.value = false;
  }

  getCauseFeaturedAdvertisements(int id) async {
    isCauseFeaturedAdvertisementLoading.value = true;
    causeFeaturedAdvertisementList =  await CausesRemoteRepository.fetchCauseAdvertisements(id, Strings.featured);
    isCauseFeaturedAdvertisementLoading.value = false;
  }
}
