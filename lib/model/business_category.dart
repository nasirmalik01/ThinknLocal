import 'package:thinknlocal_app/model/parent.dart';

class BusinessCategoryModel {
  int? id;
  String? type;
  String? name;
  String? icon;
  String? iconUrl;
  Parent? parent;

  BusinessCategoryModel({this.id, this.type, this.name, this.icon, this.iconUrl, this.parent});

  BusinessCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    icon = json['icon'];
    iconUrl = json['icon_url'];
    parent =
    json['parent'] != null ? Parent.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['icon'] = icon;
    data['icon_url'] = iconUrl;
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    return data;
  }
}

