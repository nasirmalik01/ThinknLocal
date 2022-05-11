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
