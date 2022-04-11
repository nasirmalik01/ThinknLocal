// import 'package:flutter/cupertino.dart';
// import 'account/account.dart';
// import 'businesses/businesses.dart';
// import 'causes/causes.dart';
// import 'notifications/notifications.dart';
//
// class BottomTabProvider extends ChangeNotifier{
//   int currentIndex = 0;
//   BuildContext? context;
//
//   init({@required BuildContext? context, @required int? index}){
//     this.context = context;
//     currentIndex = index!;
//   }
//
//   setCurrentIndex(int index){
//     currentIndex = index;
//     notifyListeners();
//   }
//
//   List screens=[
//     const Causes(),
//     const Businesses(),
//     const Notifications(),
//     const Account()
//   ];
// }