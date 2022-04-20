import 'package:flutter/material.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/widgets/enable_permissions.dart';
import 'package:get/get.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EnablePermission(
        title: 'Enable Location',
        description: 'By allowing location permissions you are able to explore the causes near you that need your help.',
        onGoToSettingsTap: (){
          Get.toNamed(Routes.notificationPermissionScreen);
        },
        isLocation: true,
      )
    );
  }
}
