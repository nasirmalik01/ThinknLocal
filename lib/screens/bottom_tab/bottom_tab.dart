
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/account/account.dart';
import 'package:flutter_app/screens/bottom_tab/notifications/notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/screens/bottom_tab/bottom_tab_provider.dart';

import 'businesses/businesses.dart';
import 'courses/courses.dart';

class BottomTab extends StatefulWidget {
  int pageIndex;

  BottomTab({Key? key, required this.pageIndex}) : super(key: key);

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  
  int _currentIndex = 0;
  BottomTabProvider? _bottomTabProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomTabProvider = Provider.of<BottomTabProvider>(context, listen: false);
    _bottomTabProvider?.init(context: context, index: widget.pageIndex);
    
  }


  _currentPage() {
    if (_bottomTabProvider?.currentIndex == 0) {
      return const Courses();
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


  Widget build(BuildContext context) {
    Provider.of<BottomTabProvider>(context, listen: true);
    return Scaffold(

      body: Container(
        child: _currentPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(

        onTap: (index) {
          setState(() {
            _bottomTabProvider?.setCurrentIndex(index);
          });
        },
        currentIndex: _currentIndex,
        items: [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home,
          //       size: 30,
          //       color: _bottomTabProvider?.currentIndex==0? AppColors.blueTextColor: Colors.grey ),
          //
          //   title: Text(getTranslated(context, 'homeText')?? "",style: TextStyle(color: _tabNavigationProvider?.currentIndex==0? AppColors.blueTextColor: Colors.grey,fontSize: sizes.smallFontSize),),
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.restore_outlined,
          //       size: 30,
          //       color: _tabNavigationProvider?.currentIndex==1? AppColors.blueTextColor: Colors.grey),
          //   title: Text(getTranslated(context, 'biddingHistoryText')?? "",style: TextStyle(color: _tabNavigationProvider?.currentIndex==1? AppColors.blueTextColor: Colors.grey, fontSize: sizes.smallFontSize),),
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.perm_identity_outlined,
          //       size: 30,
          //       color: _tabNavigationProvider?.currentIndex==2? AppColors.blueTextColor: Colors.grey),
          //   title: Text(getTranslated(context, 'profileText')?? "",style: TextStyle(color: _tabNavigationProvider?.currentIndex==2? AppColors.blueTextColor: Colors.grey, fontSize: sizes.smallFontSize),),
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.perm_identity_outlined,
          //       size: 30,
          //       color: _tabNavigationProvider?.currentIndex==2? AppColors.blueTextColor: Colors.grey),
          //   title: Text(getTranslated(context, 'profileText')?? "",style: TextStyle(color: _tabNavigationProvider?.currentIndex==2? AppColors.blueTextColor: Colors.grey, fontSize: sizes.smallFontSize),),
          // ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
