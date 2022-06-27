class Settings {
  bool? pushNotifications;
  bool? weeklyUpdates;
  bool? receiptApprovals;
  bool? newsletters;

  Settings(
      {pushNotifications,
        weeklyUpdates,
        receiptApprovals,
        newsletters});

  Settings.fromJson(Map<String, dynamic> json) {
    pushNotifications = json['push_notifications'];
    weeklyUpdates = json['weekly_updates'];
    receiptApprovals = json['receipt_approvals'];
    newsletters = json['newsletters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['push_notifications'] = pushNotifications;
    data['weekly_updates'] = weeklyUpdates;
    data['receipt_approvals'] = receiptApprovals;
    data['newsletters'] = newsletters;
    return data;
  }
}