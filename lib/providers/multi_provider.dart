import 'package:flutter_app/screens/bottom_tab/bottom_tab_provider.dart';
import 'package:flutter_app/screens/bottom_tab/scan/scan_provider.dart';
import 'package:provider/provider.dart';
import '../screens/sign_in/SignInProvider.dart';

final multiProviders = [
  ChangeNotifierProvider<BottomTabProvider>(
    create: (_) => BottomTabProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<SignInProvider>(
    create: (_) => SignInProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<ScanProvider>(
    create: (_) => ScanProvider(),
    lazy: true,
  ),
];
