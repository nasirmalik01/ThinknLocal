import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/local/app_info.dart';
import 'package:thinknlocal_app/local/deep_link_info.dart';
import 'package:thinknlocal_app/local/user_location.dart';
import 'package:hive_flutter/adapters.dart';

class MyHive {
  static const String _token = 'userToken';
  static const String _location = 'UserLocation';
  static const String _deepLinkInfo = 'DeepLinkInfo';
  static const String _appInfo = 'AppInfo';
  static const String _isPushNotificationsEnabled = 'IsPushNotificationsEnabled';
  static const String _isEmailEnabled = 'IsEmailEnabled';
  static const String _isLocationServicesEnabled = 'IsLocationServicesEnabled';
  static const String _locationAddress = 'LocationAddress';
  static const String _fcmToken = '_fcmToken';
  static const String _cityId = '_cityId';

  static late Box _ins;

  Box get ins => _ins;

  static init() async {
    Hive.registerAdapter(UserLocationAdapter());
    Hive.registerAdapter(DeepLinkInfoAdapter());
    Hive.registerAdapter(AppInfoAdapter());
    _ins = await Hive.openBox('ThinknLocal_DB');
  }

  static getToken() {
    ///dummy token : -Gqw
    return _ins.get(_token, defaultValue: Strings.dummyToken);
  }

  static setToken(String? type) {
    _ins.put(_token, type);
  }

  static getLocation() {
    return _ins.get(_location, defaultValue: null);
  }

  static setLocation(UserLocation type) {
    _ins.put(_location, type);
  }

  static setLocationAddress(String? locationAddress) {
    _ins.put(_locationAddress, locationAddress);
  }

  static getLocationAddress() {
    return _ins.get(_locationAddress);
  }

  static setFCMToken(String? fcmToken) {
    _ins.put(_fcmToken, fcmToken);
  }

  static getFCMToken() {
    return _ins.get(_fcmToken);
  }

  static setDeepLinkInfo(DeepLinkInfo deepLinkInfo) {
    _ins.put(_deepLinkInfo, deepLinkInfo);
  }

  static getDeepLinkInfo() {
    return _ins.get(_deepLinkInfo, defaultValue: null);
  }

  static setAppInfo(AppInfo appInfo) {
    _ins.put(_appInfo, appInfo);
  }

  static getAppInfo() {
    return _ins.get(_appInfo, defaultValue: null);
  }

  static setCityId(String? cityId) {
    _ins.put(_cityId, cityId);
  }

  static getCityId() {
    return _ins.get(_cityId, defaultValue: '');
  }

  static setPushNotificationsEnabled(bool value) {
    _ins.put(_isPushNotificationsEnabled, value);
  }

  static isPushNotificationsEnabled() {
    return _ins.get(_isPushNotificationsEnabled, defaultValue: true);
  }

  static setEmailEnabled(bool value) {
    _ins.put(_isEmailEnabled, value);
  }

  static isEmailEnabled() {
    return _ins.get(_isEmailEnabled, defaultValue: true);
  }

  static setLocationServicesEnabled(bool value) {
    _ins.put(_isLocationServicesEnabled, value);
  }

  static isLocationServicesEnabled() {
    return _ins.get(_isLocationServicesEnabled, defaultValue: true);
  }
}
