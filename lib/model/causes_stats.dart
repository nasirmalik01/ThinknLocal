import 'package:flutter_app/model/top_contributors.dart';
import 'history.dart';

class CausesStats {
  List<History>? history;
  List<TopContributors>? topContributors;

  CausesStats({history, topContributors});

  CausesStats.fromJson(Map<String, dynamic> json) {
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
    if (json['top_contributors'] != null) {
      topContributors = <TopContributors>[];
      json['top_contributors'].forEach((v) {
        topContributors!.add(TopContributors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    if (topContributors != null) {
      data['top_contributors'] =
          topContributors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}