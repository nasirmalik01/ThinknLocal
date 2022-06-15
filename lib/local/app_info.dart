import 'package:hive/hive.dart';
part 'app_info.g.dart';

@HiveType(typeId: 3)
class AppInfo {
  @HiveField(0)
  final String? appName;
  @HiveField(1)
  final String? packageName;
  @HiveField(2)
  final String? appVersion;
  @HiveField(3)
  final String? buildNumber;

  AppInfo({this.appName, this.packageName, this.appVersion, this.buildNumber});
}
