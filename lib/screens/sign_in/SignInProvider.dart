
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../common/utils.dart';
import '../../res/strings.dart';
import '../bottom_tab/bottom_tab_new.dart';


class SignInProvider extends ChangeNotifier {
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
    if (PreferenceUtils.getString(Strings.loginEmail)!.isNotEmpty &&
        PreferenceUtils.getString(Strings.loginPassword)!.isNotEmpty) {
      Navigator.pushReplacement(context!,
          MaterialPageRoute(builder: (_) => BottomTabNew(pageIndex: 0)));
      FlutterNativeSplash.remove();
    } else {
      FlutterNativeSplash.remove();

    }
  }
}
