import 'package:flutter/material.dart';
import 'package:flutter_app/common/handling_empty_states.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/screens/bottom_tab/account/account_controller.dart';
import 'package:flutter_app/screens/bottom_tab/notifications/full_photo_screen.dart';
import 'package:flutter_app/screens/bottom_tab/notifications/notification_card.dart';
import 'package:flutter_app/screens/bottom_tab/notifications/notification_controller.dart';
import 'package:flutter_app/screens/edit_account/edit_account.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '/constants/assets.dart';
import '/constants/colors.dart';
import '/res/res.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>  with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final NotificationController _notificationController = Get.put(NotificationController());
  final AccountController _accountController = Get.put(AccountController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _accountController.getProfileInfo();

    return Scaffold(
        body: Obx(() =>
          (_notificationController.isNotificationsLoading.value || _notificationController.isContributionLoading.value)
          ? circularProgressIndicator()
          : Container(
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
                    TextView.header(Strings.yourNotifications, color: AppColors.lightBlack, fontFamily: Assets.poppinsSemiBold, fontSize: sizes.fontSize25),
                    SizedBox(height: getHeight() * 0.01),
                    TextView.titleWithDecoration(Strings.wantToEditNotification, color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular),
                    SizedBox(height: getHeight() * 0.01),
                    GestureDetector(
                        onTap: () async {
                          await Get.to(() => EditAccount(account: _accountController.account,));
                          _accountController.getProfileInfo();
                        },
                        child: TextView.titleWithDecoration(Strings.editSettings, color: AppColors.greenColor, fontFamily: Assets.poppinsMedium, textDecoration: TextDecoration.underline)),
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
                          text: Strings.notifications,

                        ),
                        Tab(
                          text: Strings.pendingReceipts,
                        ),
                        Tab(
                          text: Strings.sentReceipts,
                        ),
                      ],
                    ),
                    Positioned(
                      left: getWidth()*0.26,
                      top: getHeight()*0.003,
                      child: Container(
                        height: getWidth()*0.04,
                        width: getWidth()*0.04,
                        decoration: BoxDecoration(
                            color: AppColors.orangeColor,
                            borderRadius: BorderRadius.circular(0.4.h)
                        ),
                        child: Center(child: Padding(
                          padding: EdgeInsets.only(bottom: 0.2.h),
                          child: TextView.caption(_notificationController.notificationList?.length.toString(), color: AppColors.pureWhiteColor, fontSize: 7.5.sp, textAlign: TextAlign.center, lines: 1),
                        ),),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: sizes.height/1.9,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: sizes.width * 0.06, right: sizes.width * 0.02),
                      child: Column(
                        children: [
                          _notificationController.notificationList?.isNotEmpty ?? false
                          ? Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 1.8.h),
                              itemCount: _notificationController.notificationList!.length,
                              // itemCount: notificationList.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: EdgeInsets.only(top: index == 0 ? 0 : 1.h, bottom: index == _notificationController.notificationList!.length - 1 ? 4.h : 0),
                                      child: NotificationCard(
                                          isNetworkImage: false,
                                          image: Assets.noImageAvailable,
                                          text: _notificationController.notificationList![index].title,
                                          subText: _notificationController.notificationList![index].message,
                                          date: _notificationController.notificationList![index].id.toString(),
                                          onPressNotification: () {}
                                      ),
                                    )
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Divider(height: getHeight() * 0.03, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
                              },
                            ),
                          )
                          : handleEmptyState(context, Strings.noNotifications),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: sizes.width * 0.06, right: sizes.width * 0.02),
                      child: Column(
                        children: [
                          Expanded(
                            child: _notificationController.pendingContributionsList?.isNotEmpty ?? false
                             ? ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 1.8.h),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: _notificationController.pendingContributionsList!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Get.to(() => FullPhoto(imageUrl: _notificationController.pendingContributionsList![index].receiptUrl!));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(top: index == 0 ? 0 : 1.h, bottom: index == _notificationController.pendingContributionsList!.length - 1 ? 4.h : 0),
                                      child: NotificationCard(
                                          image: _notificationController.pendingContributionsList![index].receiptUrl,
                                          text: _notificationController.pendingContributionsList![index].business!.name,
                                          subText: "\$${_notificationController.pendingContributionsList![index].receiptAmount?.toStringAsFixed(2)} will be sent to cause",
                                          date: _notificationController.getTime(_notificationController.pendingContributionsList![index].receiptDate!),
                                          onPressNotification: () {}),
                                    )
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Divider(height: getHeight() * 0.03, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
                              },
                            )
                            : handleEmptyState(context, Strings.noPendingReceipts),
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
                            _notificationController.approvedContributionsList?.isNotEmpty ?? false
                            ? ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 1.8.h),
                              itemCount: _notificationController.approvedContributionsList!.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Get.to(() => FullPhoto(imageUrl: _notificationController.approvedContributionsList![index].receiptUrl!));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(top: index == 0 ? 0 : 1.h, bottom: index == _notificationController.approvedContributionsList!.length - 1 ? 4.h : 0),
                                      child: NotificationCard(
                                          image: _notificationController.approvedContributionsList![index].receiptUrl,
                                          text: _notificationController.approvedContributionsList![index].business!.name,
                                          subText: "\$${_notificationController.approvedContributionsList![index].receiptAmount?.toStringAsFixed(2)} will be sent to cause",
                                          date: _notificationController.getTime(_notificationController.approvedContributionsList![index].receiptDate!),
                                          isSentReceipts: true,
                                          onPressNotification: () {}),
                                    )
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Divider(height: getHeight() * 0.03, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
                              },
                            )
                            : handleEmptyState(context, Strings.noSentReceipts),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),)
    );
  }
}
