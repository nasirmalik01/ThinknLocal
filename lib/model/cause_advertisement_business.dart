import 'package:thinknlocal_app/model/category.dart';

class CauseAdvertisementBusiness {
  int? id;
  Category? category;
  String? name;
  String? description;
  String? phone;
  dynamic url;
  String? image;
  String? logo;
  String? contributionAmount;
  String? contributionAmountMax;

  CauseAdvertisementBusiness(
      {this.id,
        this.category,
        this.name,
        this.description,
        this.phone,
        this.url,
        this.image,
        this.logo,
        this.contributionAmount,
        this.contributionAmountMax
      });

  CauseAdvertisementBusiness.fromJson(Map<String, dynamic> json) {
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
    contributionAmount = json['contribution_amount'];
    contributionAmountMax = json['contribution_amount_max'];
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
    data['contribution_amount'] = contributionAmount;
    data['contribution_amount_max'] = contributionAmountMax;
    return data;
  }
}