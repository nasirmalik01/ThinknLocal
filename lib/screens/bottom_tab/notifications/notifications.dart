import 'package:flutter/material.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/dummy_data/notification.dart';
import 'package:flutter_app/screens/bottom_tab/notifications/notification_card.dart';
import 'package:flutter_app/widgets/status_bar.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:sizer/sizer.dart';
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


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // setStatusBarColor(color: PreferenceUtils.getGradient().first);

    return Scaffold(
      body: Container(
        height: sizes.height,
        width: sizes.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: [
            Container(
              height: getHeight() * 0.12,
              width: getWidth(),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: PreferenceUtils.getGradient()
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
            SizedBox(height: getHeight() * 0.04),
            Container(
                  padding: EdgeInsets.symmetric(
                      vertical: sizes.heightRatio * 5),
                  decoration: const BoxDecoration(
                    color: AppColors.pureWhiteColor,
                  ),
                  child: Stack(
                    children: [
                      TabBar(
                        controller: _tabController,
                        onTap: (index) {},
                        indicatorColor: AppColors.greenColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorPadding: EdgeInsets.symmetric(vertical: sizes.heightRatio * 5),
                        labelColor: AppColors.blackColor,
                        labelStyle: TextStyle(
                            fontSize: sizes.fontRatio * 13,
                            fontFamily: Assets.poppinsMedium,
                            fontWeight: FontWeight.w500
                        ),
                        unselectedLabelColor: AppColors.darkGrey,
                        unselectedLabelStyle: TextStyle(
                            fontSize: sizes.fontRatio * 13,
                            fontFamily: Assets.poppinsMedium,
                            fontWeight: FontWeight.w400
                        ),
                        labelPadding: EdgeInsets.symmetric(horizontal: sizes.smallPadding),
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
                      Positioned(
                        left: getWidth()*0.26,
                        top: getHeight()*0.003,
                        child: Container(
                          height: getWidth()*0.038,
                          width: getWidth()*0.035,
                          decoration: BoxDecoration(
                              color: AppColors.orangeColor,
                              borderRadius: BorderRadius.circular(0.4.h)
                          ),
                          child: Center(child: Padding(
                            padding: EdgeInsets.only(bottom: 0.2.h),
                            child: TextView.caption('5', color: AppColors.pureWhiteColor, fontSize: 7.5.sp, textAlign: TextAlign.center, lines: 1),
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
            SizedBox(
              height: sizes.height/2,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: sizes.width * 0.06, right: sizes.width * 0.02),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 1.8.h),
                              itemCount: notificationList.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: EdgeInsets.only(top: index == 0 ? 0 : 1.h, bottom: index == notificationList.length - 1 ? 4.h : 0),
                                      child: NotificationCard(
                                          image: notificationList[index].leadingIcon,
                                          text: notificationList[index].title,
                                          subText: notificationList[index].subTitle,
                                          date: '${notificationList[index].time} ago',
                                          onPressNotification: () {}),
                                    )
                                );
                              },
                            separatorBuilder: (BuildContext context, int index) {
                              return Divider(height: getHeight() * 0.03, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: sizes.width * 0.06, right: sizes.width * 0.02),
                    child: Column(
                      children: [
                        Expanded(
                            child:
                            ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 1.8.h),
                              itemCount: pendingReceiptsList.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(top: index == 0 ? 0 : 1.h, bottom: index == notificationList.length - 1 ? 4.h : 0),
                                      child: NotificationCard(
                                          image: pendingReceiptsList[index].leadingIcon,
                                          text: pendingReceiptsList[index].title,
                                          subText: pendingReceiptsList[index].subTitle,
                                          date: '${pendingReceiptsList[index].time} ago',
                                          onPressNotification: () {}),
                                    )
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Divider(height: getHeight() * 0.03, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
                              },
                            ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: sizes.width * 0.06, right: sizes.width * 0.02),
                    child: Column(
                      children: [
                        Expanded(
                            child:
                            ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 1.8.h),
                              itemCount: sentReceiptsList.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(top: index == 0 ? 0 : 1.h, bottom: index == notificationList.length - 1 ? 4.h : 0),
                                      child: NotificationCard(
                                          image: sentReceiptsList[index].leadingIcon,
                                          text: sentReceiptsList[index].title,
                                          subText:sentReceiptsList[index].subTitle,
                                          date: '${sentReceiptsList[index].time} ago',
                                          isSentReceipts: true,
                                          onPressNotification: () {}),
                                    )
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Divider(height: getHeight() * 0.03, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
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
