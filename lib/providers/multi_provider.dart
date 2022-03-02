import 'package:provider/provider.dart';

import '../screens/splash/splash_provider.dart';

final multiProviders = [
  ChangeNotifierProvider<SplashProvider>(
    create: (_) => SplashProvider(),
    lazy: true,
  ),
];
