import 'package:thinknlocal_app/model/history.dart';
import 'package:thinknlocal_app/model/recent_contributions.dart';

class BusinessStats {
  List<History>? history;
  List<RecentContributions>? recentContributions;

  BusinessStats({history, recentContributions});

  BusinessStats.fromJson(Map<String, dynamic> json) {
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add( History.fromJson(v));
      });
    }
    if (json['recent_contributions'] != null) {
      recentContributions = <RecentContributions>[];
      json['recent_contributions'].forEach((v) {
        recentContributions!.add( RecentContributions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    if (recentContributions != null) {
      data['recent_contributions'] =
          recentContributions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
