import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/handling_empty_states.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/screens/bottom_tab/causes/causes_controller.dart';
import 'package:thinknlocal_app/screens/bottom_tab/causes/causes_funds_container.dart';
import 'package:thinknlocal_app/screens/bottom_tab/causes/recently_started_container.dart';
import 'package:thinknlocal_app/screens/bottom_tab/causes/upcoming_causes.dart';
import 'package:thinknlocal_app/screens/causes_detail/causes_detail.dart';
import 'package:thinknlocal_app/screens/causes_detail_listing/main_causes_listing.dart';
import 'package:thinknlocal_app/screens/causes_detail_listing/recent_causes_listing.dart';
import 'package:thinknlocal_app/screens/causes_detail_listing/upcoming_causes_listing.dart';
import 'package:thinknlocal_app/widgets/common_widgets.dart';
import 'package:thinknlocal_app/widgets/loading_indicator.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';

class CausesCategoryScreen extends StatefulWidget {
  const CausesCategoryScreen({Key? key}) : super(key: key);

  @override
  State<CausesCategoryScreen> createState() => _CausesCategoryScreenState();
}

class _CausesCategoryScreenState extends State<CausesCategoryScreen> {
  final ScrollController _recentlyStartedController = ScrollController();
  final ScrollController _tabViewsController = ScrollController();
  final CausesController _causesController = Get.put(CausesController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getHeight() * 0.01),
        SizedBox(
          height: 23.h,
          child: Obx(
            () => _causesController.isTopCausesContainersList.value
                ? bouncingLoadingIndicator()
                : _causesController.topCausesContainersList?.isNotEmpty ?? false
                    ? ListView.builder(
                        controller: _tabViewsController,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            _causesController.topCausesContainersList!.isEmpty
                                ? 0
                                : _causesController
                                            .topCausesContainersList!.length >
                                        5
                                    ? 6
                                    : _causesController
                                        .topCausesContainersList!.length,
                        itemBuilder: (context, index) {
                          return index ==
                                  (_causesController
                                              .topCausesContainersList!.length >
                                          5
                                      ? 5
                                      : _causesController
                                              .topCausesContainersList!.length +
                                          1)
                              ? GestureDetector(
                                  onTap: () async {
                                    Get.to(() => MainCausesListing(
                                        title: _causesController
                                                    .selectedCategory.value ==
                                                Strings.featured
                                            ? Strings.featured.capitalizeFirst
                                            : _causesController.selectedCategory
                                                        .value ==
                                                    Strings.trending
                                                ? Strings
                                                    .trending.capitalizeFirst
                                                : _causesController
                                                            .selectedCategory
                                                            .value ==
                                                        Strings.favorites
                                                    ? Strings.favorites
                                                        .capitalizeFirst
                                                    : Strings
                                                        .past.capitalizeFirst));
                                  },
                                  child: CommonWidgets.seeAllButton(40))
                              : CausesFundContainer(
                                  name: _causesController
                                      .topCausesContainersList![index].name!,
                                  fullBoxImage: _causesController
                                          .topCausesContainersList![index]
                                          .image ??
                                      Strings.dummyBgImage,
                                  logoImage: _causesController
                                          .topCausesContainersList![index]
                                          .organization!
                                          .logo ??
                                      Strings.dummyLogo,
                                  completePercentage: _causesController
                                      .topCausesContainersList![index]
                                      .percentage!,
                                  collectedAmount: _causesController
                                      .topCausesContainersList![index].raised!
                                      .toStringAsFixed(2),
                                  totalAmount: _causesController
                                      .topCausesContainersList![index].goal!
                                      .toStringAsFixed(2),
                                  endDate: _causesController
                                      .topCausesContainersList![index].end
                                      .toString(),
                                  dateStatus: _causesController
                                      .topCausesContainersList![index].status!,
                                  index: index,
                                  onClickBox: () async {
                                    pushNewScreen(
                                      context,
                                      screen: CausesDetail(
                                          causeId: _causesController
                                              .topCausesContainersList![index]
                                              .id,
                                          organizationId: _causesController
                                              .topCausesContainersList![index]
                                              .organization!
                                              .id),
                                      withNavBar: true,
                                    );
                                  },
                                );
                        },
                      )
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
                        child: handleEmptyState(
                            context,
                            _causesController.selectedCategory.value ==
                                    Strings.favorite
                                ? Strings.noCausesFavorites
                                : Strings.noCauses),
                      ),
          ),
        ),
        SizedBox(height: getHeight() * 0.03),
        Padding(
          padding: EdgeInsets.only(left: sizes.width * 0.06),
          child: TextView.titleWithDecoration(Strings.recentlyStarted,
              color: AppColors.blackColor,
              fontFamily: Assets.poppinsMedium,
              fontSize: sizes.fontSize16),
        ),
        SizedBox(height: getHeight() * 0.018),

        /// Recently Started Causes
        Obx(
          () => _causesController.isRecentlyStartedCausesLoading.value
              ? bouncingLoadingIndicator()
              : _causesController.recentlyStartedCauses?.isNotEmpty ?? false
                  ? SizedBox(
                      height: getHeight() * 0.17,
                      child: ListView.builder(
                        controller: _recentlyStartedController,
                        scrollDirection: Axis.horizontal,
                        itemCount: _causesController
                                .recentlyStartedCauses!.isEmpty
                            ? 0
                            : _causesController.recentlyStartedCauses!.length >
                                    5
                                ? 6
                                : _causesController
                                    .recentlyStartedCauses!.length,
                        itemBuilder: (context, index) {
                          return index ==
                                  (_causesController
                                              .recentlyStartedCauses!.length >
                                          5
                                      ? 5
                                      : _causesController
                                              .recentlyStartedCauses!.length +
                                          1)
                              ? GestureDetector(
                                  onTap: () async {
                                    Get.to(() => const RecentCausesListing(
                                        title: Strings.recentCauses));
                                  },
                                  child: CommonWidgets.seeAllButton(30))
                              : GestureDetector(
                                  onTap: () {
                                    pushNewScreen(
                                      context,
                                      screen: CausesDetail(
                                          causeId: _causesController
                                              .recentlyStartedCauses![index].id,
                                          organizationId: _causesController
                                              .recentlyStartedCauses![index]
                                              .organization!
                                              .id),
                                      withNavBar: true,
                                    );
                                  },
                                  child: RecentlyStartedContainer(
                                    name: _causesController
                                        .recentlyStartedCauses![index].name,
                                    image: _causesController
                                            .recentlyStartedCauses![index]
                                            .image ??
                                        Strings.dummyBgImage,
                                    colors: const [
                                      Colors.transparent,
                                      AppColors.blackColor,
                                    ],
                                    index: index,
                                    onPressFullContainer: () {},
                                  ),
                                );
                        },
                      ),
                    )
                  : handleEmptyState(context, Strings.noRecentCauses),
        ),
        SizedBox(height: getHeight() * 0.03),

        /// Upcoming causes
        Obx(() => Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
              child: Column(
                children: [
                  CommonWidgets.getTextWithSeeAll(
                      leadingText: Strings.upcomingCauses,
                      trailingText: Strings.seeAll,
                      onPressSeeAllButton: () {
                        Get.to(() => const UpcomingCausesListing(
                            title: Strings.upcomingCauses));
                      }),
                  SizedBox(height: getHeight() * 0.018),
                  _causesController.isUpcomingCausesLoading.value
                      ? bouncingLoadingIndicator()
                      : _causesController.upcomingCauses?.isNotEmpty ?? false
                          ? ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: _causesController
                                          .upcomingCauses?.isEmpty ??
                                      false
                                  ? 0
                                  : _causesController.upcomingCauses!.length > 3
                                      ? 3
                                      : _causesController
                                          .upcomingCauses!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    pushNewScreen(
                                      context,
                                      screen: CausesDetail(
                                          causeId: _causesController
                                              .upcomingCauses![index].id,
                                          organizationId: _causesController
                                              .upcomingCauses![index]
                                              .organization!
                                              .id),
                                      withNavBar: true,
                                    );
                                  },
                                  child: UpcomingCauses(
                                      image: _causesController
                                              .upcomingCauses![index]
                                              .organization
                                              ?.logo ??
                                          Strings.dummyBgImage,
                                      headerText: _causesController
                                          .upcomingCauses![index]
                                          .organization!
                                          .name,
                                      description: _causesController
                                          .upcomingCauses![index].name,
                                      onViewCourse: () {},
                                      totalAmount: _causesController
                                          .upcomingCauses![index].goal
                                          .toString(),
                                      date: _causesController
                                          .upcomingCauses![index].start!
                                          .toString()),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                    height: getHeight() * 0.04,
                                    thickness: getHeight() * 0.002,
                                    color: AppColors.barSeperatorGrey);
                              },
                            )
                          : handleEmptyState(context, Strings.noUpcomingCauses),
                  SizedBox(height: getHeight() * 0.03),
                ],
              ),
            ))
      ],
    );
  }
}
