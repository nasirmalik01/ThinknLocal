import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/model/dummy/business.dart';

List<Business> businessTabViewDataList = [
  Business(backgroundImage: Assets.dummyRestaurant, icon: Assets.dummyRestaurantLogo, title: "Chino Hills Pizza Co.", mainAddress: "Chino, CA 9170", streetAddress: "15705 Euclid Ave", phoneNumber: "909-254-7898"),
  Business(backgroundImage: Assets.businessContainerImage2, icon: Assets.dummyRestaurantLogo, title: "Chino Hills Pizza Co.", mainAddress: "Chino, CA 9170", streetAddress: "15705 Euclid Ave", phoneNumber: "909-254-7898"),
];

List<Business> recentlyStartedBusinessList = [
  Business(backgroundImage: Assets.dummyRestaurantShort, icon: Assets.dummyRestaurantShortLogo, title: 'It’s Yogurt'),
  Business(backgroundImage: Assets.recentlyStartedBusinessBg2, icon: Assets.recentlyStartedBusinessIcon2, title: 'Urban Fish Taco'),
  Business(backgroundImage: Assets.recentlyStartedBusinessBg3, icon: Assets.recentlyStartedBusinessIcon3, title: 'Rocky Mountain Chocolate Factory'),
  Business(backgroundImage: Assets.recentlyStartedBusinessBg2, icon: Assets.recentlyStartedBusinessIcon2, title: 'It’s Yogurt'),
];

List<Business> nearbyBusinessesList = [
  Business(backgroundImage: Assets.causesDetailFood1, title:  "Andy's Xpress Wash", mainAddress: "Chino, CA 91710", streetAddress: "15705 Euclid Ave", phoneNumber: "908-900-1791",),
  Business(backgroundImage: Assets.causesDetailFood2, title:  "Andy's Xpress Wash", mainAddress: "Chino, CA 91710", streetAddress: "15705 Euclid Ave", phoneNumber: "908-900-1791",),
  Business(backgroundImage: Assets.causesDetailFood3, title:  "Andy's Xpress Wash", mainAddress: "Chino, CA 91710", streetAddress: "15705 Euclid Ave", phoneNumber: "908-900-1791",),
  Business(backgroundImage: Assets.causesDetailFood1, title:  "Andy's Xpress Wash", mainAddress: "Chino, CA 91710", streetAddress: "15705 Euclid Ave", phoneNumber: "908-900-1791",),
  Business(backgroundImage: Assets.causesDetailFood2, title:  "Andy's Xpress Wash", mainAddress: "Chino, CA 91710", streetAddress: "15705 Euclid Ave", phoneNumber: "908-900-1791",),
  Business(backgroundImage: Assets.causesDetailFood3, title:  "Andy's Xpress Wash", mainAddress: "Chino, CA 91710", streetAddress: "15705 Euclid Ave", phoneNumber: "908-900-1791",),
];

List<Business> recentlyFundedBusinessList = [
  Business(title: 'Chino Hills High School Girls Softball Fundraiser', endDate: 'Mar 2nd', totalAmount: '450', raisedAmount: '342.61', backgroundImage: Assets.recentlyStarted1, icon: Assets.dummyLogo, color: [Colors.transparent, AppColors.greenColor,],),
  Business(title: 'Chino Hills High School Girls Softball Fundraiser', endDate: 'Mar 2nd', totalAmount: '450', raisedAmount: '342.61', backgroundImage: Assets.recentlyStarted2, icon: Assets.dummyLogo, color: [Colors.transparent, AppColors.lightPurpleColor,],),
  Business(title: 'Chino Hills High School Girls Softball Fundraiser', endDate: 'Mar 2nd', totalAmount: '450', raisedAmount: '342.61', backgroundImage: Assets.recentlyStarted3, icon: Assets.dummyLogo, color: [Colors.transparent, AppColors.lightOrangeColor,],),
];