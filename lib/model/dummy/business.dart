import 'package:flutter/material.dart';

class Business{
  String? backgroundImage;
  String? title;
  String? detail;
  String? icon;
  String? mainAddress;
  String? streetAddress;
  String? phoneNumber;
  String? joinDate;
  String? endDate;
  String? raisedAmount;
  String? totalAmount;
  bool? isFavorite;
  String? contributedAmount;
  List<Color>? color;

  Business(
      {this.backgroundImage,
      this.title,
      this.detail,
      this.icon,
      this.mainAddress,
      this.streetAddress,
      this.phoneNumber,
      this.joinDate,
      this.endDate,
      this.raisedAmount,
      this.totalAmount,
      this.isFavorite,
      this.contributedAmount,
      this.color});
}