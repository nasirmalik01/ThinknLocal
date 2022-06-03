import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/screens/bottom_tab/account/account.dart';
import 'package:flutter_app/screens/bottom_tab/notifications/notifications.dart';
import 'package:flutter_app/screens/bottom_tab/scan/camera.dart';
import 'package:flutter_app/res/res.dart';
import 'package:get/get.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import 'businesses/businesses_screen.dart';
import 'causes/causes_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';



class BottomTabNew extends StatefulWidget {
  final int pageIndex;

  const BottomTabNew({Key? key, required this.pageIndex}) : super(key: key);

  @override
  _BottomTabNewState createState() => _BottomTabNewState();
}

class _BottomTabNewState extends State<BottomTabNew> {
  PersistentTabController? _controller;


    @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.pageIndex);
  }

  List<Widget> _buildScreens() {
    return [
      CausesScreen(),
      BusinessesScreen(),
      const InitializeCameraScreen(),
      const NotificationScreen(),
      AccountScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    initializeResources(context: context);

    return Stack(
      children: [
        PersistentTabView(
          context,
          bottomScreenMargin: getHeight() * 0.09,
          navBarHeight: getHeight() * 0.09,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset: false, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(getWidth() * 0.001),
            border: Border.all(color: AppColors.borderColor),
            colorBehindNavBar: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
            ],
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style17, // Choose the nav bar style with this property.

        ),
        Positioned(
          bottom: sizes.isPhone ? getHeight()*0.044 : getHeight()*0.05,
          left: sizes.isPhone ? getWidth()*0.405 : getWidth()*0.433,
          child:  GestureDetector(
            onTap: (){
              Get.to(() => const InitializeCameraScreen());
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: CircleAvatar(
                radius: sizes.isPhone ? 35 : 50,
                backgroundColor: AppColors.greenColor,
                child: Image(image: const AssetImage(Assets.scannerIcon), height: sizes.height * 0.05,),
              ),
            ),

          ),
        )
      ],
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: ImageIcon(const AssetImage(Assets.causeIcon), size: sizes.height * 0.1),
        title: Strings.causes,
        activeColorPrimary: AppColors.greenColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(const AssetImage(Assets.storeIcon), size: sizes.height * 0.1),
        title: Strings.businesses,
        activeColorPrimary: AppColors.greenColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(AssetImage(Assets.scannerIcon), color: AppColors.pureWhiteColor, size: 0),
        title: ("."),
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(const AssetImage(Assets.notificationIcon), size: sizes.height * 0.1),
        title: Strings.notifications,
        activeColorPrimary: AppColors.greenColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(const AssetImage(Assets.accountIcon), size: sizes.height * 0.1),
        title: Strings.account,
        activeColorPrimary: AppColors.greenColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
    ];
  }
}

class InitializeCameraScreen extends StatefulWidget {
  const InitializeCameraScreen({Key? key}) : super(key: key);

  @override
  State<InitializeCameraScreen> createState() => _InitializeCameraScreenState();
}

class _InitializeCameraScreenState extends State<InitializeCameraScreen> {
  late List<CameraDescription> allCameras;


  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

Future<void> initializeCamera() async {
  Future.delayed(100.milliseconds, () async {
    final bool _isUserAuthenticated = PreferenceUtils.isUserAuthenticated();
    if(!_isUserAuthenticated){
      userNotLoggedIn();
    }else {
      allCameras = await availableCameras();
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        pushNewScreen(
          context,
          screen: CameraScreen(camera: allCameras[0]),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      });
    }
  });
}
}
