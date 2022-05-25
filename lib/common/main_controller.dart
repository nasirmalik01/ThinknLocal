import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/local/user_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class MainController extends GetxController{
  RxBool isLoading = false.obs;
  RxBool isLocationServiceEnabled = false.obs;
  Position? position;


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
    var location = Location();
    isLocationServiceEnabled.value = await location.serviceEnabled();
    position = await getCurrentLocation();
    MyHive.setLocation(UserLocation(longitude: position!.longitude, latitude: position!.latitude));
    return true;
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}