import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class MyHive {
  static const String _token = 'userToken';

  static late Box _ins;

  Box get ins => _ins;

  static init() async {
    _ins = await Hive.openBox('ThinknLocal_DB');
  }


  static getToken() {
    return _ins.get(_token, defaultValue: null);
  }

  static setToken(String? type) {
    _ins.put(_token, type);
  }
}

