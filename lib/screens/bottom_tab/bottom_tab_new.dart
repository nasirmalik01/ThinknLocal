import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/account/account.dart';
import 'package:flutter_app/screens/bottom_tab/notifications/notifications.dart';
import 'package:flutter_app/screens/bottom_tab/scan/scan.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/screens/bottom_tab/bottom_tab_provider.dart';
import 'package:flutter_app/res/res.dart';
import '../../res/assets.dart';
import '../../res/colors.dart';
import 'businesses/businesses.dart';
import 'causes/causes.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';


class BottomTabNew extends StatefulWidget {
  int pageIndex;

  BottomTabNew({Key? key, required this.pageIndex}) : super(key: key);

  @override
  _BottomTabNewState createState() => _BottomTabNewState();
}

class _BottomTabNewState extends State<BottomTabNew> {
  PersistentTabController? _controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.pageIndex);

  }


  List<Widget> _buildScreens() {
    return [
      const Causes(),
      const Businesses(),
      const Scan(),
      const Notifications(),
      const Account()
    ];
  }


  @override
  Widget build(BuildContext context) {
    Provider.of<BottomTabProvider>(context, listen: true);
    return PersistentTabView(
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
      navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: ImageIcon(const AssetImage(Assets.causeIcon), size: sizes.height * 0.1),
        title: ("Causes"),
        activeColorPrimary: AppColors.greenColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(const AssetImage(Assets.storeIcon), size: sizes.height * 0.1),
        title: ("Businesses"),
        activeColorPrimary: AppColors.greenColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(const AssetImage(Assets.scannerIcon), color: AppColors.pureWhiteColor, size: sizes.height * 0.04),
        title: ("."),
        activeColorPrimary: AppColors.greenColor,
        inactiveColorPrimary: AppColors.darkGrey,

      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(const AssetImage(Assets.notificationIcon), size: sizes.height * 0.1),
        title: ("Notifications"),
        activeColorPrimary: AppColors.greenColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(const AssetImage(Assets.accountIcon), size: sizes.height * 0.1),
        title: ("Account"),
        activeColorPrimary: AppColors.greenColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
    ];
  }
}