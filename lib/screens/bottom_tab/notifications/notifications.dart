import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/handling_empty_states.dart';
import 'package:thinknlocal_app/common/main_controller.dart';
import 'package:thinknlocal_app/common/utils.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/screens/bottom_tab/notifications/full_photo_screen.dart';
import 'package:thinknlocal_app/screens/bottom_tab/notifications/notification_card.dart';
import 'package:thinknlocal_app/screens/bottom_tab/notifications/notification_controller.dart';
import 'package:thinknlocal_app/widgets/loading_indicator.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';
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

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final NotificationController _notificationController =
      Get.put(NotificationController());
  final MainController _mainController = Get.put(MainController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      color: AppColors.greenColor,
      onRefresh: () async {
        _notificationController.getNotifications();
        _notificationController.getPendingReceipts();
        _notificationController.getApprovedReceipts();
        _notificationController.getDeniedReceipts();
      },
      child: Obx(
        () => (_notificationController.isNotificationsLoading.value ||
                _notificationController.isPendingReceiptsLoading.value ||
                _notificationController.isApprovedReceiptsLoading.value ||
                _notificationController.isDeniedReceiptsLoading.value)
            ? bouncingLoadingIndicator()
            : Container(
                height: sizes.height,
                width: sizes.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: PreferenceUtils.getGradient()),
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
                            colors: PreferenceUtils.getGradient()),
                      ),
                    ),
                    Container(
                      color: AppColors.pureWhiteColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizes.width * 0.06),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView.header(Strings.yourNotifications,
                                color: AppColors.lightBlack,
                                fontFamily: Assets.poppinsSemiBold,
                                fontSize: sizes.fontSize25),
                            SizedBox(height: getHeight() * 0.01),
                            TextView.titleWithDecoration(
                                Strings.wantToEditNotification,
                                color: AppColors.darkGrey,
                                fontFamily: Assets.poppinsRegular),
                            SizedBox(height: getHeight() * 0.01),
                            GestureDetector(
                                onTap: () {
                                  _mainController.controller!.jumpToTab(4);
                                },
                                child: TextView.titleWithDecoration(
                                    Strings.editSettings,
                                    color: AppColors.greenColor,
                                    fontFamily: Assets.poppinsMedium,
                                    textDecoration: TextDecoration.underline)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        color: AppColors.pureWhiteColor,
                        child: SizedBox(height: getHeight() * 0.04)),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: sizes.heightRatio * 5),
                      decoration: const BoxDecoration(
                        color: AppColors.pureWhiteColor,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
                        child: TabBar(
                          isScrollable: true,
                          controller: _tabController,
                          onTap: (index) {},
                          indicatorColor: AppColors.greenColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorPadding: EdgeInsets.symmetric(
                              vertical: sizes.heightRatio * 5),
                          labelColor: AppColors.blackColor,
                          labelStyle: TextStyle(
                              fontSize: sizes.fontRatio * 12.5,
                              fontFamily: Assets.poppinsMedium,
                              fontWeight: FontWeight.w500),
                          unselectedLabelColor: AppColors.darkGrey,
                          unselectedLabelStyle: TextStyle(
                              fontSize: sizes.fontRatio * 12,
                              fontFamily: Assets.poppinsMedium,
                              fontWeight: FontWeight.w400),
                          labelPadding: EdgeInsets.symmetric(
                              horizontal: sizes.smallPadding),
                          tabs: [
                            Stack(
                              children: [
                                const Tab(
                                  text: Strings.notifications,
                                ),
                                _notificationController
                                            .unreadNotifications.value ==
                                        0
                                    ? const SizedBox()
                                    : Positioned(
                                        right: 0,
                                        top: getHeight() * 0.002,
                                        child: Container(
                                          height: getWidth() * 0.04,
                                          width: getWidth() * 0.04,
                                          decoration: BoxDecoration(
                                              color: AppColors.orangeColor,
                                              borderRadius:
                                                  BorderRadius.circular(0.4.h)),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 0.2.h),
                                              child: TextView.caption(
                                                  _notificationController
                                                      .unreadNotifications
                                                      .toString(),
                                                  color:
                                                      AppColors.pureWhiteColor,
                                                  fontSize: 7.5.sp,
                                                  textAlign: TextAlign.center,
                                                  lines: 1),
                                            ),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: getWidth() * 0.01),
                              child: const Tab(
                                text: Strings.pendingReceipts,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: getWidth() * 0.01),
                              child: const Tab(
                                text: Strings.approvedReceipts,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: getWidth() * 0.01),
                              child: const Tab(
                                text: Strings.deniedReceipts,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizes.height / 1.9,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: sizes.width * 0.03,
                                right: sizes.width * 0.03),
                            child: Column(
                              children: [
                                _notificationController
                                            .notificationList?.isNotEmpty ??
                                        false
                                    ? Expanded(
                                        child: ListView.separated(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.8.h),
                                          itemCount: _notificationController
                                              .notificationList!.length,
                                          // itemCount: notificationList.length,
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () async {
                                                  if (_notificationController
                                                          .notificationList![
                                                              index]
                                                          .read ==
                                                      false) {
                                                    await _notificationController
                                                        .markNotificationAsRead(
                                                            _notificationController
                                                                .notificationList![
                                                                    index]
                                                                .id!);
                                                  } else {
                                                    await _notificationController
                                                        .markNotificationAsUnRead(
                                                            _notificationController
                                                                .notificationList![
                                                                    index]
                                                                .id!);
                                                  }
                                                  _notificationController
                                                      .getNotifications();
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: index == 0 ? 0 : 1.h,
                                                      bottom: index ==
                                                              _notificationController
                                                                      .notificationList!
                                                                      .length -
                                                                  1
                                                          ? 4.h
                                                          : 0),
                                                  child: NotificationCard(
                                                      isShowImage: false,
                                                      isNetworkImage: false,
                                                      image: Assets
                                                          .noImageAvailable,
                                                      text:
                                                          _notificationController
                                                              .notificationList?[
                                                                  index]
                                                              .title,
                                                      subText:
                                                          _notificationController
                                                              .notificationList?[
                                                                  index]
                                                              .message,
                                                      date: '',
                                                      isSubTitleBold:
                                                          _notificationController
                                                                      .notificationList![
                                                                          index]
                                                                      .read ==
                                                                  false
                                                              ? true
                                                              : false,
                                                      onPressNotification:
                                                          () {}),
                                                ));
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return Divider(
                                                height: getHeight() * 0.03,
                                                thickness: getHeight() * 0.002,
                                                color:
                                                    AppColors.barSeperatorGrey);
                                          },
                                        ),
                                      )
                                    : handleEmptyState(
                                        context, Strings.noNotifications),
                              ],
                            ),
                            color: AppColors.pureWhiteColor,
                          ),
                          Container(
                            color: AppColors.pureWhiteColor,
                            padding: EdgeInsets.only(
                                left: sizes.width * 0.03,
                                right: sizes.width * 0.03),
                            child: Column(
                              children: [
                                Expanded(
                                  child: _notificationController
                                              .pendingContributionsList
                                              ?.isNotEmpty ??
                                          false
                                      ? ListView.separated(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.8.h),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemCount: _notificationController
                                              .pendingContributionsList!.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Get.to(() => FullPhoto(
                                                      imageUrl:
                                                          _notificationController
                                                              .pendingContributionsList![
                                                                  index]
                                                              .receiptUrl!));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: index == 0 ? 0 : 1.h,
                                                      bottom: index ==
                                                              _notificationController
                                                                      .pendingContributionsList!
                                                                      .length -
                                                                  1
                                                          ? 4.h
                                                          : 0),
                                                  child: NotificationCard(
                                                      image: _notificationController
                                                          .pendingContributionsList?[
                                                              index]
                                                          .receiptUrl,
                                                      text: _notificationController
                                                          .pendingContributionsList?[
                                                              index]
                                                          .business
                                                          ?.name,
                                                      subText:
                                                          "\$${_notificationController.pendingContributionsList?[index].receiptAmount?.toStringAsFixed(2) ?? '0'} will be sent to ${_notificationController.pendingContributionsList?[index].cause?.name ?? 'cause'}",
                                                      date: _notificationController
                                                                  .pendingContributionsList![
                                                                      index]
                                                                  .receiptDate ==
                                                              null
                                                          ? ''
                                                          : _notificationController.getTime(
                                                              _notificationController
                                                                  .pendingContributionsList![
                                                                      index]
                                                                  .receiptDate!),
                                                      onPressNotification:
                                                          () {}),
                                                ));
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return Divider(
                                                height: getHeight() * 0.03,
                                                thickness: getHeight() * 0.002,
                                                color:
                                                    AppColors.barSeperatorGrey);
                                          },
                                        )
                                      : handleEmptyState(
                                          context, Strings.noPendingReceipts),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: AppColors.pureWhiteColor,
                            padding: EdgeInsets.only(
                                left: sizes.width * 0.03,
                                right: sizes.width * 0.03),
                            child: Column(
                              children: [
                                Expanded(
                                  child: _notificationController
                                              .approvedContributionsList
                                              ?.isNotEmpty ??
                                          false
                                      ? ListView.separated(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.8.h),
                                          itemCount: _notificationController
                                              .approvedContributionsList!
                                              .length,
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Get.to(() => FullPhoto(
                                                      imageUrl:
                                                          _notificationController
                                                              .approvedContributionsList![
                                                                  index]
                                                              .receiptUrl!));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: index == 0 ? 0 : 1.h,
                                                      bottom: index ==
                                                              _notificationController
                                                                      .approvedContributionsList!
                                                                      .length -
                                                                  1
                                                          ? 4.h
                                                          : 0),
                                                  child: NotificationCard(
                                                      image: _notificationController
                                                          .approvedContributionsList?[
                                                              index]
                                                          .receiptUrl,
                                                      text: _notificationController
                                                          .approvedContributionsList?[
                                                              index]
                                                          .business!
                                                          .name,
                                                      subText:
                                                          "\$${_notificationController.approvedContributionsList?[index].receiptAmount?.toStringAsFixed(2) ?? '0'} will be sent to ${_notificationController.approvedContributionsList?[index].cause?.name ?? 'cause'}",
                                                      date: _notificationController
                                                                  .approvedContributionsList![
                                                                      index]
                                                                  .receiptDate ==
                                                              null
                                                          ? ''
                                                          : _notificationController.getTime(
                                                              _notificationController
                                                                  .approvedContributionsList![
                                                                      index]
                                                                  .receiptDate!),
                                                      isSentReceipts: true,
                                                      onPressNotification:
                                                          () {}),
                                                ));
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return Divider(
                                                height: getHeight() * 0.03,
                                                thickness: getHeight() * 0.002,
                                                color:
                                                    AppColors.barSeperatorGrey);
                                          },
                                        )
                                      : handleEmptyState(
                                          context, Strings.noApprovedReceipts),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: AppColors.pureWhiteColor,
                            padding: EdgeInsets.only(
                                left: sizes.width * 0.03,
                                right: sizes.width * 0.03),
                            child: Column(
                              children: [
                                Expanded(
                                  child: _notificationController
                                              .deniedContributionsList
                                              ?.isNotEmpty ??
                                          false
                                      ? ListView.separated(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.8.h),
                                          itemCount: _notificationController
                                              .deniedContributionsList!.length,
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Get.to(() => FullPhoto(
                                                      imageUrl:
                                                          _notificationController
                                                                  .deniedContributionsList![
                                                                      index]
                                                                  .receiptUrl ??
                                                              Assets.noImage));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: index == 0 ? 0 : 1.h,
                                                      bottom: index ==
                                                              _notificationController
                                                                      .deniedContributionsList!
                                                                      .length -
                                                                  1
                                                          ? 4.h
                                                          : 0),
                                                  child: NotificationCard(
                                                      image: _notificationController
                                                          .deniedContributionsList?[
                                                              index]
                                                          .receiptUrl,
                                                      text: _notificationController
                                                          .deniedContributionsList![
                                                              index]
                                                          .business
                                                          ?.name,
                                                      subText:
                                                          _notificationController.deniedContributionsList?[index].reason
                                                                  ?.replaceAll(
                                                                      '_', ' ')
                                                                  .capitalize ??
                                                              'Invalid Receipt',
                                                      date: _notificationController
                                                                  .deniedContributionsList![
                                                                      index]
                                                                  .receiptDate ==
                                                              null
                                                          ? ''
                                                          : (_notificationController.getTime(
                                                              _notificationController
                                                                  .deniedContributionsList![index]
                                                                  .receiptDate!)),
                                                      isSentReceipts: true,
                                                      isShowReason: true,
                                                      onPressNotification: () {}),
                                                ));
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return Divider(
                                                height: getHeight() * 0.03,
                                                thickness: getHeight() * 0.002,
                                                color:
                                                    AppColors.barSeperatorGrey);
                                          },
                                        )
                                      : handleEmptyState(
                                          context, Strings.noDeniedReceipts),
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
    ));
  }
}
