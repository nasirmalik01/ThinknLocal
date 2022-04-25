import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MainController extends GetxController{
  RxBool isLocationFetched = false.obs;
  Position? position;
  RxString locationAddress = ''.obs;

  determinePosition() async {
    isLocationFetched.value = true;
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
    position = await getCurrentLocation();
    print('Position: $position');
    isLocationFetched.value = false;
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}