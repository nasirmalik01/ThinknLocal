import 'package:flutter_app/screens/businesses_detail/businesses_detail.dart';
import 'package:flutter_app/screens/businesses_nearby/businesses_nearby.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail.dart';
import 'package:flutter_app/screens/causes_upcoming/causes_upcoming.dart';
import 'package:flutter_app/screens/edit_account/edit_account.dart';
import 'package:flutter_app/screens/on_boarding_page/on_boarding_page.dart';
import 'package:flutter_app/screens/password/reset_password/reset_password.dart';
import 'package:flutter_app/screens/sign_in/sign_in.dart';
import 'package:flutter_app/screens/sign_up/sign_up.dart';
import 'package:flutter_app/screens/unknown_route.dart';
import 'package:get/get.dart';


class Routes {
  static const String noPageFound = '/noPageFound';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String editAccountInfoScreen = '/editAccountInfoScreen';
  static const String causesDetailScreen = '/causesDetailScreen';
  static const String businessDetailScreen = '/businessDetailScreen';
  static const String businessCategoryScreen = '/businessCategoryScreen';
  static const String seeAllUpcomingCausesScreen = '/seeAllUpcomingCausesScreen';
  static const String seeAllNearbyBusinessesScreen = '/seeAllNearbyBusinessesScreen';


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
        page: () => const LoginScreen(),
      ),
      GetPage(
        name: signUpScreen,
        page: () => const SignUpScreen(),
      ),
      GetPage(
        name: resetPasswordScreen,
        page: () => const ResetPassword(),
      ),
      GetPage(
        name: editAccountInfoScreen,
        page: () => const EditAccount(),
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
