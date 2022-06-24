import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/routes.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/local/my_hive.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class PushNotificationConfig {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      Strings.notificationId, // id
      Strings.notificationTitle,
      description: Strings.notificationDesc,
      importance: Importance.high,
      playSound: true);

  static initNotifications() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('settings status: ${settings.authorizationStatus}');

    setupInteractedMessage();
    handleForeGroundPushNotifications();
  }

  ///terminate state
  static Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleBackGroundNotificationClick(initialMessage);
    }
  }

  static void handleBackGroundNotificationClick(RemoteMessage payload) {
    Future.delayed(10.seconds, () {
      String category = payload.data['category'];
      String id = payload.data['id'];

      if (category == Strings.causes) {
        Get.toNamed(Routes.causesDetailScreen, arguments: {
          Strings.causeId: int.parse(id),
          Strings.organizationId: 1
        });
      } else {
        Get.toNamed(Routes.businessDetailScreen, arguments: int.parse(id));
      }
    });
  }

  static handleForeGroundNotificationClick(String? payload,
      {RemoteMessage? message}) {
    late String category;
    late String id;
    if (message == null) {
      Map<String, dynamic> payLoadMap = json.decode(payload!);
      category = payLoadMap['category'];
      id = payLoadMap['id'];
    } else {
      category = message.data['category'];
      id = message.data['id'];
    }

    if (category == Strings.causes) {
      Get.toNamed(Routes.causesDetailScreen, arguments: {
        Strings.causeId: int.parse(id),
        Strings.organizationId: 1
      });
    } else {
      Get.toNamed(Routes.businessDetailScreen, arguments: id);
    }
  }

  static handleForeGroundPushNotifications() {
    ///background state -> pause
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      handleForeGroundNotificationClick(null, message: message);
    });

    /// Setup--->
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            defaultPresentAlert: true,
            defaultPresentSound: true,
            defaultPresentBadge: true,
            onDidReceiveLocalNotification: (id, title, body, payload) {});
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,

        ///foreground state
        onSelectNotification: (payload) {
      handleForeGroundNotificationClick(payload!);
    });

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        RemoteNotification? notification = message.notification;

        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: Strings.mipmapIcLauncher,
                ),
                iOS: const IOSNotificationDetails(
                    presentSound: true, presentBadge: true, presentAlert: true),
              ),
              payload: json.encode(message.data));
        }
      },
    );
  }

  static Future<void> handleBackgroundPushNotifications(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleBackGroundNotificationClick(initialMessage);
    }
  }

  static handleNotificationPayLoad(
      {required String category, required int id}) {
    if (category == Strings.causes) {
      Get.toNamed(Routes.causesDetailScreen,
          arguments: {Strings.causeId: id, Strings.organizationId: 1});
    } else {
      Get.toNamed(Routes.businessDetailScreen, arguments: id);
    }
  }

  static setFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    log('FCM TOKEN: ${token.toString()}');
    MyHive.setFCMToken(token);
  }
}
