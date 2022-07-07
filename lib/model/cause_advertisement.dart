import 'package:thinknlocal_app/model/cause_advertisement_business.dart';

class CauseAdvertisement {
  int? id;
  CauseAdvertisementBusiness? business;
  String? headline;
  String? summary;
  String? description;
  String? url;
  bool? featured;

  CauseAdvertisement(
      {this.id,
        this.business,
        this.headline,
        this.summary,
        this.description,
        this.url,
        this.featured,
      });

  CauseAdvertisement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    business = json['business'] != null
        ? CauseAdvertisementBusiness.fromJson(json['business'])
        : null;
    headline = json['headline'];
    summary = json['summary'];
    description = json['description'];
    url = json['url'];
    featured = json['featured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (business != null) {
      data['business'] = business!.toJson();
    }
    data['headline'] = headline;
    data['summary'] = summary;
    data['description'] = description;
    data['url'] = url;
    data['featured'] = featured;
    return data;
  }
}


