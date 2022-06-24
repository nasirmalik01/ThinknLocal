import 'package:flutter/material.dart';
import 'package:flutter_app/common/main_controller.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/widgets/enable_permissions.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({Key? key}) : super(key: key);

  @override
  State<LocationPermissionScreen> createState() => _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  final MainController _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => !_mainController.isLoading.value
          ? EnablePermission(
                title:'Enable Location',
                description: 'By allowing location permissions you are able to explore the causes near you that need your help.',
                onGoToSettingsTap: () async {
                  PermissionStatus status = await Permission.location.status;
                  if(status.isPermanentlyDenied){
                    openAppSettings();
                  }
                  else {
                    bool isLocationAllowed = await _mainController.getLocation();
                    if (isLocationAllowed) {
                      PreferenceUtils.setBool(Strings.showHome, true);
                      Get.offAndToNamed(Routes.bottomNavBarScreen);
                    }
                  }
                },
                buttonText: 'Allow location',
                isLocation: true,
              )
          : const SizedBox()),
    );
  }
}