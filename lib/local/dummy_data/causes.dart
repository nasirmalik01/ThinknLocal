import 'package:flutter/material.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';

List<Causes> featuredCausesList = [
  Causes(backgroundImage: Assets.schoolDummy1, title: 'Chino Hills High School Girls Softall Fundraiser', icon: Assets.huskiesLogo, collectedAmount: "342.5", totalAmount: "450", endDate: "March 2nd"),
  Causes(backgroundImage: Assets.schoolDummy3, title: 'Chino Hills High School Girls Softall Fundraiser', icon: Assets.huskiesLogo, collectedAmount: "342.5", totalAmount: "450", endDate: "March 2nd"),
  Causes(backgroundImage: Assets.schoolDummy2, title: 'Chino Hills High School Girls Softall Fundraiser', icon: Assets.huskiesLogo, collectedAmount: "342.5", totalAmount: "450", endDate: "March 2nd"),
  Causes(backgroundImage: Assets.schoolDummy2, title: 'Chino Hills High School Girls Softall Fundraiser', icon: Assets.huskiesLogo, collectedAmount: "342.5", totalAmount: "450", endDate: "March 2nd"),
];

List<Causes> recentlyStartedList = [
  Causes(backgroundImage: Assets.recentlyStarted1, title: 'Ayala High School Cheer Fundraiser', colors: [Colors.transparent, AppColors.greenColor,],),
  Causes(backgroundImage: Assets.recentlyStarted2, title: 'Ayala High School Cheer Fundraiser', colors: [Colors.transparent, AppColors.lightPurpleColor,],),
  Causes(backgroundImage: Assets.recentlyStarted3, title: 'Ayala High School Cheer Fundraiser', colors: [Colors.transparent, AppColors.lightOrangeColor,],),
  Causes(backgroundImage: Assets.recentlyStarted3, title: 'Ayala High School Cheer Fundraiser', colors: [Colors.transparent, AppColors.lightOrangeColor,],),
];
