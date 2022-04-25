import 'package:flutter/material.dart';
import 'package:flutter_app/common/main_controller.dart';
import 'package:flutter_app/widgets/enable_permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class LocationPermissionScreen extends StatelessWidget {
  LocationPermissionScreen({Key? key}) : super(key: key);

  final MainController _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EnablePermission(
        title: 'Enable Location',
        description: 'By allowing location permissions you are able to explore the causes near you that need your help.',
        onGoToSettingsTap: () async {
            await openAppSettings();
          },
        isLocation: true,
      )
    );
  }

}
