
import 'package:flutter/cupertino.dart';



class ScanProvider extends ChangeNotifier {
  BuildContext? context;

  init({@required BuildContext? context}) {
    this.context = context;
  }
}
