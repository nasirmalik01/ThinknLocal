
import 'package:flutter_app/screens/sign_in/sign_in.dart';

import '../screens/splash/splash.dart';


class Routes {
  static const String splash = '/splash';
  static const String signIn = '/signIn';
  //static const String bottomTab = '/bottomTab';


  static final routes = {
    splash: (context) => const Splash(),
    signIn: (context) => const SignIn(),
    //splash: (context) => const BottomTab(),

  };
}
