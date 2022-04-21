import 'package:flutter/material.dart';

class Causes {
  String? backgroundImage;
  String? title;
  String? detail;
  String? icon;
  String? collectedAmount;
  String? totalAmount;
  String? date;
  String? endDate;
  List<Color>? colors;
  String? mainAddress;
  String? streetAddress;
  String? phoneNumber;
  String? backAmount;
  double? amount;

  Causes(
      {this.backgroundImage,
      this.title,
      this.detail,
      this.icon,
      this.collectedAmount,
      this.date,
      this.endDate,
      this.colors,
      this.mainAddress,
      this.streetAddress,
      this.phoneNumber,
      this.totalAmount,
      this.backAmount,
      this.amount});
}
