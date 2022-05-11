import 'package:flutter_app/model/category.dart';

class Businesses {
  int? id;
  Category? category;
  String? name;
  String? description;
  String? phone;
  String? url;
  String? image;
  String? logo;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zip;
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
        this.phone,
        this.url,
        this.image,
        this.logo,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.zip,
        this.contributionAmount,
        this.contributionAmountMax,
        this.rating,
        this.totalContributions,
        this.createdAt});

  Businesses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    name = json['name'];
    description = json['description'];
    phone = json['phone'];
    url = json['url'];
    image = json['image'];
    logo = json['logo'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    contributionAmount = json['contribution_amount'];
    contributionAmountMax = json['contribution_amount_max'];
    rating = json['rating'];
    totalContributions = json['total_contributions'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['name'] = name;
    data['description'] = description;
    data['phone'] = phone;
    data['url'] = url;
    data['image'] = image;
    data['logo'] = logo;
    data['address_1'] = address1;
    data['address_2'] = address2;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['contribution_amount'] = contributionAmount;
    data['contribution_amount_max'] = contributionAmountMax;
    data['rating'] = rating;
    data['total_contributions'] = totalContributions;
    data['created_at'] = createdAt;
    return data;
  }
}
