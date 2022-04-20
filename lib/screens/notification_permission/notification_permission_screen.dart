import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/enable_permissions.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: EnablePermission(
          title: 'Enable Notification',
          description: 'Enable notifications you don’t miss the next fundraiser near you.',
          onGoToSettingsTap: (){},
          isLocation: false,
        )
    );
  }
}
