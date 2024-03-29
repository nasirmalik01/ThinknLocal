import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/local/my_hive.dart';
import 'package:thinknlocal_app/model/causes.dart';
import 'package:thinknlocal_app/network/remote_repositories/cause_repository.dart';
import 'package:thinknlocal_app/network/remote_services.dart';
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
    if(query.length <=2 && query.trim().isNotEmpty) return;
    isSearchedCauseLoading.value = true;
    searchedCausesList?.clear();
    searchedCausesList =  await (CausesRemoteRepository.fetchCauses({
      Strings.q :  query.trim().isEmpty ? '' : query,
    },));
    if(RemoteServices.statusCode != 200 && RemoteServices.statusCode != 201 && RemoteServices.statusCode != 204){
      isError.value = true;
      isSearchedCauseLoading.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
    update();
    isSearchedCauseLoading.value = false;
  }

  getLocationAddress() async {
   locationAddress.value = MyHive.getLocationAddress();
  }
}