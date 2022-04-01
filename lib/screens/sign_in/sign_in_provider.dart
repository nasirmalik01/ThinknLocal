import 'package:flutter/material.dart';


class SignInProvider extends ChangeNotifier {
  BuildContext? context;

  init({@required BuildContext? context}) {
    this.context = context;
  }

}
