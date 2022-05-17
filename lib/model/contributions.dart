import 'package:flutter_app/model/business.dart';

class Contributions {
  int? id;
  double? amount;
  String? status;
  String? reason;
  int? rating;
  double? receiptAmount;
  String? receiptDate;
  String? receiptUrl;
  Business? business;
  Business? cause;

  Contributions(
      {this.id,
        this.amount,
        this.status,
        this.reason,
        this.rating,
        this.receiptAmount,
        this.receiptDate,
        this.receiptUrl,
        this.business,
        this.cause});

  Contributions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    status = json['status'];
    reason = json['reason'];
    rating = json['rating'];
    receiptAmount = json['receipt_amount'];
    receiptDate = json['receipt_date'];
    receiptUrl = json['receipt_url'];
    business = json['business'] != null
        ? Business.fromJson(json['business'])
        : null;
    cause = json['cause'] != null ? Business.fromJson(json['cause']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['status'] = status;
    data['reason'] = reason;
    data['rating'] = rating;
    data['receipt_amount'] = receiptAmount;
    data['receipt_date'] = receiptDate;
    data['receipt_url'] = receiptUrl;
    if (business != null) {
      data['business'] = business!.toJson();
    }
    if (cause != null) {
      data['cause'] = cause!.toJson();
    }
    return data;
  }
}

