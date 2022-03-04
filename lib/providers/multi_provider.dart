import 'package:flutter_app/screens/bottom_tab/bottom_tab_provider.dart';
import 'package:provider/provider.dart';

import '../screens/splash/splash_provider.dart';

final multiProviders = [
  ChangeNotifierProvider<SplashProvider>(
    create: (_) => SplashProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<BottomTabProvider>(
    create: (_) => BottomTabProvider(),
    lazy: true,
  ),
];
