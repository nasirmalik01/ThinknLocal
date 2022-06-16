import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class PushNotificationConfig{
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      Strings.notificationId, // id
      Strings.notificationTitle,
      description: Strings.notificationDesc,
      importance: Importance.high,
      playSound: true
  );

  static initNotifications() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation
    <IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

  }

  static handleForeGroundPushNotifications(){

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{
      log("onMessage: $message");
      showSnackBar(subTitle: 'okkkk');
      // log('Title: ${message.notification!.title}');
      // log('Body: ${message.notification!.body}');
      // log('Notification: ${message.notification}');
      // log('Data: ${message.data}');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
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
                  presentSound: true,
                  presentBadge: true,
                  presentAlert: true
              ),
            ));
      }
   },);
}

  static Future<void> handleBackgroundPushNotifications(RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint('A bg message just showed up :  ${message.messageId}');
    RemoteNotification? notification = message.notification;
    debugPrint('Title: ${notification!.title!}');
    debugPrint('Body: ${notification.body!}');
  }

  static handleNotificationPayLoad({required String category, required int id}){
    if(category == Strings.causes){
      Get.toNamed(Routes.causesDetailScreen, arguments: {
        Strings.causeId: id,
        Strings.organizationId: 1
      });
    }else{
      Get.toNamed(Routes.businessDetailScreen, arguments: id);
    }
  }
}