import 'package:flutter/material.dart';
import 'package:flutter_app/common/main_controller.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/widgets/enable_permissions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({Key? key}) : super(key: key);

  @override
  State<LocationPermissionScreen> createState() => _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> with WidgetsBindingObserver {
  final MainController _mainController = Get.put(MainController());


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        if(_mainController.isLocationServiceEnabled.value){
          Get.toNamed(Routes.notificationPermissionScreen);
        }
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => !_mainController.isLoading.value
          ? EnablePermission(
                title:'Enable Location',
                description: 'By allowing location permissions you are able to explore the causes near you that need your help.',
                onGoToSettingsTap: () async {
                   Geolocator.openLocationSettings();
                },
                buttonText: 'Go to Settings',
                isLocation: true,
              )
          : const SizedBox()),
    );
  }
}