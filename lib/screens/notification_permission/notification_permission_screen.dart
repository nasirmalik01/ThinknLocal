import 'package:flutter/material.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/widgets/enable_permissions.dart';
import 'package:get/get.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: EnablePermission(
          title: 'Enable Notification',
          description: 'Enable notifications you don’t miss the next fundraiser near you.',
          onGoToSettingsTap: (){
            Get.toNamed(Routes.loginScreen);
          },
          isLocation: false,
        )
    );
  }
}
