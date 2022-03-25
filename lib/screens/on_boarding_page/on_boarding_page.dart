import 'package:flutter/material.dart';
import 'package:flutter_app/screens/on_boarding_page/on_boarding_page_components.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../common/utils.dart';
import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../res/strings.dart';
import '../../widgets/text_views.dart';
import '../bottom_tab/bottom_tab_new.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  OnBoardingPageComponents onBoardingPageComponents = OnBoardingPageComponents();
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
      body: isHomeChecked ?  Container(
        padding: EdgeInsets.only(bottom: getHeight() * 0.1),
        child: PageView(
          controller: controller,
          children: [
            onBoardingPageComponents.getPageContainer(
                heading: "Welcome!",
                image: Assets.onBoarding3,
                subHeading: "Find a great cause!",
                description: "Search for that great\n fundraiser you'd like to\n support.",
                isOnBoarding3: false
            ),
            onBoardingPageComponents.getPageContainer(
                heading: "",
                image: Assets.onBoarding2,
                subHeading: "Shop at participating business",
                description: "Try new restaurants, visit the\n quaint ${"Mom & Pop"} &"
                    " Support\n local businesses while you help\n fund a worthy cause!",
                isOnBoarding3: false
            ),
            onBoardingPageComponents.getPageContainer(
                heading: "",
                image: Assets.onBoarding1,
                subHeading: "Snap a photo of your receipt",
                description: "Search for that great fundraiser\n you'd like to support.",
                isOnBoarding3: true,
                buttonText: "Get Started!",
                onPressStartButton: (){
                  PreferenceUtils.setBool(Strings.showHome, true);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => BottomTabNew(pageIndex: 0)));
                }
            ),
          ],
        ),
      ): Center(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.pureWhiteColor,
          ),
          child: Image.asset(Assets.logo),
        ),
      ),
      bottomSheet: isHomeChecked ? Container(
        padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.06),
        height: getHeight() * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  PreferenceUtils.setBool(Strings.showHome, true);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => BottomTabNew(pageIndex: 0)));
                },
                child: TextView.bold15Text('Skip',
                    color: AppColors.greenColor, fontFamily: Assets.poppinsMedium),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  spacing: getWidth() * 0.03,
                  dotColor: AppColors.darkGrey,
                  activeDotColor: AppColors.greenColor
                ),
                onDotClicked: (index) => controller.animateToPage(
                    index,
                    duration: const Duration(microseconds: 500),
                    curve: Curves.easeIn),
              ),
            ),
            TextButton(
                onPressed: () {
                  controller.nextPage(
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeInOut);
                },
                child: TextView.bold15Text('Next',
                    color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
            ),
          ],
        ),
      ): Center(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.pureWhiteColor,
          ),
          child: SizedBox(
            height: getHeight() * 0.01,
              width: getWidth() * 0.6,
              child: Image.asset(Assets.logo)),
        ),
      ),
    );
  }
  void navigateToNextScreen() async {
    await Future.delayed(const Duration(
      seconds: 2,
    ));
    if (PreferenceUtils.getBool(Strings.showHome)) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => BottomTabNew(pageIndex: 0)));
      FlutterNativeSplash.remove();


    } else {
      FlutterNativeSplash.remove();
      setState(() {
        isHomeChecked = true;
      });
    }
  }
}
