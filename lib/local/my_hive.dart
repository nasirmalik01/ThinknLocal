import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/user_location.dart';
import 'package:hive_flutter/adapters.dart';

class MyHive {
  static const String _token = 'userToken';
  static const String _location = 'UserLocation';

  static late Box _ins;

  Box get ins => _ins;

  static init() async {
    Hive.registerAdapter(UserLocationAdapter());
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
}
