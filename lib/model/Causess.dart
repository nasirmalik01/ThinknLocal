/// id : 27
/// category : {"id":38,"name":"Church","icon":"hand-heart","parent_id":37,"parent_name":"Non-Profit"}
/// organization : {"id":2,"name":"Schmeler, Grant and Yost","description":"Magni ducimus ipsum. Recusandae voluptas veniam. Perferendis nesciunt sint. Ratione dolorem voluptatem. Animi doloribus rerum. Animi quia debitis. Et in harum. Dolore sunt ea. Natus dolor ad. Ut recusandae possimus. Aperiam omnis molestiae. Aperiam iure n.","logo":"https://thinknlocal-staging.sfo2.digitaloceanspaces.com/6xvof4ut9o7kkznnyw0pr3tvd5zb"}
/// name : "Re-contextualized analyzing model"
/// description : "Minima et deserunt. Facilis quo vel. Dignissimos labore aliquam."
/// image : "https://thinknlocal-staging.sfo2.digitaloceanspaces.com/curtst9lrrk8t5knn57zc11trizt"
/// goal : 3500.0
/// raised : 912.0
/// remaining : 2588.0
/// goal_probability : "unlikely"
/// contributors : 11
/// start : "2022-02-11T00:00:00Z"
/// days_till_start : 0
/// end : "2022-02-20T00:00:00Z"
/// days_remaining : 0

class Causess {
  Causess({
      int? id, 
      Category? category, 
      Organization? organization, 
      String? name, 
      String? description, 
      String? image, 
      double? goal, 
      double? raised, 
      double? remaining, 
      String? goalProbability, 
      int? contributors, 
      String? start, 
      int? daysTillStart, 
      String? end, 
      int? daysRemaining,}){
    _id = id;
    _category = category;
    _organization = organization;
    _name = name;
    _description = description;
    _image = image;
    _goal = goal;
    _raised = raised;
    _remaining = remaining;
    _goalProbability = goalProbability;
    _contributors = contributors;
    _start = start;
    _daysTillStart = daysTillStart;
    _end = end;
    _daysRemaining = daysRemaining;
}

  Causess.fromJson(dynamic json) {
    _id = json['id'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _organization = json['organization'] != null ? Organization.fromJson(json['organization']) : null;
    _name = json['name'];
    _description = json['description'];
    _image = json['image'];
    _goal = json['goal'];
    _raised = json['raised'];
    _remaining = json['remaining'];
    _goalProbability = json['goal_probability'];
    _contributors = json['contributors'];
    _start = json['start'];
    _daysTillStart = json['days_till_start'];
    _end = json['end'];
    _daysRemaining = json['days_remaining'];
  }
  int? _id;
  Category? _category;
  Organization? _organization;
  String? _name;
  String? _description;
  String? _image;
  double? _goal;
  double? _raised;
  double? _remaining;
  String? _goalProbability;
  int? _contributors;
  String? _start;
  int? _daysTillStart;
  String? _end;
  int? _daysRemaining;
Causess copyWith({  int? id,
  Category? category,
  Organization? organization,
  String? name,
  String? description,
  String? image,
  double? goal,
  double? raised,
  double? remaining,
  String? goalProbability,
  int? contributors,
  String? start,
  int? daysTillStart,
  String? end,
  int? daysRemaining,
}) => Causess(  id: id ?? _id,
  category: category ?? _category,
  organization: organization ?? _organization,
  name: name ?? _name,
  description: description ?? _description,
  image: image ?? _image,
  goal: goal ?? _goal,
  raised: raised ?? _raised,
  remaining: remaining ?? _remaining,
  goalProbability: goalProbability ?? _goalProbability,
  contributors: contributors ?? _contributors,
  start: start ?? _start,
  daysTillStart: daysTillStart ?? _daysTillStart,
  end: end ?? _end,
  daysRemaining: daysRemaining ?? _daysRemaining,
);
  int? get id => _id;
  Category? get category => _category;
  Organization? get organization => _organization;
  String? get name => _name;
  String? get description => _description;
  String? get image => _image;
  double? get goal => _goal;
  double? get raised => _raised;
  double? get remaining => _remaining;
  String? get goalProbability => _goalProbability;
  int? get contributors => _contributors;
  String? get start => _start;
  int? get daysTillStart => _daysTillStart;
  String? get end => _end;
  int? get daysRemaining => _daysRemaining;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_organization != null) {
      map['organization'] = _organization?.toJson();
    }
    map['name'] = _name;
    map['description'] = _description;
    map['image'] = _image;
    map['goal'] = _goal;
    map['raised'] = _raised;
    map['remaining'] = _remaining;
    map['goal_probability'] = _goalProbability;
    map['contributors'] = _contributors;
    map['start'] = _start;
    map['days_till_start'] = _daysTillStart;
    map['end'] = _end;
    map['days_remaining'] = _daysRemaining;
    return map;
  }

}

/// id : 2
/// name : "Schmeler, Grant and Yost"
/// description : "Magni ducimus ipsum. Recusandae voluptas veniam. Perferendis nesciunt sint. Ratione dolorem voluptatem. Animi doloribus rerum. Animi quia debitis. Et in harum. Dolore sunt ea. Natus dolor ad. Ut recusandae possimus. Aperiam omnis molestiae. Aperiam iure n."
/// logo : "https://thinknlocal-staging.sfo2.digitaloceanspaces.com/6xvof4ut9o7kkznnyw0pr3tvd5zb"

class Organization {
  Organization({
      int? id, 
      String? name, 
      String? description, 
      String? logo,}){
    _id = id;
    _name = name;
    _description = description;
    _logo = logo;
}

  Organization.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _logo = json['logo'];
  }
  int? _id;
  String? _name;
  String? _description;
  String? _logo;
Organization copyWith({  int? id,
  String? name,
  String? description,
  String? logo,
}) => Organization(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  logo: logo ?? _logo,
);
  int? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get logo => _logo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['logo'] = _logo;
    return map;
  }

}

/// id : 38
/// name : "Church"
/// icon : "hand-heart"
/// parent_id : 37
/// parent_name : "Non-Profit"

class Category {
  Category({
      int? id, 
      String? name, 
      String? icon, 
      int? parentId, 
      String? parentName,}){
    _id = id;
    _name = name;
    _icon = icon;
    _parentId = parentId;
    _parentName = parentName;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _icon = json['icon'];
    _parentId = json['parent_id'];
    _parentName = json['parent_name'];
  }
  int? _id;
  String? _name;
  String? _icon;
  int? _parentId;
  String? _parentName;
Category copyWith({  int? id,
  String? name,
  String? icon,
  int? parentId,
  String? parentName,
}) => Category(  id: id ?? _id,
  name: name ?? _name,
  icon: icon ?? _icon,
  parentId: parentId ?? _parentId,
  parentName: parentName ?? _parentName,
);
  int? get id => _id;
  String? get name => _name;
  String? get icon => _icon;
  int? get parentId => _parentId;
  String? get parentName => _parentName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['icon'] = _icon;
    map['parent_id'] = _parentId;
    map['parent_name'] = _parentName;
    return map;
  }

}