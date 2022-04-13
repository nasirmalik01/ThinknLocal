import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/notifications/notifications_components.dart';
import 'package:flutter_app/widgets/text_views.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>  with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final NotificationsComponents _notificationsComponents = NotificationsComponents();


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: sizes.height,
        width: sizes.width,
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
                    AppColors.lightGreenColor,
                    AppColors.pureWhiteColor,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView.header("Your Notifications", color: AppColors.lightBlack, fontFamily: Assets.poppinsSemiBold, fontSize: sizes.fontSize25),
                  SizedBox(height: getHeight() * 0.01),
                  TextView.titleWithDecoration("Want to edit your notification settings?", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular),
                  SizedBox(height: getHeight() * 0.01),
                  TextView.titleWithDecoration("Edit Settings", color: AppColors.greenColor, fontFamily: Assets.poppinsMedium, textDecoration: TextDecoration.underline),

                ],
              ),
            ),
            SizedBox(height: getHeight() * 0.02),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: sizes.heightRatio * 5),
              decoration: const BoxDecoration(
                color: AppColors.pureWhiteColor,
              ),
              child: TabBar(
                controller: _tabController,
                onTap: (index) {
                },
                indicatorColor: AppColors.greenColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding:
                EdgeInsets.symmetric(vertical: sizes.heightRatio * 5),
                labelColor: AppColors.blackColor,
                labelStyle: TextStyle(
                    fontSize: sizes.fontRatio * 12,
                    fontFamily: Assets.poppinsMedium,
                    fontWeight: FontWeight.w500
                ),
                unselectedLabelColor: AppColors.darkGrey,
                unselectedLabelStyle: TextStyle(
                    fontSize: sizes.fontRatio * 12,
                    fontFamily: Assets.poppinsMedium,
                    fontWeight: FontWeight.w400
                ),
                labelPadding: EdgeInsets.all(sizes.smallPadding),
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
            SizedBox(height: sizes.height * 0.01),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: sizes.width * 0.06, right: sizes.width * 0.06,),
                    child: Column(
                      children: [
                        Expanded(
                          child:
                          ListView.separated(
                              itemCount: 8,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                    },
                                    child: _notificationsComponents.notificationCard(
                                        image: Assets.notificationPic,
                                        text: "Auraganic",
                                        subText: "Running a 30% contribution",
                                        date: "2h ago",
                                        onPressNotification: () {})
                                );
                              },
                            separatorBuilder: (BuildContext context, int index) {
                              return Divider(height: getHeight() * 0.02, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizes.pagePadding),
                    child: Column(
                      children: [
                        Expanded(
                            child:
                            ListView.separated(
                              itemCount: 8,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                    },
                                    child: _notificationsComponents.notificationCard(
                                        image: Assets.notificationPic,
                                        text: "Auraganic",
                                        subText: "Running a 30% contribution",
                                        date: "2h ago",
                                        onPressNotification: () {})
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Divider(height: getHeight() * 0.02, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
                              },
                            ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizes.pagePadding),
                    child: Column(
                      children: [
                        Expanded(
                            child:
                            ListView.separated(
                              itemCount: 8,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                    },
                                    child: _notificationsComponents.notificationCard(
                                        image: Assets.notificationPic,
                                        text: "Auraganic",
                                        subText: "Running a 30% contribution",
                                        date: "2h ago",
                                        onPressNotification: () {})
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Divider(height: getHeight() * 0.02, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
                              },
                            ),
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
    );
  }
}
