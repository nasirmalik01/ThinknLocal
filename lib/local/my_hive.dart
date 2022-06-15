import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/app_info.dart';
import 'package:flutter_app/local/deep_link_info.dart';
import 'package:flutter_app/local/user_location.dart';
import 'package:hive_flutter/adapters.dart';

class MyHive {
  static const String _token = 'userToken';
  static const String _location = 'UserLocation';
  static const String _deepLinkInfo = 'DeepLinkInfo';
  static const String _appInfo = 'AppInfo';
  static const String _locationAddress = 'LocationAddress';

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

}
