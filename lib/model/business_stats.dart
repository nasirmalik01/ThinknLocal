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

class History {
  String? date;
  dynamic amount;

  History({date, amount});

  History.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['date'] = date;
    data['amount'] = amount;
    return data;
  }
}

class RecentContributions {
  String? name;
  double? amount;
  String? date;

  RecentContributions({name, amount, date});

  RecentContributions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['amount'] = amount;
    data['date'] = date;
    return data;
  }
}