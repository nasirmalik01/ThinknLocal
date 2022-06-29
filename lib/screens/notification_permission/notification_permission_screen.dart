import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/routes.dart';
import 'package:thinknlocal_app/widgets/enable_permissions.dart';
import 'package:get/get.dart';
import 'package:notification_permissions/notification_permissions.dart';

class NotificationPermissionScreen extends StatefulWidget {
  const NotificationPermissionScreen({Key? key}) : super(key: key);

  @override
  State<NotificationPermissionScreen> createState() => _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState extends State<NotificationPermissionScreen> with WidgetsBindingObserver{
  late Future<String> permissionStatusFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
          permissionStatusFuture = getCheckNotificationPermStatus();
    }
}

  /// Checks the notification permission status
  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          break;
        case PermissionStatus.granted:
          Get.offAllNamed(Routes.loginScreen);
         break;
        case PermissionStatus.unknown:
          break;
        case PermissionStatus.provisional:
          break;
        default:
          break;
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: EnablePermission(
          title: 'Enable Notification',
          description: 'Enable notifications you don’t miss the next fundraiser near you.',
          onGoToSettingsTap: (){
            AppSettings.openNotificationSettings();
          },
          buttonText: 'Go To Settings',
          icon: Assets.notificationPermissionIcon,
        )
    );
  }
}
