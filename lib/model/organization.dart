class Organization {
  int? id;
  String? name;
  String? description;
  String? logo;

  Organization({id, name, description, logo});

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['logo'] = logo;
    return data;
  }
}