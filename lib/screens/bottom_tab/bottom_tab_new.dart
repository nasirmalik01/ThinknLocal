import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import 'package:thinknlocal_app/common/main_controller.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/common/utils.dart';
import 'package:thinknlocal_app/constants/routes.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/screens/bottom_tab/account/account.dart';
import 'package:thinknlocal_app/screens/bottom_tab/notifications/notifications.dart';
import 'package:thinknlocal_app/screens/bottom_tab/scan/camera.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import 'businesses/businesses_screen.dart';
import 'causes/causes_screen.dart';

class BottomTabNew extends StatefulWidget {
  final int pageIndex;
  const BottomTabNew({Key? key, required this.pageIndex}) : super(key: key);

  @override
  _BottomTabNewState createState() => _BottomTabNewState();
}

class _BottomTabNewState extends State<BottomTabNew> {
  final MainController _mainController = Get.put(MainController());

  @override
  void initState() {
    super.initState();
    _mainController.controller =
        PersistentTabController(initialIndex: widget.pageIndex);
    Future.delayed(10.milliseconds);
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
    return Stack(
      children: [
        PersistentTabView(
          context,
          bottomScreenMargin: getHeight() * 0.09,
          navBarHeight: getHeight() * 0.09,
          controller: _mainController.controller,
          onItemSelected: (index) {
            setState(() {});
          },
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              false, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(getWidth() * 0.001),
            border: Border.all(color: AppColors.borderColor),
            colorBehindNavBar: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 0,
                offset: Offset(0, 0),
              ),
            ],
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style17, // Choose the nav bar style with this property.
        ),
      ],
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(Assets.causesSvg,
            height: sizes.height * 0.038,
            width: sizes.height * 0.038,
            color: _mainController.controller!.index == 0
                ? AppColors.greenColor
                : AppColors.darkGrey),
        title: Strings.causes,
        activeColorPrimary: AppColors.greenColor,
        textStyle: TextStyle(fontSize: 8.5.sp),
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(Assets.businessSvg,
            height: sizes.height * 0.038,
            width: sizes.height * 0.038,
            color: _mainController.controller!.index == 1
                ? AppColors.greenColor
                : AppColors.darkGrey),
        title: Strings.businesses,
        activeColorPrimary: AppColors.greenColor,
        textStyle: TextStyle(fontSize: 8.5.sp),
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Transform.scale(
            scale: 1.3,
            child: Image.asset(
              Assets.cameraScan,
              fit: BoxFit.contain,
            )),
        title: '',
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.notificationSvg,
          height: sizes.height * 0.038,
          width: sizes.height * 0.038,
          color: _mainController.controller!.index == 3
              ? AppColors.greenColor
              : AppColors.darkGrey,
        ),
        title: Strings.notifications,
        activeColorPrimary: AppColors.greenColor,
        textStyle: TextStyle(fontSize: 8.5.sp),
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.accountSvg,
          height: sizes.height * 0.038,
          width: sizes.height * 0.038,
          color: _mainController.controller!.index == 4
              ? AppColors.greenColor
              : AppColors.darkGrey,
        ),
        title: Strings.account,
        textStyle: TextStyle(fontSize: 8.5.sp),
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
      if (!_isUserAuthenticated) {
        userNotLoggedIn();
      } else {
        PermissionStatus cameraStatus = await Permission.camera.status;
        if (cameraStatus == PermissionStatus.permanentlyDenied) {
          return Get.offAndToNamed(Routes.cameraPermissionScreen);
        }
        allCameras = await availableCameras();
        WidgetsBinding.instance.addPostFrameCallback((_) {
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
