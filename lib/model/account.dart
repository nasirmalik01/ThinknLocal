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
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.groupCode,
        this.zip,
        this.contributionTotal,
        this.settings,
        this.history});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    groupCode = json['group_code'];
    zip = json['zip'];
    contributionTotal = json['contribution_total'];
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['group_code'] = this.groupCode;
    data['zip'] = this.zip;
    data['contribution_total'] = this.contributionTotal;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Settings {
  bool? pushNotifications;
  bool? weeklyUpdates;
  bool? receiptApprovals;
  bool? newsletters;

  Settings(
      {this.pushNotifications,
        this.weeklyUpdates,
        this.receiptApprovals,
        this.newsletters});

  Settings.fromJson(Map<String, dynamic> json) {
    pushNotifications = json['push_notifications'];
    weeklyUpdates = json['weekly_updates'];
    receiptApprovals = json['receipt_approvals'];
    newsletters = json['newsletters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['push_notifications'] = this.pushNotifications;
    data['weekly_updates'] = this.weeklyUpdates;
    data['receipt_approvals'] = this.receiptApprovals;
    data['newsletters'] = this.newsletters;
    return data;
  }
}

class History {
  String? date;
  int? amount;

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