import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/model/businesses.dart';

List<Businesses> businessTabViewDataList = [
  Businesses(backgroundImage: Assets.dummyRestaurant, icon: Assets.dummyRestaurantLogo, title: "Chino Hills Pizza Co.", mainAddress: "Chino, CA 9170", streetAddress: "15705 Euclid Ave", phoneNumber: "909-254-7898"),
  Businesses(backgroundImage: Assets.businessContainerImage2, icon: Assets.dummyRestaurantLogo, title: "Chino Hills Pizza Co.", mainAddress: "Chino, CA 9170", streetAddress: "15705 Euclid Ave", phoneNumber: "909-254-7898"),
];

List<Businesses> recentlyStartedBusinessList = [
  Businesses(backgroundImage: Assets.dummyRestaurantShort, icon: Assets.dummyRestaurantShortLogo, title: 'It’s Yogurt'),
  Businesses(backgroundImage: Assets.recentlyStartedBusinessBg2, icon: Assets.recentlyStartedBusinessIcon2, title: 'Urban Fish Taco'),
  Businesses(backgroundImage: Assets.recentlyStartedBusinessBg3, icon: Assets.recentlyStartedBusinessIcon3, title: 'Rocky Mountain Chocolate Factory'),
  Businesses(backgroundImage: Assets.recentlyStartedBusinessBg2, icon: Assets.recentlyStartedBusinessIcon2, title: 'It’s Yogurt'),
];

List<Businesses> nearbyBusinessesList = [
  Businesses(backgroundImage: Assets.causesDetailFood1, title:  "Andy's Xpress Wash", mainAddress: "Chino, CA 91710", streetAddress: "15705 Euclid Ave", phoneNumber: "908-900-1791",),
  Businesses(backgroundImage: Assets.causesDetailFood2, title:  "Andy's Xpress Wash", mainAddress: "Chino, CA 91710", streetAddress: "15705 Euclid Ave", phoneNumber: "908-900-1791",),
  Businesses(backgroundImage: Assets.causesDetailFood3, title:  "Andy's Xpress Wash", mainAddress: "Chino, CA 91710", streetAddress: "15705 Euclid Ave", phoneNumber: "908-900-1791",),
  Businesses(backgroundImage: Assets.causesDetailFood1, title:  "Andy's Xpress Wash", mainAddress: "Chino, CA 91710", streetAddress: "15705 Euclid Ave", phoneNumber: "908-900-1791",),
  Businesses(backgroundImage: Assets.causesDetailFood2, title:  "Andy's Xpress Wash", mainAddress: "Chino, CA 91710", streetAddress: "15705 Euclid Ave", phoneNumber: "908-900-1791",),
  Businesses(backgroundImage: Assets.causesDetailFood3, title:  "Andy's Xpress Wash", mainAddress: "Chino, CA 91710", streetAddress: "15705 Euclid Ave", phoneNumber: "908-900-1791",),
];