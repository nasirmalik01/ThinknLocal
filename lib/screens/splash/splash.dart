import 'package:flutter/material.dart';
import 'package:flutter_app/screens/splash/splash_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  bool animated = false;
  late SplashProvider? _splashProvider;
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _splashProvider = Provider.of<SplashProvider>(context, listen: false);
    _splashProvider!.init(context: context);
  }
  @override
  void didChangeDependencies() {
    // initializeResources(context: context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    initializeResources(context: context);

    return Scaffold(
      //backgroundColor: AppColors.appBackground,
      body: Container(
        height: sizes!.height,
        width: sizes!.width,
        decoration: const BoxDecoration(
          color: Colors.white,

          // image: DecorationImage(
          //     image: AssetImage(Assets.appBgImage), fit: BoxFit.fill)
        ),
        child: Center(
          child: Container(
            // width: sizes!.widthRatio * 127.8,
            // height: sizes!.heightRatio * 137.6,
            child: Image.asset(Assets.logo),

          ),
        ),
      ),
    );
  }

}