import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/notifications/notification_components.dart';
import 'package:flutter_app/widgets/text_views.dart';

import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';


class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>  with SingleTickerProviderStateMixin {
  TabController? _tabController;
  NotificationComponents? _notificationComponents = NotificationComponents();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.appBackground,
        body: GestureDetector(
          onTap: () {

          },
          child: Container(
            height: sizes!.height,
            width: sizes!.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: getHeight() * 0.1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.gradientColor1,
                        AppColors.pureWhiteColor,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes!.width * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView.bold25Text("Your Notifications", color: AppColors.lightBlack, fontFamily: Assets.latoBold),
                      SizedBox(height: getHeight() * 0.01),
                      TextView.getMediumText15("Want to edit your notification settings?", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular),
                      SizedBox(height: getHeight() * 0.01),
                      TextView.getMediumText15UnderLine("Edit Settings", color: AppColors.greenColor, fontFamily: Assets.poppinsMedium, textDecoration: TextDecoration.underline),

                    ],
                  ),
                ),
                SizedBox(height: getHeight() * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(
                    //horizontal: sizes!.widthRatio * 5,
                      vertical: sizes!.heightRatio * 5),
                  decoration: const BoxDecoration(
                    color: AppColors.pureWhiteColor,
                  ),
                  child: TabBar(
                    controller: _tabController,
                    onTap: (index) {
                      print("Tab: $index");
                    },
                    indicatorColor: AppColors.greenColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding:
                    EdgeInsets.symmetric(vertical: sizes!.heightRatio * 5),
                    labelColor: AppColors.blackColor,
                    labelStyle: TextStyle(
                        fontSize: sizes!.fontRatio * 12,
                        fontFamily: Assets.poppinsMedium,
                        fontWeight: FontWeight.w500
                    ),
                    unselectedLabelColor: AppColors.darkGrey,
                    unselectedLabelStyle: TextStyle(
                        fontSize: sizes!.fontRatio * 12,
                        fontFamily: Assets.poppinsMedium,
                        fontWeight: FontWeight.w400
                    ),
                    labelPadding: EdgeInsets.all(sizes!.smallPadding),
                    tabs: const [
                      Tab(
                        text: 'Notifications',

                      ),
                      Tab(
                        text: 'Pending Receipts',
                      ),
                      Tab(
                        text: 'Sent Receipts',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sizes!.height * 0.01),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizes!.pagePadding),
                        child: Column(
                          children: [
                            Expanded(
                              child:
                              ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                        },
                                        child: _notificationComponents?.notificationCard(
                                            image: Assets.notificationPic,
                                            text: "Auraganic",
                                            subText: "Running a 30% contribution",
                                            date: "2h ago",
                                            onPressNotification: () {})
                                    );
                                  })
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizes!.pagePadding),
                        child: Column(
                          children: [
                            Expanded(
                                child:
                                ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                          },
                                          child: _notificationComponents?.notificationCard(
                                              image: Assets.notificationPic,
                                              text: "Auraganic",
                                              subText: "Running a 30% contribution",
                                              date: "2h ago",
                                              onPressNotification: () {})
                                      );
                                    })
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizes!.pagePadding),
                        child: Column(
                          children: [
                            Expanded(
                                child:
                                ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                          },
                                          child: _notificationComponents?.notificationCard(
                                              image: Assets.notificationPic,
                                              text: "Auraganic",
                                              subText: "Running a 30% contribution",
                                              date: "2h ago",
                                              onPressNotification: () {})
                                      );
                                    })
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
