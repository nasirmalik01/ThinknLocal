import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/model/cities.dart';
import 'package:flutter_app/network/remote_repositories/location_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LocationSearchController extends GetxController {
  List<Cities> citiesList = [];
  var isLoading = false.obs;
  RxString locationAddress = Strings.noLocation.obs;

  @override
  void onInit() {
    getLocationAddress();
    getCities('');
    super.onInit();
  }

  Future<void> getCities(String query) async {
    Future.delayed(100.milliseconds, () {
      isLoading.value = true;
    });
    var location = MyHive.getLocation();
    Future.delayed(500.milliseconds, () async {
      try {
        citiesList = await LocationRepository.fetchCities({
          Strings.latitude:  location.latitude,
          Strings.longitude: location.longitude,
          Strings.q: query
        }) ?? [];
      } finally {
        isLoading.value = false;
      }
    });
  }

  getLocationAddress() async {
    locationAddress.value = MyHive.getLocationAddress();
  }


}