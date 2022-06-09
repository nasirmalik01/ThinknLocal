import 'package:flutter/material.dart';
import 'package:flutter_app/common/handling_empty_states.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/deep_link_info.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail_components.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail_controller.dart';
import 'package:flutter_app/screens/causes_detail/corporate_sponsor.dart';
import 'package:flutter_app/screens/causes_detail/detail_category_list.dart';
import 'package:flutter_app/screens/causes_detail/featured_sponsors.dart';
import 'package:flutter_app/screens/causes_detail/recent_contributions.dart';
import 'package:flutter_app/screens/causes_detail/top_image_container.dart';
import 'package:flutter_app/screens/causes_detail/update_fund_raiser.dart';
import 'package:flutter_app/widgets/custom_dialog.dart';
import 'package:flutter_app/widgets/custom_tab_bar.dart';
import 'package:flutter_app/widgets/graph_widget.dart';
import 'package:flutter_app/widgets/network_error.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sizer/sizer.dart';

import '/common/methods.dart';
import '/constants/assets.dart';
import '/constants/colors.dart';
import '/res/res.dart';
// import 'package:fl_chart/fl_chart.dart';
import '/widgets/common_widgets.dart';

class CausesDetail extends StatefulWidget {
  const CausesDetail({Key? key}) : super(key: key);

  @override
  _CausesDetailState createState() => _CausesDetailState();
}

class _CausesDetailState extends State<CausesDetail>
    with SingleTickerProviderStateMixin {
  final CauseDetailComponents _causeDetailComponents = CauseDetailComponents();
  final CausesDetailController _causesDetailController = Get.put(CausesDetailController());
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final _causeInfo = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int _causeId = _causeInfo[Strings.causeId];
    int _organizationId = _causeInfo[Strings.organizationId];
    getCauseDetail(_causeId);

    return SafeArea(
      child: Scaffold(
          body: Obx(
        () => _causesDetailController.isError.value
            ? NetworkErrorException(
                exceptionMessage: _causesDetailController.errorMessage.value,
                onPress: () {
                  _causesDetailController.isError.value = false;
                  getCauseDetail(_causeId);
                })
            : (_causesDetailController.isLoading.value ||
                    _causesDetailController.isStatsLoading.value ||
                    _causesDetailController.isCauseBottomLoading.value ||
                    _causesDetailController.isFeaturedLoading.value ||
                    _causesDetailController.isCauseAdvertisementLoading.value)
                ? circularProgressIndicator()
                : SingleChildScrollView(
                    child: Container(
                      height: sizes.height + sizes.height * 0.46,
                      width: sizes.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          /// top image container
                          SizedBox(
                            height: sizes.height * 0.35,
                            child: CausesDetailTopImageContainer(
                              name: _causesDetailController.causeDetail!.name,
                              fullBoxImage:
                                  _causesDetailController.causeDetail!.image,
                              logoImage: _causesDetailController
                                  .causeDetail!.organization?.logo,
                              completePercentage: _causesDetailController
                                  .causeDetail!.percentage!,
                              collectedAmount: _causesDetailController.causeDetail!.raised!.toStringAsFixed(2),
                              totalAmount: _causesDetailController.causeDetail!.goal!.toStringAsFixed(2),
                              endDate:
                                  "${_causesDetailController.causeDetail!.start} - ${_causesDetailController.causeDetail!.end}",
                              isFavorite:
                                  _causesDetailController.isCauseFollowed.value,
                              onClickBox: () {},
                              onPressBackArrow: () {
                                Navigator.pop(context);
                              },
                              onPressFavoriteIcon: () {
                                _causesDetailController.followCauses(_causeId);
                              },
                              onShareClick: () {
                                buildDynamicLinks(Strings.causes, _causeId.toString(), organizationId: _organizationId.toString());
                                DeepLinkInfo? _deepLinkInfo = MyHive.getDeepLinkInfo();
                                MyHive.setDeepLinkInfo(DeepLinkInfo(causeId: _causeId, organizationId: _organizationId, businessId: _deepLinkInfo?.businessId));
                              },
                            ),
                          ),
                          SizedBox(height: sizes.height * 0.04),
                          Container(
                            height: getHeight() * 0.045,
                            margin: EdgeInsets.symmetric(
                              horizontal: getWidth() * 0.05,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.boxGrey,
                              borderRadius:
                                  BorderRadius.circular(getHeight() * 0.01),
                            ),
                            child: TabBar(
                              controller: _tabController,
                              onTap: (index) {},
                              indicator: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(getHeight() * 0.01),
                                color: AppColors.lightBlue,
                              ),
                              //indicatorColor: AppColors.pureWhiteColor,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor: AppColors.pureWhiteColor,
                              labelStyle: TextStyle(
                                fontSize: sizes.fontRatio * 13,
                                fontFamily: Assets.poppinsMedium,
                                fontWeight: FontWeight.w500,
                              ),
                              unselectedLabelColor: AppColors.darkGrey,
                              unselectedLabelStyle: TextStyle(
                                  fontSize: sizes.fontRatio * 13,
                                  fontFamily: Assets.poppinsRegular,
                                  fontWeight: FontWeight.w400),
                              //labelPadding: EdgeInsets.all(sizes!.smallPadding),
                              tabs: const [
                                Tab(
                                  text: Strings.overview,
                                ),
                                Tab(
                                  text: Strings.update,
                                ),
                                Tab(
                                  text: Strings.stats,
                                ),
                              ],
                            ),
                          ),

                          ///parent tabview
                          Flexible(
                            ///this is the tab-bar view
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                /// 1st page
                                ListView(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getHeight() * 0.03),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ///Chino Hills HS Girls Water Polo
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizes.width * 0.06),
                                          child: _causeDetailComponents
                                              .descriptionTextContainer(
                                                  heading:
                                                      _causesDetailController
                                                          .causeDetail!.name
                                                          .toString(),
                                                  description:
                                                      _causesDetailController
                                                          .causeDetail!
                                                          .description
                                                          .toString()),
                                        ),
                                        SizedBox(height: sizes.height * 0.04),

                                        ///Corporate Sponsors
                                        _causesDetailController
                                                .causeAdvertisementList!
                                                .isNotEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  customDialog(
                                                      title: _causesDetailController
                                                          .causeAdvertisementList![
                                                              0]
                                                          .headline,
                                                      summary:
                                                          _causesDetailController
                                                              .causeAdvertisementList![
                                                                  0]
                                                              .summary,
                                                      backgroundImage:
                                                          _causesDetailController
                                                              .causeAdvertisementList![
                                                                  0]
                                                              .business!
                                                              .image!,
                                                      icon: _causesDetailController
                                                          .causeAdvertisementList![
                                                              0]
                                                          .business!
                                                          .logo!,
                                                      description:
                                                          _causesDetailController
                                                              .causeAdvertisementList![
                                                                  0]
                                                              .business!
                                                              .description!,
                                                      onClickLearnMore: () {
                                                        Get.back();
                                                        launchInBrowser(Uri.parse(
                                                            _causesDetailController
                                                                .causeAdvertisementList![
                                                                    0]
                                                                .url!));
                                                      });
                                                },
                                                child: CorporateSponsor(
                                                  backgroundImage:
                                                      _causesDetailController
                                                          .causeAdvertisementList![
                                                              0]
                                                          .business!
                                                          .image!,
                                                  icon: _causesDetailController
                                                      .causeAdvertisementList![
                                                          0]
                                                      .business!
                                                      .logo!,
                                                  title: _causesDetailController
                                                      .causeAdvertisementList![
                                                          0]
                                                      .headline!,
                                                  summary: _causesDetailController
                                                      .causeAdvertisementList![
                                                          0]
                                                      .summary!,
                                                ),
                                              )
                                            : const SizedBox(),

                                        ///Featured Sponsors
                                        _causesDetailController
                                                .causeFeaturedList!.isNotEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                sizes.width *
                                                                    0.06),
                                                    child: TextView
                                                        .titleWithDecoration(
                                                            Strings
                                                                .featuredSponsors,
                                                            color: AppColors
                                                                .blackColor,
                                                            fontFamily: Assets
                                                                .poppinsMedium,
                                                            fontSize: sizes
                                                                .fontSize17),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          getHeight() * 0.01),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: getWidth() * 0.06,
                                                    ),
                                                    child: SizedBox(
                                                      height:
                                                          getHeight() * 0.16,
                                                      child: Obx(() =>
                                                          _causesDetailController
                                                                  .isFeaturedLoading
                                                                  .value
                                                              ? circularProgressIndicator()
                                                              : ListView
                                                                  .builder(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount:
                                                                      _causesDetailController
                                                                          .causeFeaturedList!
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return FeaturedSponsors(
                                                                      name: _causesDetailController
                                                                          .causeFeaturedList![
                                                                              index]
                                                                          .name,
                                                                      image: _causesDetailController
                                                                          .causeFeaturedList![
                                                                              index]
                                                                          .image,
                                                                      logoImage: _causesDetailController
                                                                          .causeFeaturedList![
                                                                              index]
                                                                          .logo,
                                                                      givingBack: _causesDetailController
                                                                          .causeFeaturedList![
                                                                              index]
                                                                          .contributionAmount,
                                                                      onPressFullContainer:
                                                                          () {},
                                                                    );
                                                                  },
                                                                )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          sizes.height * 0.04),
                                                ],
                                              )
                                            : const SizedBox(),

                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  customTabBar(
                                                      title: Strings.foodDrink,
                                                      isSelected:
                                                          _causesDetailController
                                                              .isFoodAndDrink
                                                              .value,
                                                      isDetail: true,
                                                      onTap: () {
                                                        _causesDetailController
                                                            .getCauseBottomDetails(
                                                                _causeId, 21,
                                                                isBottomTab:
                                                                    true);
                                                        _causesDetailController
                                                            .setFoodAndDrinkTab();
                                                      }),
                                                  customTabBar(
                                                      title: Strings.toDoThings,
                                                      isSelected:
                                                          _causesDetailController
                                                              .isThingsToDo
                                                              .value,
                                                      isDetail: true,
                                                      onTap: () {
                                                        _causesDetailController
                                                            .getCauseBottomDetails(
                                                                _causeId, 27,
                                                                isBottomTab:
                                                                    true);
                                                        _causesDetailController
                                                            .setThingsToDoTab();
                                                      }),
                                                  customTabBar(
                                                      title: Strings.retail,
                                                      isSelected:
                                                          _causesDetailController
                                                              .isRetail.value,
                                                      isDetail: true,
                                                      onTap: () {
                                                        _causesDetailController
                                                            .getCauseBottomDetails(
                                                                _causeId, 1,
                                                                isBottomTab:
                                                                    true);
                                                        _causesDetailController
                                                            .setRetailTab();
                                                      }),
                                                  customTabBar(
                                                      title: Strings.services,
                                                      isSelected:
                                                          _causesDetailController
                                                              .isServices.value,
                                                      isDetail: true,
                                                      onTap: () {
                                                        _causesDetailController
                                                            .getCauseBottomDetails(
                                                                _causeId, 32,
                                                                isBottomTab:
                                                                    true);
                                                        _causesDetailController
                                                            .setServicesTab();
                                                      }),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: sizes.height * 0.02),
                                              Obx(() => _causesDetailController
                                                      .isBottomTabLoading.value
                                                  ? circularProgressIndicator()
                                                  : _causesDetailController
                                                          .causeBottomDetails!
                                                          .isNotEmpty
                                                      ? ListView.separated(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          physics:
                                                              const BouncingScrollPhysics(),
                                                          itemCount:
                                                              _causesDetailController
                                                                  .causeBottomDetails!
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return DetailCategoryList(
                                                                image: _causesDetailController
                                                                    .causeBottomDetails![
                                                                        index]
                                                                    .image,
                                                                headerText:
                                                                    _causesDetailController
                                                                        .causeBottomDetails![
                                                                            index]
                                                                        .name,
                                                                onViewCourse:
                                                                    () {},
                                                                categoryPercent:
                                                                    _causesDetailController
                                                                        .causeBottomDetails![
                                                                            index]
                                                                        .contributionAmount,
                                                                address: _causesDetailController
                                                                    .causeBottomDetails![
                                                                        index]
                                                                    .address1,
                                                                streetAddress: _causesDetailController
                                                                        .causeBottomDetails![
                                                                            index]
                                                                        .address2 ??
                                                                    Strings
                                                                        .unknown,
                                                                phoneNumber: '(${_causesDetailController.causeBottomDetails![index].phone!.substring(0,3)}) ${_causesDetailController.causeBottomDetails![index].phone!.substring(3, 6)}-${_causesDetailController.causeBottomDetails![index].phone!.substring(6, )}',
                                                                onPhoneClick:
                                                                    () {
                                                                  openPhoneDialPad(
                                                                      '+1${_causesDetailController.causeBottomDetails![index].phone.toString()}',
                                                                      context);
                                                                },
                                                                onAddressClick:
                                                                    () {
                                                                  MapsLauncher.launchCoordinates(
                                                                      _causesDetailController
                                                                          .causeBottomDetails![
                                                                              index]
                                                                          .latitude!,
                                                                      _causesDetailController
                                                                          .causeBottomDetails![
                                                                              index]
                                                                          .longitude!);
                                                                },
                                                                onShowRestrictionsTap:
                                                                    () {
                                                                  customDialog();
                                                                });
                                                          },
                                                          separatorBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Divider(
                                                                height:
                                                                    getHeight() *
                                                                        0.04,
                                                                thickness:
                                                                    getHeight() *
                                                                        0.002,
                                                                color: AppColors
                                                                    .borderColor);
                                                          },
                                                        )
                                                      : handleEmptyState(
                                                          context,
                                                          Strings.noCauses)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                ///2nd page
                                _causesDetailController
                                        .updatedCausesList!.isNotEmpty
                                    ? ListView(
                                        padding: EdgeInsets.symmetric(
                                            vertical: getHeight() * 0.03),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: sizes.width * 0.06),
                                            child: Column(
                                              children: [
                                                ListView.separated(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const ScrollPhysics(),
                                                  itemCount:
                                                      _causesDetailController
                                                          .updatedCausesList!
                                                          .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return UpdateFundRaiser(
                                                        header: _causesDetailController.updatedCausesList![index].title!,
                                                        detail: _causesDetailController
                                                            .updatedCausesList![
                                                                index]
                                                            .message!,
                                                        date: 'Mar 6th');
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Divider(
                                                        height:
                                                            getHeight() * 0.04,
                                                        thickness:
                                                            getHeight() * 0.002,
                                                        color: AppColors
                                                            .borderColor);
                                                  },
                                                ),
                                                SizedBox(
                                                    height:
                                                        sizes.height * 0.03),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : handleEmptyState(
                                        context, Strings.noCauseUpdates),

                                /// 3rd page
                                ListView(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getHeight() * 0.03),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizes.width * 0.06),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextView.caption(
                                              Strings.contributionsOverTime,
                                              color: AppColors.blackColor,
                                              fontFamily: Assets.poppinsMedium,
                                              fontSize: sizes.fontSize18),
                                          SizedBox(height: 0.5.h),
                                          TextView.caption(
                                              Strings.numberOfContributions,
                                              color: AppColors.darkGrey,
                                              fontFamily: Assets.poppinsRegular,
                                              fontSize: sizes.fontSize13),
                                          SizedBox(height: 0.7.h),

                                          ///chart v2
                                          GetBuilder<CausesDetailController>(
                                              id: 'causesBuilder',
                                              builder: (_) {
                                                return StatsBarChartWidget(
                                                  popUpTitle: 'Causes Stats',
                                                  dataSource:
                                                      _causesDetailController
                                                          .causesStatsHistory,
                                                );
                                              }),
                                          SizedBox(height: 3.h),
                                          CommonWidgets.getTextWithSeeAll(
                                              leadingText:
                                                  Strings.recentContributions,
                                              trailingText: Strings.seeAll,
                                              onPressSeeAllButton: () {}),
                                          SizedBox(height: 2.h),
                                          _causesDetailController.causesStats!
                                                  .topContributors!.isNotEmpty
                                              ? ListView.separated(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const ScrollPhysics(),
                                                  itemCount:
                                                      _causesDetailController
                                                          .causesStats!
                                                          .topContributors!
                                                          .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return RecentContributions(
                                                        contributorName:
                                                            _causesDetailController
                                                                .causesStats!
                                                                .topContributors![
                                                                    index]
                                                                .name,
                                                        amount:
                                                        _causesDetailController.causesStats!.topContributors![index].amount?.toStringAsFixed(2));
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Divider(
                                                        height:
                                                            getHeight() * 0.04,
                                                        thickness:
                                                            getHeight() * 0.002,
                                                        color: AppColors
                                                            .borderColor);
                                                  },
                                                )
                                              : handleEmptyState(
                                                  context,
                                                  Strings
                                                      .noRecentContributions),
                                          SizedBox(height: getHeight() * 0.03),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      )),
    );
  }

  getCauseDetail(int _id) {
    _causesDetailController.getCauseDetail(_id);
    _causesDetailController.getCauseStats(_id);
    _causesDetailController.getCauseBottomDetails(_id, 21);
    _causesDetailController.getCauseFeatured(_id);
    bool _isUserAuthenticated = PreferenceUtils.isUserAuthenticated();
    if (_isUserAuthenticated) {
      _causesDetailController.getFollowCause(_id);
    }
    _causesDetailController.getUpdatedCauses(_id);
    _causesDetailController.getCauseAdvertisements(_id);
  }
}
