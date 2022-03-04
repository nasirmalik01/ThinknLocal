import 'package:flutter/cupertino.dart';

class BottomTabProvider extends ChangeNotifier{
  int currentIndex = 0;
  BuildContext? context;

  init({@required BuildContext? context, @required int? index}){
    this.context = context;
    currentIndex = index!;
  }

  setCurrentIndex(int index){
    this.currentIndex = index;
    notifyListeners();
  }
}