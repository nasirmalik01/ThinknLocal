class BusinessCategoryParentType {
  int? id;
  String? type;
  String? name;
  String? icon;
  String? iconUrl;

  BusinessCategoryParentType({this.id, this.type, this.name, this.icon, this.iconUrl});

  BusinessCategoryParentType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    icon = json['icon'];
    iconUrl = json['icon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['icon'] = icon;
    data['icon_url'] = iconUrl;
    return data;
  }
}