import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/model/businesses.dart';
import 'package:flutter_app/network/remote_repositories/business_repository.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';

class BusinessSearchController extends GetxController{
  RxBool isSearchedBusinessLoading = false.obs;
  late List<Businesses>? searchedBusinessList = [];
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxString locationAddress = Strings.noLocation.obs;

  @override
  void onInit() {
    getLocationAddress();
    getSearchedBusinesses('');
    super.onInit();
  }

  getSearchedBusinesses(String query) async {
    if(query.length <=2 && query.trim().isNotEmpty) return;
    isSearchedBusinessLoading.value = true;
    searchedBusinessList?.clear();
    searchedBusinessList =  await (BusinessRemoteRepository.fetchBusinesses({
      Strings.q : query.trim().isEmpty ? '' : query,
    },));
    if(RemoteServices.statusCode != 200 && RemoteServices.statusCode != 201 && RemoteServices.statusCode != 204){
      isError.value = true;
      isSearchedBusinessLoading.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
    update();
    isSearchedBusinessLoading.value = false;
  }

  getLocationAddress() async {
    locationAddress.value = MyHive.getLocationAddress();
  }
}