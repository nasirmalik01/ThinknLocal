import 'package:hive/hive.dart';

part 'deep_link_info.g.dart';


@HiveType(typeId: 2)
class DeepLinkInfo {
  @HiveField(0)
  final int? causeId;
  @HiveField(1)
  final int? businessId;
  @HiveField(2)
  final int? organizationId;

  DeepLinkInfo({this.causeId, this.businessId, this.organizationId});




}
