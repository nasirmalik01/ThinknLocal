import 'package:flutter/material.dart';
import 'package:flutter_app/model/dummy/causess.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';

List<Cause> featuredCausesList = [
  Cause(backgroundImage: Assets.schoolDummy1, title: 'Chino Hills High School Girls Softall Fundraiser', icon: Assets.huskiesLogo, collectedAmount: "342.5", totalAmount: "450", endDate: "March 2nd"),
  Cause(backgroundImage: Assets.schoolDummy3, title: 'Chino Hills High School Girls Softall Fundraiser', icon: Assets.huskiesLogo, collectedAmount: "342.5", totalAmount: "450", endDate: "March 2nd"),
  Cause(backgroundImage: Assets.schoolDummy2, title: 'Chino Hills High School Girls Softall Fundraiser', icon: Assets.huskiesLogo, collectedAmount: "342.5", totalAmount: "450", endDate: "March 2nd"),
  Cause(backgroundImage: Assets.schoolDummy2, title: 'Chino Hills High School Girls Softall Fundraiser', icon: Assets.huskiesLogo, collectedAmount: "342.5", totalAmount: "450", endDate: "March 2nd"),
];

List<Cause> recentlyStartedCauseList = [
  Cause(backgroundImage: Assets.recentlyStarted1, title: 'Ayala High School Cheer Fundraiser', colors: [Colors.transparent, AppColors.greenColor,],),
  Cause(backgroundImage: Assets.recentlyStarted2, title: 'Ayala High School Cheer Fundraiser', colors: [Colors.transparent, AppColors.lightPurpleColor,],),
  Cause(backgroundImage: Assets.recentlyStarted3, title: 'Ayala High School Cheer Fundraiser', colors: [Colors.transparent, AppColors.lightOrangeColor,],),
  Cause(backgroundImage: Assets.recentlyStarted3, title: 'Ayala High School Cheer Fundraiser', colors: [Colors.transparent, AppColors.lightOrangeColor,],),
];
