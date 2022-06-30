import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/handling_empty_states.dart';
import 'package:thinknlocal_app/common/utils.dart';
import 'package:thinknlocal_app/config/firebase_dynamic_links.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/local/deep_link_info.dart';
import 'package:thinknlocal_app/local/my_hive.dart';
import 'package:thinknlocal_app/screens/businesses_detail/businesses_detail.dart';
import 'package:thinknlocal_app/screens/causes_detail/causes_detail_components.dart';
import 'package:thinknlocal_app/screens/causes_detail/causes_detail_controller.dart';
import 'package:thinknlocal_app/screens/causes_detail/corporate_sponsor.dart';
import 'package:thinknlocal_app/screens/causes_detail/detail_category_list.dart';
import 'package:thinknlocal_app/screens/causes_detail/featured_sponsors.dart';
import 'package:thinknlocal_app/screens/causes_detail/recent_contributions.dart';
import 'package:thinknlocal_app/screens/causes_detail/top_image_container.dart';
import 'package:thinknlocal_app/screens/causes_detail/update_fund_raiser.dart';
import 'package:thinknlocal_app/widgets/custom_dialog.dart';
import 'package:thinknlocal_app/widgets/custom_tab_bar.dart';
import 'package:thinknlocal_app/widgets/graph_widget.dart';
import 'package:thinknlocal_app/widgets/loading_indicator.dart';
import 'package:thinknlocal_app/widgets/network_error.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';

import '/common/methods.dart';
import '/constants/assets.dart';
import '/constants/colors.dart';
import '/res/res.dart';

class CausesDetail extends StatefulWidget {
  final int? causeId;
  final int? organizationId;

  const CausesDetail({this.causeId, this.organizationId, Key? key}) : super(key: key);

  @override
  _CausesDetailState createState() => _CausesDetailState();
}

class _CausesDetailState extends State<CausesDetail>
    with SingleTickerProviderStateMixin {
  final CauseDetailComponents _causeDetailComponents = CauseDetailComponents();
  final CausesDetailController _causesDetailController =
      Get.put(CausesDetailController());
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    int? _causeId = widget.causeId;
    int? _organizationId = widget.organizationId;
    getCauseDetail(_causeId!);

    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.greenColor,
        onRefresh: () async {
          getCauseDetail(_causeId);
        },
        child: Obx(
          () => _causesDetailController.isError.value
              ? NetworkErrorException(
                  exceptionMessage: _causesDetailController.errorMessage.value,
                  onPress: () {
                    _causesDetailController.isError.value = false;
                    getCauseDetail(_causeId);
                  })
              : (     _causesDetailController.isLoading.value ||
                      _causesDetailController.isStatsLoading.value ||
                      _causesDetailController.isCauseBottomLoading.value ||
                      _causesDetailController.isFeaturedLoading.value ||
                      _causesDetailController.isCauseAdvertisementLoading.value ||
                      _causesDetailController.isBusinessCategoryLoading.value
                )
                  ? bouncingLoadingIndicator()
                  : _causesDetailController.causeDetail == null
                  ? const SizedBox()
                  : CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          slivers: [
                            SliverFillRemaining(
                              hasScrollBody: true,
                              fillOverscroll: true,
                              child: Column(
                                children: [
                                  /// top image container
                                  SizedBox(
                                    height: sizes.height * 0.35,
                                    child: CausesDetailTopImageContainer(
                                      name: _causesDetailController.causeDetail?.name,
                                      fullBoxImage: _causesDetailController.causeDetail?.image,
                                      logoImage: _causesDetailController.causeDetail?.organization?.logo,
                                      completePercentage: _causesDetailController.causeDetail?.percentage ?? 0.0,
                                      collectedAmount: _causesDetailController.causeDetail?.raised?.toStringAsFixed(2) ?? '0.0',
                                      totalAmount: _causesDetailController.causeDetail?.goal?.toStringAsFixed(2) ?? '0.0',
                                      endDate: "${_causesDetailController.causeDetail?.start} - ${_causesDetailController.causeDetail?.end}",
                                      isFavorite: _causesDetailController.isCauseFollowed.value,
                                      onClickBox: () {},
                                      onPressBackArrow: () {
                                        Navigator.pop(context);
                                      },
                                      onPressFavoriteIcon: () {
                                        _causesDetailController.followCauses(_causeId);
                                      },
                                      onShareClick: () {
                                        FirebaseDynamicApi.buildDynamicLinks(Strings.causes, _causeId.toString(), organizationId: _organizationId.toString());
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
                                      borderRadius: BorderRadius.circular(
                                          getHeight() * 0.01),
                                    ),
                                    child: TabBar(
                                      controller: _tabController,
                                      onTap: (index) {},
                                      indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            getHeight() * 0.01),
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
                                          text: Strings.updates,
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
                                          physics:
                                              const BouncingScrollPhysics(),
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ///Chino Hills HS Girls Water Polo
                                                Padding(
                                                  padding:
                                                      EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                                                  child: _causeDetailComponents
                                                      .descriptionTextContainer(
                                                          heading: _causesDetailController.causeDetail!.name.toString(),
                                                          description: _causesDetailController.causeDetail!.description.toString()),
                                                ),
                                                SizedBox(height: sizes.height * 0.04),

                                                ///Corporate Sponsors
                                                _causesDetailController.causeAdvertisementList?.isNotEmpty ?? false
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          customDialog(
                                                              title: _causesDetailController.causeAdvertisementList![0].headline,
                                                              summary: _causesDetailController.causeAdvertisementList![0].summary,
                                                              backgroundImage: _causesDetailController.causeAdvertisementList![0].business!.image!,
                                                              icon: _causesDetailController.causeAdvertisementList![0].business!.logo!,
                                                              description: _causesDetailController.causeAdvertisementList![0].business!.description!,
                                                              onClickLearnMore: () {
                                                                Get.back();
                                                                launchInBrowser(Uri.parse(_causesDetailController.causeAdvertisementList![0].url!));
                                                              });
                                                        },
                                                        child:
                                                            CorporateSponsor(
                                                          backgroundImage: _causesDetailController.causeAdvertisementList![0].business!.image!,
                                                          icon: _causesDetailController.causeAdvertisementList![0].business!.logo!,
                                                          title: _causesDetailController.causeAdvertisementList![0].headline!,
                                                          summary: _causesDetailController.causeAdvertisementList![0].summary!,
                                                        ),
                                                      )
                                                    : const SizedBox(),

                                                ///Featured Sponsors
                                                _causesDetailController.causeFeaturedList?.isNotEmpty ?? false
                                                    ? Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        sizes.width *
                                                                            0.06),
                                                            child: TextView.titleWithDecoration(
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
                                                                  getHeight() *
                                                                      0.01),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets
                                                                    .only(
                                                              left:
                                                                  getWidth() *
                                                                      0.06,
                                                            ),
                                                            child: SizedBox(
                                                              height:
                                                                  getHeight() *
                                                                      0.16,
                                                              child: Obx(() => _causesDetailController
                                                                      .isFeaturedLoading
                                                                      .value
                                                                  ? bouncingLoadingIndicator()
                                                                  : ListView
                                                                      .builder(
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      physics:
                                                                          const BouncingScrollPhysics(),
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount: _causesDetailController
                                                                          .causeFeaturedList!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            customDialog(
                                                                                title: _causesDetailController.causeFeaturedList![index].name,
                                                                                summary: '(${_causesDetailController.causeFeaturedList![index].phone!.substring(0, 3)}) ${_causesDetailController.causeFeaturedList![index].phone!.substring(3, 6)}-${_causesDetailController.causeFeaturedList![index].phone!.substring(
                                                                                  6,
                                                                                )}',
                                                                                backgroundImage: _causesDetailController.causeFeaturedList![index].image,
                                                                                icon: _causesDetailController.causeFeaturedList![index].logo,
                                                                                description: _causesDetailController.causeFeaturedList![index].description,
                                                                                onClickLearnMore: () {
                                                                                  Get.back();
                                                                                  if (_causesDetailController.causeFeaturedList![index].url == null) {
                                                                                    return showSnackBar(subTitle: 'No URL');
                                                                                  }
                                                                                  launchInBrowser(Uri.parse(_causesDetailController.causeFeaturedList![index].url!));
                                                                                });
                                                                          },
                                                                          child:
                                                                              FeaturedSponsors(
                                                                            name: _causesDetailController.causeFeaturedList![index].name,
                                                                            image: _causesDetailController.causeFeaturedList![index].image,
                                                                            logoImage: _causesDetailController.causeFeaturedList![index].logo,
                                                                            givingBack: _causesDetailController.causeFeaturedList![index].contributionAmount,
                                                                            onPressFullContainer: () {},
                                                                          ),
                                                                        );
                                                                      },
                                                                    )),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: sizes
                                                                      .height *
                                                                  0.04),
                                                        ],
                                                      )
                                                    : const SizedBox(),

                                                Padding(
                                                  padding:
                                                      EdgeInsets.symmetric(
                                                          horizontal:
                                                              sizes.width *
                                                                  0.06),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          customTabBar(
                                                              title: Strings.foodDrink,
                                                              isSelected: _causesDetailController.isFoodAndDrink.value,
                                                              isDetail: true,
                                                              onTap: () {
                                                                _causesDetailController.getCauseBottomDetails(_causeId, _causesDetailController.foodDrinkId.value, isBottomTab: true);
                                                                _causesDetailController.setFoodAndDrinkTab();
                                                              }),
                                                          customTabBar(
                                                              title: Strings.toDoThings,
                                                              isSelected:
                                                              _causesDetailController.isThingsToDo.value,
                                                              isDetail: true,
                                                              onTap: () {
                                                                _causesDetailController.getCauseBottomDetails(_causeId, _causesDetailController.thingsToDoId.value, isBottomTab: true);
                                                                _causesDetailController.setThingsToDoTab();
                                                              }),
                                                          customTabBar(
                                                              title: Strings.retail,
                                                              isSelected: _causesDetailController.isRetail.value,
                                                              isDetail: true,
                                                              onTap: () {
                                                                _causesDetailController.getCauseBottomDetails(_causeId, _causesDetailController.retailId.value, isBottomTab: true);
                                                                _causesDetailController.setRetailTab();
                                                              }),
                                                          customTabBar(
                                                              title: Strings.services,
                                                              isSelected: _causesDetailController.isServices.value,
                                                              isDetail: true,
                                                              onTap: () {
                                                                _causesDetailController.getCauseBottomDetails(_causeId, _causesDetailController.servicesId.value, isBottomTab: true);
                                                                _causesDetailController.setServicesTab();
                                                              }),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              sizes.height *
                                                                  0.02),
                                                      Obx(() => _causesDetailController.isBottomTabLoading.value
                                                          ? bouncingLoadingIndicator()
                                                          : _causesDetailController.causeBottomDetails!.isNotEmpty
                                                              ? ListView.separated(
                                                                  scrollDirection: Axis.vertical,
                                                                  shrinkWrap: true,
                                                                  physics: const BouncingScrollPhysics(),
                                                                  itemCount: _causesDetailController.causeBottomDetails!.length,
                                                                  itemBuilder: (context, index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        pushNewScreen(context,
                                                                          screen: BusinessesDetailScreen(businessId: _causesDetailController.causeBottomDetails![index].id),
                                                                          withNavBar: true,
                                                                        );
                                                                      },
                                                                      child: DetailCategoryList(
                                                                        image: _causesDetailController.causeBottomDetails![index].logo,
                                                                        headerText: _causesDetailController.causeBottomDetails![index].name,
                                                                        onViewCourse: () {},
                                                                        categoryPercent: _causesDetailController.causeBottomDetails![index].contributionAmount,
                                                                        address: '${_causesDetailController.causeBottomDetails![index].address1}\n${_causesDetailController.causeBottomDetails?[index].city}, ${_causesDetailController.causeBottomDetails?[index].state}, ${_causesDetailController.causeBottomDetails?[index].zip}',
                                                                        streetAddress: _causesDetailController.causeBottomDetails?[index].address2,
                                                                        phoneNumber: '(${_causesDetailController.causeBottomDetails![index].phone!.substring(0, 3)}) ${_causesDetailController.causeBottomDetails![index].phone!.substring(3, 6)}-${_causesDetailController.causeBottomDetails![index].phone!.substring(6,)}',
                                                                        onPhoneClick: () {
                                                                          openPhoneDialPad('+1${_causesDetailController.causeBottomDetails![index].phone.toString()}', context);
                                                                        },
                                                                        onAddressClick: () async {
                                                                          MapsLauncher.launchQuery('${_causesDetailController.causeBottomDetails![index].address1} ${_causesDetailController.causeBottomDetails?[index].city}, ${_causesDetailController.causeBottomDetails?[index].state}, ${_causesDetailController.causeBottomDetails?[index].zip}');
                                                                        },
                                                                        isRestrictionsApply: _causesDetailController.causeBottomDetails![index].restrictions == null ? false : true,
                                                                        onShowRestrictionsTap:
                                                                            () {
                                                                          customDialog(
                                                                              backgroundImage: _causesDetailController.causeBottomDetails![index].image,
                                                                              icon: _causesDetailController.causeBottomDetails![index].logo,
                                                                              title: _causesDetailController.causeBottomDetails![index].name,
                                                                              description: _causesDetailController.causeBottomDetails![index].restrictions,
                                                                              summary: '',
                                                                              isLearnMoreButton: false);
                                                                        },
                                                                      ),
                                                                    );
                                                                  },
                                                                  separatorBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    return Divider(
                                                                        height: getHeight() *
                                                                            0.04,
                                                                        thickness: getHeight() *
                                                                            0.002,
                                                                        color:
                                                                            AppColors.lightGrey);
                                                                  },
                                                                )
                                                              : handleEmptyState(
                                                                  context,
                                                                  Strings
                                                                      .noBusinessesFound)),
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
                                                    vertical:
                                                        getHeight() * 0.03),
                                                shrinkWrap: true,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                sizes.width *
                                                                    0.06),
                                                    child: Column(
                                                      children: [
                                                        ListView.separated(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          physics:
                                                              const BouncingScrollPhysics(),
                                                          itemCount:
                                                              _causesDetailController
                                                                  .updatedCausesList!
                                                                  .length,
                                                          itemBuilder:
                                                              (context,
                                                                  index) {
                                                            return UpdateFundRaiser(
                                                                header: _causesDetailController
                                                                    .updatedCausesList![
                                                                        index]
                                                                    .title!,
                                                                detail: _causesDetailController
                                                                    .updatedCausesList![
                                                                        index]
                                                                    .message!,
                                                                date:
                                                                    'Mar 6th');
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
                                                                    .lightGrey);
                                                          },
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                sizes.height *
                                                                    0.03),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : handleEmptyState(context,
                                                Strings.noCauseUpdates),

                                        /// 3rd page
                                        ListView(
                                          padding: EdgeInsets.symmetric(
                                              vertical: getHeight() * 0.03),
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      sizes.width * 0.06),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextView.caption(
                                                      Strings
                                                          .contributionsOverTime,
                                                      color: AppColors
                                                          .blackColor,
                                                      fontFamily: Assets
                                                          .poppinsMedium,
                                                      fontSize:
                                                          sizes.fontSize18),
                                                  SizedBox(height: 0.5.h),
                                                  TextView.caption(
                                                      Strings
                                                          .numberOfContributions,
                                                      color:
                                                          AppColors.darkGrey,
                                                      fontFamily: Assets
                                                          .poppinsRegular,
                                                      fontSize:
                                                          sizes.fontSize13,
                                                      lines: 2),
                                                  SizedBox(height: 0.7.h),

                                                  ///chart v2
                                                  GetBuilder<
                                                          CausesDetailController>(
                                                      id: 'causesBuilder',
                                                      builder: (_) {
                                                        return StatsBarChartWidget(
                                                          popUpTitle:
                                                              'Causes Stats',
                                                          dataSource:
                                                              _causesDetailController
                                                                  .causesStatsHistory,
                                                        );
                                                      }),
                                                  SizedBox(height: 3.h),
                                                  TextView.titleWithDecoration(
                                                      Strings.topContributions,
                                                      color: AppColors.blackColor,
                                                      fontFamily: Assets.poppinsMedium,
                                                      fontSize: sizes.fontSize16),
                                                  SizedBox(height: 2.h),
                                                  _causesDetailController
                                                          .causesStats!
                                                          .topContributors!
                                                          .isNotEmpty
                                                      ? ListView.separated(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          physics:
                                                              const BouncingScrollPhysics(),
                                                          itemCount:
                                                              _causesDetailController
                                                                  .causesStats!
                                                                  .topContributors!
                                                                  .length,
                                                          itemBuilder:
                                                              (context,
                                                                  index) {
                                                            return RecentContributions(
                                                                contributorName: _causesDetailController
                                                                    .causesStats!
                                                                    .topContributors![
                                                                        index]
                                                                    .name,
                                                                amount: _causesDetailController
                                                                    .causesStats!
                                                                    .topContributors![
                                                                        index]
                                                                    .amount
                                                                    ?.toStringAsFixed(
                                                                        2));
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
                                                                    .lightGrey);
                                                          },
                                                        )
                                                      : handleEmptyState(
                                                          context,
                                                          Strings
                                                              .noRecentContributions),
                                                  SizedBox(
                                                      height:
                                                          getHeight() * 0.03),
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
                            )
                          ],
                        ),
        ),
      ),
    );
  }

  getCauseDetail(int _id) {
    Future.delayed(10.milliseconds, () async {
      _causesDetailController.getCauseDetail(_id);
      _causesDetailController.getCauseStats(_id);
      _causesDetailController.getCauseFeatured(_id);
      bool _isUserAuthenticated = PreferenceUtils.isUserAuthenticated();
      if (_isUserAuthenticated) {
        _causesDetailController.getFollowCause(_id);
      }
      _causesDetailController.getUpdatedCauses(_id);
      _causesDetailController.getCauseAdvertisements(_id);
      await _causesDetailController.fetchBusinessCategories();
      _causesDetailController.getCauseBottomDetails(_id, _causesDetailController.foodDrinkId.value);

    });
  }
}
