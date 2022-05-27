import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/model/cities.dart';
import 'package:flutter_app/network/remote_repositories/cause_repository.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';

class CauseSearchController extends GetxController{
  RxBool isSearchedCauseLoading = false.obs;
  late List<Causes>? searchedCausesList = [];
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxString locationAddress = Strings.noLocation.obs;

  @override
  void onInit() {
    getLocationAddress();
    getSearchedCauses('');
    super.onInit();
  }

  getSearchedCauses(String query) async {
    isSearchedCauseLoading.value = true;
    searchedCausesList = [];
    searchedCausesList =  await (CausesRemoteRepository.fetchCauses({
      Strings.q : query,
    },));
    if(RemoteServices.statusCode != 200 && RemoteServices.statusCode != 201 && RemoteServices.statusCode != 204){
      isError.value = true;
      isSearchedCauseLoading.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
    isSearchedCauseLoading.value = false;
  }

  getLocationAddress() async {
    Cities? _lowestDistanceCity = await getLowestDistanceCity();
    locationAddress.value = _lowestDistanceCity?.name ?? Strings.noLocation;
  }
}