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

class History {
  String? date;
  dynamic amount;

  History({date, amount});

  History.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['amount'] = amount;
    return data;
  }
}

class TopContributors {
  String? name;
  double? amount;
  String? date;

  TopContributors({name, amount, date});

  TopContributors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['amount'] = amount;
    data['date'] = date;
    return data;
  }
}
