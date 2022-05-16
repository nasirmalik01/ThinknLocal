class Follows {
  List<int>? businesses;
  List<int>? causes;
  List<int>? organizations;

  Follows({this.businesses, this.causes, this.organizations});

  Follows.fromJson(Map<String, dynamic> json) {
    businesses = json['businesses'].cast<int>();
    causes = json['causes'].cast<int>();
    organizations = json['organizations'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['businesses'] = businesses;
    data['causes'] = causes;
    data['organizations'] = organizations;
    return data;
  }
}