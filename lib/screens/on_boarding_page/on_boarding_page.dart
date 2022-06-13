import 'package:flutter/material.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/screens/on_boarding_page/on_boarding_page_layout.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../common/utils.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../constants/strings.dart';
import '../bottom_tab/bottom_tab_new.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  bool isHomeChecked = false;

  @override
  void initState() {
    isHomeChecked = false;
    navigateToNextScreen();
    PreferenceUtils.init();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeResources(context: context);

    return Scaffold(
      body: isHomeChecked ?  Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: getHeight() * 0),
            child: PageView(
              controller: controller,
              children: [
                const OnBoardingPageLayout(
                    isFirstPage: true,
                    heading: "Welcome!",
                    image: Assets.lastOnBoardingPageIcon,
                    subHeading: "Find a great cause!",
                    description: "Search for that great\n fundraiser you'd like to\n support.",
                    isOnBoarding3: false
                ),
                const OnBoardingPageLayout(
                    heading: "",
                    image: Assets.secondOnBoardingPageIcon,
                    subHeading: "Shop at participating business",
                    description: "Try new restaurants, visit the\n quaint ${"Mom & Pop"} &"
                        " Support\n local businesses while you help\n fund a worthy cause!",
                    isOnBoarding3: false
                ),
                OnBoardingPageLayout(
                    heading: "",
                    image: Assets.firstOnBoardingPageIcon,
                    subHeading: "Snap a photo of your receipt",
                    description: "Search for that great fundraiser\n you'd like to support.",
                    isOnBoarding3: true,
                    buttonText: "Get Started!",
                    onPressStartButton: (){
                      Get.offAndToNamed(Routes.locationPermissionScreen);
                    }
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: getHeight() * 0.09),
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                    spacing: getWidth() * 0.03,
                    dotColor: AppColors.greenColor,
                    activeDotColor: AppColors.greenColor,
                    dotHeight: 1.4.h,
                    dotWidth: 1.4.h,
                    paintStyle:  PaintingStyle.stroke,
                    strokeWidth: 2
                ),
                onDotClicked: (index) => controller.animateToPage(
                    index,
                    duration: const Duration(microseconds: 500),
                    curve: Curves.easeIn),
              ),
            ),
          ),
        ],
      ): Center(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.pureWhiteColor,
          ),
          child: Image.asset(Assets.horizontalLogo),
        ),
      ),
    );
  }
  void navigateToNextScreen() async {
    await Future.delayed(const Duration(
      seconds: 2,
    ));
    if (PreferenceUtils.getBool(Strings.showHome)) {
      Get.offAll(() => BottomTabNew(pageIndex: 0));
      FlutterNativeSplash.remove();
    } else {
      FlutterNativeSplash.remove();
      setState(() {
        isHomeChecked = true;
      });
    }
  }
}
