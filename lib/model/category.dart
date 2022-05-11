class Category {
  int? id;
  String? name;
  String? icon;
  int? parentId;
  String? parentName;

  Category({id, name, icon, parentId, parentName});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    parentId = json['parent_id'];
    parentName = json['parent_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    data['parent_id'] = parentId;
    data['parent_name'] = parentName;
    return data;
  }
}