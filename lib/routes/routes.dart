import 'package:flutter_app/screens/on_boarding_page/on_boarding_page.dart';
import 'package:flutter_app/screens/sign_in/sign_in.dart';

class Routes {
  static const String splash = '/splash';
  static const String signIn = '/signIn';
  static const String onBoardingPage = '/onBoardingPage';

  static final routes = {
    signIn: (context) => const SignIn(),
    onBoardingPage: (context) => const OnBoardingPage(),
  };
}
