import 'package:thinknlocal_app/model/history.dart';
import 'package:thinknlocal_app/model/settings.dart';

class Account {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? groupCode;
  String? zip;
  double? contributionTotal;
  Settings? settings;
  List<History>? history;

  Account(
      {id,
        firstName,
        lastName,
        email,
        groupCode,
        zip,
        contributionTotal,
        settings,
        history});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    groupCode = json['group_code'];
    zip = json['zip'];
    contributionTotal = json['contribution_total'];
    settings = json['settings'] != null
        ?  Settings.fromJson(json['settings'])
        : null;
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['group_code'] = groupCode;
    data['zip'] = zip;
    data['contribution_total'] = contributionTotal;
    if (settings != null) {
      data['settings'] = settings!.toJson();
    }
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}