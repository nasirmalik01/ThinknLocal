
import 'package:flutter/cupertino.dart';

import '../../animations/slide_right.dart';
import '../../common/utils.dart';
import '../../res/strings.dart';
import '../welcome/welcome.dart';

class SplashProvider extends ChangeNotifier {
  BuildContext? context;

  init({@required BuildContext? context}) {
    PreferenceUtils.init();
    this.context = context;
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(
      seconds: 3,
    ));
    if (PreferenceUtils.getString(Strings.loginName)!.isNotEmpty &&
        PreferenceUtils.getString(Strings.loginPassword)!.isNotEmpty) {
      Navigator.pushReplacement(
          context!, SlideRightRoute(page: const Welcome()));
    } else {
      Navigator.pushReplacement(context!, SlideRightRoute(page: const Welcome()));
    }
  }
}
