import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/account/account.dart';
import 'package:flutter_app/screens/bottom_tab/bottom_tab_components.dart';
import 'package:flutter_app/screens/bottom_tab/notifications/notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/screens/bottom_tab/bottom_tab_provider.dart';
import 'package:flutter_app/res/res.dart';
import '../../res/assets.dart';
import '../../res/colors.dart';
import 'businesses/businesses.dart';
import 'causes/causes.dart';


class BottomTab extends StatefulWidget {
  int pageIndex;

  BottomTab({Key? key, required this.pageIndex}) : super(key: key);

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {

  int _currentIndex = 0;
  BottomTabProvider? _bottomTabProvider;
  BottomTabComponents? _bottomTabComponents = BottomTabComponents();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomTabProvider = Provider.of<BottomTabProvider>(context, listen: false);
    _bottomTabProvider?.init(context: context, index: widget.pageIndex);

  }


  _currentPage() {
    if (_bottomTabProvider?.currentIndex == 0) {
      return const Causes();
    }
    if (_bottomTabProvider?.currentIndex == 1) {
      return const Businesses();
    }
    if (_bottomTabProvider?.currentIndex == 2) {
      return const Notifications();
    }
    if (_bottomTabProvider?.currentIndex == 3) {
      return const Account();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  Widget build(BuildContext context) {
    Provider.of<BottomTabProvider>(context, listen: true);
    return Scaffold(

      body: Container(
        child: _currentPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.greenColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          //color: AppColors.greenColor,
            fontSize: sizes!.fontSize13 ),
        unselectedLabelStyle: TextStyle(
          //color:  Colors.grey,
            fontSize: sizes!.fontSize13),

        onTap: (index) {
          setState(() {
            _bottomTabProvider?.setCurrentIndex(index);
            _onItemTapped(_bottomTabProvider?.currentIndex?? 0);
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: _bottomTabComponents?.getBottomTabIcons(
                  icon: Assets.causeIcon,
                  color: _bottomTabProvider?.currentIndex == 0? AppColors.greenColor: Colors.grey,
                ),
              ),


              label: 'Causes'
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(6.0),
              child: _bottomTabComponents?.getBottomTabIcons(
                icon: Assets.storeIcon,
                color: _bottomTabProvider?.currentIndex == 1? AppColors.greenColor: Colors.grey,
              ),
            ),
            label: 'Businesses',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(6.0),
              child: _bottomTabComponents?.getBottomTabIcons(
                icon: Assets.notificationIcon,
                color: _bottomTabProvider?.currentIndex == 2? AppColors.greenColor: Colors.grey,
              ),
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(6.0),
              child: _bottomTabComponents?.getBottomTabIcons(
                icon: Assets.accountIcon,
                color: _bottomTabProvider?.currentIndex == 3? AppColors.greenColor: Colors.grey,
              ),
            ),
            label: 'Account',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}