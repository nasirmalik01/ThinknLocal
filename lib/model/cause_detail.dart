import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/model/organization.dart';

class CauseDetail {
  int? id;
  Category? category;
  Organization? organization;
  String? name;
  String? description;
  String? image;
  double? goal;
  double? raised;
  double? remaining;
  String? goalProbability;
  int? contributors;
  String? start;
  int? daysTillStart;
  String? end;
  int? daysRemaining;

  CauseDetail(
      {this.id,
      this.category,
      this.organization,
      this.name,
      this.description,
      this.image,
      this.goal,
      this.raised,
      this.remaining,
      this.goalProbability,
      this.contributors,
      this.start,
      this.daysTillStart,
      this.end,
      this.daysRemaining});

  CauseDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
    name = json['name'];
    description = json['description'];
    image = json['image'];
    goal = json['goal'];
    raised = json['raised'];
    remaining = json['remaining'];
    goalProbability = json['goal_probability'];
    contributors = json['contributors'];
    start = json['start'];
    daysTillStart = json['days_till_start'];
    end = json['end'];
    daysRemaining = json['days_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['goal'] = this.goal;
    data['raised'] = this.raised;
    data['remaining'] = this.remaining;
    data['goal_probability'] = this.goalProbability;
    data['contributors'] = this.contributors;
    data['start'] = this.start;
    data['days_till_start'] = this.daysTillStart;
    data['end'] = this.end;
    data['days_remaining'] = this.daysRemaining;
    return data;
  }
}
