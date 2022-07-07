import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/local/my_hive.dart';
import 'package:thinknlocal_app/model/cities.dart';
import 'package:thinknlocal_app/network/remote_repositories/location_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationSearchController extends GetxController {
  List<Cities> citiesList = [];
  var isLoading = false.obs;
  RxString locationAddress = Strings.noLocation.obs;
  RxString noLocation = ''.obs;


  Future<void> getCities(String query) async {
    if(query.length <=2 && query.trim().isNotEmpty) return;
    Future.delayed(100.milliseconds, () {
      isLoading.value = true;
    });
    Position? position = await getCurrentLocation();
    Future.delayed(500.milliseconds, () async {
      try {
        citiesList.clear();
        citiesList = await LocationRepository.fetchCities({
          Strings.latitude:  position.latitude,
          Strings.longitude: position.longitude,
          Strings.q: query.trim().isEmpty ? '' : query
        }) ?? [];
        update();
      }
      finally {
        isLoading.value = false;
      }
    });
  }

  getLocationAddress() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _userLocationAddress = _prefs.getString(Strings.currentLocationAddress);
    locationAddress.value = _userLocationAddress ?? Strings.noLocation;
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  saveSelectedAddress(int index) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble(Strings.currentLat, citiesList[index].latitude!);
    _prefs.setDouble(Strings.currentLong, citiesList[index].longitude!);
    String? _userCurrentLocationAddress = await findAddress(citiesList[index].latitude!, citiesList[index].longitude!);
    locationAddress.value = _userCurrentLocationAddress!;
    MyHive.setCityId(citiesList[index].id.toString());
    MyHive.setLocationAddress(_userCurrentLocationAddress);
    Get.back(result: 1);
  }
}