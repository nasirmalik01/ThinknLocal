import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/model/organization.dart';

class Causes {
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
  bool? isFavorite;

  Causes(
      {
        id,
        category,
        organization,
        name,
        description,
        image,
        goal,
        raised,
        remaining,
        goalProbability,
        contributors,
        start,
        daysTillStart,
        end,
        daysRemaining,
        isFavorite = false
      });

  Causes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ?  Category.fromJson(json['category'])
        : null;
    organization = json['organization'] != null
        ?  Organization.fromJson(json['organization'])
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
    isFavorite = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (organization != null) {
      data['organization'] = organization!.toJson();
    }
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['goal'] = goal;
    data['raised'] = raised;
    data['remaining'] = remaining;
    data['goal_probability'] = goalProbability;
    data['contributors'] = contributors;
    data['start'] = start;
    data['days_till_start'] = daysTillStart;
    data['end'] = end;
    data['days_remaining'] = daysRemaining;
    return data;
  }
}
