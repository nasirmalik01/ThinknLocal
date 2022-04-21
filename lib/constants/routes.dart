import 'package:flutter_app/screens/bottom_tab/bottom_tab_new.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/businesses_screen.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_screen.dart';
import 'package:flutter_app/screens/businesses_detail/businesses_detail.dart';
import 'package:flutter_app/screens/businesses_nearby/businesses_nearby.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail.dart';
import 'package:flutter_app/screens/causes_upcoming/causes_upcoming.dart';
import 'package:flutter_app/screens/edit_account/edit_account.dart';
import 'package:flutter_app/screens/location_permission/location_permission_screen.dart';
import 'package:flutter_app/screens/notification_permission/notification_permission_screen.dart';
import 'package:flutter_app/screens/on_boarding_page/on_boarding_page.dart';
import 'package:flutter_app/screens/password/new_password/new_password.dart';
import 'package:flutter_app/screens/password/password_pin/reset_password_pin.dart';
import 'package:flutter_app/screens/password/password_success/reset_password_success.dart';
import 'package:flutter_app/screens/password/reset_password/reset_password.dart';
import 'package:flutter_app/screens/sign_in/login_screen.dart';
import 'package:flutter_app/screens/sign_up/sign_up.dart';
import 'package:flutter_app/screens/unknown_route.dart';
import 'package:get/get.dart';

class Routes {
  static const String noPageFound = '/noPageFound';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String resetPinScreen = '/resetPinScreen';
  static const String newPasswordScreen = '/newPasswordScreen';
  static const String resetPasswordSuccessScreen = '/resetPasswordSuccessScreen';
  static const String editAccountInfoScreen = '/editAccountInfoScreen';
  static const String bottomNavBarScreen = '/bottomNavBarScreen';
  static const String causeScreen = '/causeScreen';
  static const String businessScreen = '/businessScreen';
  static const String causesDetailScreen = '/causesDetailScreen';
  static const String businessDetailScreen = '/businessDetailScreen';
  static const String businessCategoryScreen = '/businessCategoryScreen';
  static const String seeAllUpcomingCausesScreen = '/seeAllUpcomingCausesScreen';
  static const String seeAllNearbyBusinessesScreen = '/seeAllNearbyBusinessesScreen';
  static const String locationPermissionScreen = '/locationPermissionScreen';
  static const String notificationPermissionScreen = '/notificationPermissionScreen';


  static getUnknownRoute() {
    return GetPage(
      name: noPageFound,
      page: () => const UnknownRoutePage(),
      transition: Transition.zoom,
    );
  }

  static getInitialRoute() {
    return onBoardingScreen;
  }

  static getPages() {
    return [
      GetPage(
        name: onBoardingScreen,
        page: () => const OnBoardingPage(),
      ),
      GetPage(
        name: loginScreen,
        page: () => LoginScreen(),
      ),
      GetPage(
        name: signUpScreen,
        page: () => const SignUpScreen(),
      ),
      GetPage(
        name: resetPasswordScreen,
        page: () => ResetPassword(),
      ),
      GetPage(
        name: resetPinScreen,
        page: () => const ResetPinScreen(),
      ),
      GetPage(
        name: newPasswordScreen,
        page: () => const NewPassword(),
      ),
      GetPage(
        name: resetPasswordSuccessScreen,
        page: () => const ResetPasswordSuccessScreen(),
      ),
      GetPage(
        name: editAccountInfoScreen,
        page: () => const EditAccount(),
      ),
      GetPage(
          name: bottomNavBarScreen,
          page: () => const BottomTabNew(pageIndex: 0,),
      ),
      GetPage(
        name: causeScreen,
        page: () => CausesScreen(),
      ),
      GetPage(
        name: businessScreen,
        page: () => BusinessesScreen(),
      ),
      GetPage(
        name: causesDetailScreen,
        page: () => const CausesDetail(),
      ),
      GetPage(
        name: businessDetailScreen,
        page: () => const BusinessesDetail(),
      ),
      GetPage(
        name: seeAllUpcomingCausesScreen,
        page: () => const CausesUpcoming(),
      ),
      GetPage(
        name: seeAllNearbyBusinessesScreen,
        page: () => const BusinessesNearBy(),
      ),
      GetPage(
        name: locationPermissionScreen,
        page: () => const LocationPermissionScreen(),
      ),
      GetPage(
        name: notificationPermissionScreen,
        page: () => const NotificationPermissionScreen(),
      ),
    ];
  }

  static to(String route, {Map<String, dynamic>? arguments}) =>
      Get.toNamed(route, arguments: arguments);

  static offAllTo(String route, {Map<String, dynamic>? arguments}) =>
      Get.offAllNamed(route, arguments: arguments);

  static offTo(String route, {Map<String, dynamic>? arguments}) =>
      Get.offNamed(route, arguments: arguments);

  static back() => Get.back();
}
