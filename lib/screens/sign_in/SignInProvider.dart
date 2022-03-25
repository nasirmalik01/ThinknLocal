
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../common/utils.dart';
import '../../res/strings.dart';
import '../bottom_tab/bottom_tab_new.dart';


class SignInProvider extends ChangeNotifier {
  BuildContext? context;

  init({@required BuildContext? context}) {
    this.context = context;
  }

}
