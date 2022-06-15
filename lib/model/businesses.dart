class Businesses {
  int? id;
  Category? category;
  String? name;
  String? description;
  String? restrictions;
  String? phone;
  String? url;
  String? image;
  String? logo;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zip;
  double? latitude;
  double? longitude;
  String? contributionAmount;
  String? contributionAmountMax;
  double? rating;
  double? totalContributions;
  String? createdAt;

  Businesses(
      {this.id,
        this.category,
        this.name,
        this.description,
        this.restrictions,
        this.phone,
        this.url,
        this.image,
        this.logo,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.zip,
        this.latitude,
        this.longitude,
        this.contributionAmount,
        this.contributionAmountMax,
        this.rating,
        this.totalContributions,
        this.createdAt});

  Businesses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    name = json['name'];
    description = json['description'];
    restrictions = json['restrictions'];
    phone = json['phone'];
    url = json['url'];
    image = json['image'];
    logo = json['logo'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    contributionAmount = json['contribution_amount'];
    contributionAmountMax = json['contribution_amount_max'];
    rating = json['rating'];
    totalContributions = json['total_contributions'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['name'] = this.name;
    data['description'] = this.description;
    data['restrictions'] = this.restrictions;
    data['phone'] = this.phone;
    data['url'] = this.url;
    data['image'] = this.image;
    data['logo'] = this.logo;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['contribution_amount'] = this.contributionAmount;
    data['contribution_amount_max'] = this.contributionAmountMax;
    data['rating'] = this.rating;
    data['total_contributions'] = this.totalContributions;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? icon;
  int? parentId;
  String? parentName;

  Category({this.id, this.name, this.icon, this.parentId, this.parentName});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    parentId = json['parent_id'];
    parentName = json['parent_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['parent_id'] = this.parentId;
    data['parent_name'] = this.parentName;
    return data;
  }
}