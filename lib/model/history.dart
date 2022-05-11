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