import 'package:flutter/cupertino.dart';

class FeaturedCauses{
  String backgroundImage;
  String title;
  String icon;
  String collectedAmount;
  String totalAmount;
  String endDate;

  FeaturedCauses({required this.backgroundImage, required this.title, required this.icon, required this.collectedAmount, required this.totalAmount, required this.endDate});
}

class RecentlyStarted{
  String backgroundImage;
  String title;
  List<Color> colors;

  RecentlyStarted({required this.backgroundImage, required this.title, required this.colors});
}