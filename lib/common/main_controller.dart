import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class MainController extends GetxController{
  RxBool isLoading = false.obs;
  RxBool isLocationServiceEnabled = false.obs;


  @override
  void onInit() {
    checkLocationStatus();
    super.onInit();
  }

  checkLocationStatus() async {

    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var location = Location();
    isLocationServiceEnabled.value = await location.serviceEnabled();
  }
}