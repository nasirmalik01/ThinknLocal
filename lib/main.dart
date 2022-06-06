import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/config/push_notification_config.dart';
import 'package:flutter_app/config/system_chrome_config.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String? token = await FirebaseMessaging.instance.getToken();
  debugPrint('FCM TOKEN: ${token.toString()}');
  FirebaseMessaging.onBackgroundMessage(PushNotificationConfig.handleBackgroundPushNotifications);
  PushNotificationConfig.initNotifications();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChromeConfig.setOverLayStyle();
  SystemChromeConfig.setOrientation();
  await Hive.initFlutter();
  await MyHive.init();
  await dependencyInjectionSetUp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return GetMaterialApp(
          builder: (BuildContext context, child) {
            final mediaQueryData = MediaQuery.of(context);
            final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.07);
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
                child: child!);
          },
          debugShowCheckedModeBanner: false,
          title: Strings.thinkLocal,
          unknownRoute: Routes.getUnknownRoute(),
          initialRoute: Routes.getInitialRoute(),
          getPages: Routes.getPages(),
        );
      },
    );
  }
}
