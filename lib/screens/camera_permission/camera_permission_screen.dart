import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/main_controller.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/widgets/enable_permissions.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPermissionScreen extends StatefulWidget {
  const CameraPermissionScreen({Key? key}) : super(key: key);

  @override
  State<CameraPermissionScreen> createState() => _CameraPermissionScreenState();
}

class _CameraPermissionScreenState extends State<CameraPermissionScreen> {
  final MainController _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => !_mainController.isLoading.value
        ? EnablePermission(
        isIcon: false,
        title:'Enable Camera',
        description: 'By allowing camera permissions you are able to capture and upload receipts',
        onGoToSettingsTap: () async {
            PermissionStatus status = await Permission.camera.status;
            if(status.isPermanentlyDenied){
              openAppSettings();
            }
            else {
              checkCameraPermission();
            }
        },
        buttonText: 'Allow camera',
        isLocation: true,
      )
          : const SizedBox()),
    );
  }
}