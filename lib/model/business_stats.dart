class BusinessStats {
  List<History>? history;
  List<RecentContributions>? recentContributions;

  BusinessStats({this.history, this.recentContributions});

  BusinessStats.fromJson(Map<String, dynamic> json) {
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(new History.fromJson(v));
      });
    }
    if (json['recent_contributions'] != null) {
      recentContributions = <RecentContributions>[];
      json['recent_contributions'].forEach((v) {
        recentContributions!.add(new RecentContributions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    if (this.recentContributions != null) {
      data['recent_contributions'] =
          this.recentContributions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  String? date;
  dynamic amount;

  History({this.date, this.amount});

  History.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['amount'] = this.amount;
    return data;
  }
}

class RecentContributions {
  String? name;
  double? amount;
  String? date;

  RecentContributions({this.name, this.amount, this.date});

  RecentContributions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['date'] = this.date;
    return data;
  }
}