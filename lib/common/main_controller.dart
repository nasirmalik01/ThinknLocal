import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/local/my_hive.dart';
import 'package:thinknlocal_app/local/user_location.dart';
import 'package:thinknlocal_app/model/cities.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController{
  RxBool isLoading = false.obs;
  RxBool isLocationServiceEnabled = false.obs;
  Position? position;
  PersistentTabController? controller;

  Future<bool> getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      return false;
    }
    showThreeBounceLoading();
    var location = Location();
    isLocationServiceEnabled.value = await location.serviceEnabled();
    position = await getCurrentLocation();
    MyHive.setLocation(UserLocation(longitude: position!.longitude, latitude: position!.latitude));
    SharedPreferences _prefs = await SharedPreferences.getInstance();
     String? _userCurrentLocationAddress = await findAddress(position!.latitude, position!.longitude);
    Cities? _lowestDistanceCity =  await getFirstIndexCity();
    MyHive.setLocationAddress(_lowestDistanceCity!.name);
    _prefs.setDouble(Strings.currentLat, position!.latitude);
    _prefs.setDouble(Strings.currentLong, position!.longitude);
    _prefs.setString(Strings.currentLocationAddress, _userCurrentLocationAddress!);

    Get.back();
    return true;
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

}