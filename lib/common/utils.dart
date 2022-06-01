import 'dart:async' show Future;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/res/res.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String? getString(String key, [String? defValue]) {
    if (PreferenceUtils._prefsInstance != null) {
      return _prefsInstance?.getString(key) ?? defValue ?? "";
    }
    return null;
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;

    return prefs.setString(key, value); //?? Future.value(null);
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value); //?? Future.value(null);
  }

  static bool getBool(String key, [bool? defValue]) {
    return _prefsInstance?.getBool(key) ?? defValue ?? false;
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;

    return prefs.setInt(key, value); //?? Future.value(null);
  }

  static int getInt(String key, [int? defValue]) {
    return _prefsInstance?.getInt(key) ?? defValue ?? 0;
  }

  static List<Color> getGradient() {
    return [
      AppColors.lightGreenColor,
      AppColors.pureWhiteColor,
    ];
  }

  static clearPreferences() {
    _prefsInstance?.clear();
  }

  static List<BarChartGroupData> getGraphData() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
              toY: 12000000000,
              width: getWidth() * 0.05,
              color: AppColors.greenColor,
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
              toY: 22000000000,
              width: getWidth() * 0.05,
              color: AppColors.greenColor,
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
              toY: 34000000000,
              width: getWidth() * 0.05,
              color: AppColors.greenColor,
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
              toY: 14000000000,
              width: getWidth() * 0.05,
              color: AppColors.greenColor,
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
              toY: 14000000000,
              width: getWidth() * 0.05,
              color: AppColors.greenColor,
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
              toY: 14000000000,
              width: getWidth() * 0.05,
              color: AppColors.greenColor,
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
    ];
  }

  static bool isUserAuthenticated() {
    bool _isUserAuthenticated = MyHive.getToken() != Strings.dummyToken;
    return _isUserAuthenticated;
  }

  static String getImgExtension(String url) {
    String type = 'image';
    if (url.endsWith('.png')) {
      type = type + '/' + 'png';
    } else if (url.endsWith('.jpg')) {
      type = type + '/' + 'jpeg';
    } else if (url.endsWith('.jpeg')) {
      type = type + '/' + 'jpeg';
    }
    return type;
  }
}
