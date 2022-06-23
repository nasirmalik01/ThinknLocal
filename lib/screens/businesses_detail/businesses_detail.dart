import 'package:flutter/material.dart';
import 'package:flutter_app/common/handling_empty_states.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/config/firebase_dynamic_links.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/deep_link_info.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/screens/bottom_tab/causes/upcoming_causes.dart';
import 'package:flutter_app/screens/businesses_detail/business_detail_controller.dart';
import 'package:flutter_app/screens/businesses_detail/business_detail_top_container.dart';
import 'package:flutter_app/screens/businesses_detail/business_rating.dart';
import 'package:flutter_app/screens/businesses_detail/recently_funded_business.dart';
import 'package:flutter_app/screens/causes_detail/recent_contributions.dart';
import 'package:flutter_app/screens/causes_detail_listing/causes_listing.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/graph_widget.dart';
import 'package:flutter_app/widgets/network_error.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sizer/sizer.dart';

import '../../../res/res.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';

class BusinessesDetailScreen extends StatelessWidget {
  BusinessesDetailScreen({Key? key}) : super(key: key);
  final BusinessDetailController _businessDetailController =
      Get.put(BusinessDetailController());

  @override
  Widget build(BuildContext context) {
    final _id = ModalRoute.of(context)!.settings.arguments as int;
    getBusinessDetails(_id);
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          color: AppColors.greenColor,
          onRefresh: () async {
            getBusinessDetails(_id);
          },
          child: Obx(
            () => _businessDetailController.isError.value
                ? NetworkErrorException(
                    exceptionMessage:
                        _businessDetailController.errorMessage.value,
                    onPress: () {
                      _businessDetailController.isError.value = false;
                      getBusinessDetails(_id);
                    })
                : (_businessDetailController.isLoading.value ||
                        _businessDetailController.isStatsLoading.value ||
                        _businessDetailController
                            .isRecentlyFundedBusinessCauses.value ||
                        _businessDetailController
                            .isPastFundedBusinessCauses.value)
                    ? circularProgressIndicator()
                    : CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: true,
                            fillOverscroll: true,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: sizes.height * 0.35,
                                  child: _businessDetailController
                                          .isLoading.value
                                      ? circularProgressIndicator()
                                      : BusinessDetailTopContainer(
                                          name: _businessDetailController
                                              .businessDetail!.name,
                                          fullBoxImage:
                                              _businessDetailController
                                                      .businessDetail!.image ??
                                                  Strings.dummyBgImage,
                                          logoImage: _businessDetailController
                                                  .businessDetail!.logo ??
                                              Strings.dummyLogo,
                                          completePercentage: 0.7,
                                          contributedAmount:
                                              _businessDetailController
                                                  .businessDetail!
                                                  .contributionAmount
                                                  .toString(),
                                          totalAmount: _businessDetailController
                                              .businessDetail!
                                              .totalContributions
                                              .toString(),
                                          joinDate: _businessDetailController
                                              .businessDetail!.createdAt
                                              .toString(),
                                          streetAddress:
                                              _businessDetailController
                                                  .businessDetail!.address2,
                                          address: _businessDetailController
                                              .businessDetail!.address1,
                                          phoneNumber:
                                              '(${_businessDetailController.businessDetail!.phone!.substring(0, 3)}) ${_businessDetailController.businessDetail!.phone!.substring(3, 6)}-${_businessDetailController.businessDetail!.phone!.substring(
                                            6,
                                          )}',
                                          isFavorite: _businessDetailController
                                              .isBusinessFollowed.value,
                                          onClickBox: () {},
                                          onPressBackArrow: () {
                                            Navigator.pop(context, 1);
                                            return Future.value(true);
                                          },
                                          onPressFavoriteIcon: () {
                                            _businessDetailController
                                                .followBusiness(_id);
                                          },
                                          onShareClick: () {
                                            FirebaseDynamicApi.buildDynamicLinks(
                                                Strings.businesses,
                                                _id.toString());
                                            DeepLinkInfo? _deepLinkInfo =
                                                MyHive.getDeepLinkInfo();
                                            MyHive.setDeepLinkInfo(DeepLinkInfo(
                                                causeId: _deepLinkInfo?.causeId,
                                                businessId: _id,
                                                organizationId: _deepLinkInfo
                                                    ?.organizationId));
                                          },
                                          onPhoneClick: () {
                                            openPhoneDialPad(
                                                '+1${_businessDetailController.businessDetail!.phone.toString()}',
                                                context);
                                          },
                                          onAddressClick: () {
                                            MapsLauncher.launchQuery(
                                                _businessDetailController
                                                    .businessDetail!.address1!);
                                          },
                                        ),
                                ),
                                SizedBox(height: sizes.height * 0.01),
                                Container(
                                  height: getHeight() * 0.045,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: getWidth() * 0.05,
                                      vertical: getHeight() * 0.01),
                                  decoration: BoxDecoration(
                                    color: AppColors.boxGrey,
                                    borderRadius: BorderRadius.circular(
                                        getHeight() * 0.01),
                                  ),
                                  child: TabBar(
                                    controller:
                                        _businessDetailController.tabController,
                                    onTap: (index) {},
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          getHeight() * 0.01),
                                      color: AppColors.lightBlue,
                                    ),
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
                                    tabs: const [
                                      Tab(
                                        text: Strings.overview,
                                      ),
                                      Tab(
                                        text: Strings.stats,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    controller:
                                        _businessDetailController.tabController,
                                    children: [
                                      _businessDetailController.isLoading.value
                                          ? circularProgressIndicator()
                                          : ListView(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          sizes.width * 0.06),
                                                  child: Column(
                                                    children: [
                                                      TextView.caption(
                                                          _businessDetailController
                                                              .businessDetail!
                                                              .description,
                                                          color: AppColors
                                                              .blackColor,
                                                          fontFamily: Assets
                                                              .poppinsRegular,
                                                          lines: 3,
                                                          fontSize:
                                                              sizes.fontSize12),
                                                      SizedBox(
                                                          height: sizes.height *
                                                              0.03),
                                                      BusinessRating(
                                                          starRating:
                                                              _businessDetailController
                                                                  .businessDetail!
                                                                  .rating,
                                                          onPress: () {}),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        sizes.height * 0.03),
                                                _businessDetailController
                                                        .recentlyFundedBusinessCausesList!
                                                        .isNotEmpty
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        getWidth() *
                                                                            0.06),
                                                            child: TextView.titleWithDecoration(
                                                                Strings
                                                                    .recentlyFunded,
                                                                color: AppColors
                                                                    .blackColor,
                                                                fontFamily: Assets
                                                                    .poppinsMedium,
                                                                fontSize: sizes
                                                                    .fontSize16),
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: getHeight() *
                                                                          0.01),
                                                              child: SizedBox(
                                                                height:
                                                                    getHeight() *
                                                                        0.18,
                                                                child: ListView
                                                                    .builder(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemCount: _businessDetailController
                                                                              .recentlyFundedBusinessCausesList!
                                                                              .length >
                                                                          6
                                                                      ? 6
                                                                      : _businessDetailController
                                                                          .recentlyFundedBusinessCausesList!
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return index ==
                                                                            5
                                                                        ? GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Get.to(() => CausesListingScreen(title: Strings.recentlyFundedBusinessCauses, detailList: _businessDetailController.recentlyFundedBusinessCausesList as dynamic));
                                                                            },
                                                                            child:
                                                                                CommonWidgets.seeAllButton(30))
                                                                        : GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Get.toNamed(Routes.causesDetailScreen, arguments: {
                                                                                Strings.causeId: _businessDetailController.recentlyFundedBusinessCausesList![index].id,
                                                                                Strings.organizationId: _businessDetailController.recentlyFundedBusinessCausesList![index].organization!.id,
                                                                              });
                                                                            },
                                                                            child:
                                                                                RecentlyFundedBusiness(
                                                                              name: _businessDetailController.recentlyFundedBusinessCausesList![index].name,
                                                                              fullImage: _businessDetailController.recentlyFundedBusinessCausesList![index].image,
                                                                              logoImage: _businessDetailController.recentlyFundedBusinessCausesList![index].organization!.logo,
                                                                              isFavorite: _businessDetailController.recentlyFundedBusinessCausesList![index].isFavorite!,
                                                                              endDate: _businessDetailController.recentlyFundedBusinessCausesList![index].end,
                                                                              raisedAmount: _businessDetailController.recentlyFundedBusinessCausesList![index].raised.toString(),
                                                                              totalAmount: _businessDetailController.recentlyFundedBusinessCausesList![index].goal.toString(),
                                                                              colors: const [
                                                                                Colors.transparent,
                                                                                AppColors.blackColor,
                                                                              ],
                                                                              recentlyFundedBusinessList: _businessDetailController.recentlyFundedBusinessCausesList!,
                                                                              index: index,
                                                                              onPressFullContainer: () {},
                                                                              onFavPress: () {
                                                                                bool _isFavorite = _businessDetailController.recentlyFundedBusinessCausesList![index].isFavorite!;
                                                                                int _causeId = _businessDetailController.recentlyFundedBusinessCausesList![index].id!;
                                                                                _businessDetailController.followCauses(_causeId, _isFavorite);
                                                                                if (_isFavorite) {
                                                                                  _businessDetailController.recentlyFundedBusinessCausesList![index].isFavorite = false;
                                                                                } else {
                                                                                  _businessDetailController.recentlyFundedBusinessCausesList![index].isFavorite = true;
                                                                                }
                                                                                _businessDetailController.getRecentlyFundedBusinessCauses(id: _id);
                                                                              },
                                                                            ),
                                                                          );
                                                                  },
                                                                ),
                                                              )),
                                                          SizedBox(
                                                              height:
                                                                  sizes.height *
                                                                      0.03),
                                                        ],
                                                      )
                                                    : const SizedBox(),
                                                _businessDetailController
                                                        .pastFundedBusinessCausesList!
                                                        .isNotEmpty
                                                    ? Column(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        getWidth() *
                                                                            0.06),
                                                            child: CommonWidgets
                                                                .getTextWithSeeAll(
                                                                    leadingText:
                                                                        Strings
                                                                            .pastFundedCauses,
                                                                    trailingText:
                                                                        Strings
                                                                            .seeAll,
                                                                    onPressSeeAllButton:
                                                                        () {
                                                                      Get.to(() => CausesListingScreen(
                                                                          title: Strings
                                                                              .pastFundedBusinessCauses,
                                                                          detailList:
                                                                              _businessDetailController.pastFundedBusinessCausesList as dynamic));
                                                                    }),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    sizes.width *
                                                                        0.06,
                                                                vertical:
                                                                    getHeight() *
                                                                        0.005),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                    height: sizes
                                                                            .height *
                                                                        0.01),
                                                                ListView
                                                                    .separated(
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const ScrollPhysics(),
                                                                  itemCount: _businessDetailController
                                                                              .pastFundedBusinessCausesList!
                                                                              .length >
                                                                          4
                                                                      ? 4
                                                                      : _businessDetailController
                                                                          .pastFundedBusinessCausesList!
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    dynamic _raisedFormattedAmount = commaFormatter(double.parse(_businessDetailController
                                                                        .pastFundedBusinessCausesList![
                                                                            index]
                                                                        .raised
                                                                        .toString()));

                                                                    return UpcomingCauses(
                                                                        image: _businessDetailController
                                                                            .pastFundedBusinessCausesList![
                                                                                index]
                                                                            .image,
                                                                        headerText: _businessDetailController
                                                                            .pastFundedBusinessCausesList![
                                                                                index]
                                                                            .name,
                                                                        description: _businessDetailController
                                                                            .pastFundedBusinessCausesList![
                                                                                index]
                                                                            .description,
                                                                        onViewCourse:
                                                                            () {},
                                                                        totalAmount:
                                                                            _raisedFormattedAmount,
                                                                        date: _businessDetailController
                                                                            .pastFundedBusinessCausesList![index]
                                                                            .start);
                                                                  },
                                                                  separatorBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    return Divider(
                                                                        height: getHeight() *
                                                                            0.04,
                                                                        thickness:
                                                                            getHeight() *
                                                                                0.002,
                                                                        color: AppColors
                                                                            .borderColor);
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        getHeight() *
                                                                            0.03),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : const SizedBox()
                                              ],
                                            ),

                                      /// End of businesses overview
                                      _businessDetailController.isLoading.value
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: getHeight() * 0.1),
                                              child: Wrap(
                                                children: [
                                                  Center(
                                                    child: SizedBox(
                                                      width: getWidth() * 1,
                                                      child:
                                                          const SpinKitFadingCircle(
                                                        color: AppColors
                                                            .greenColor,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : ListView(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          sizes.width * 0.06),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                          color: AppColors
                                                              .darkGrey,
                                                          fontFamily: Assets
                                                              .poppinsRegular,
                                                          fontSize:
                                                              sizes.fontSize13),
                                                      SizedBox(height: 0.7.h),

                                                      ///Business-chart
                                                      GetBuilder<
                                                              BusinessDetailController>(
                                                          id: 'businessBuilder',
                                                          builder: (_) {
                                                            return StatsBarChartWidget(
                                                              popUpTitle:
                                                                  'Business Stats',
                                                              dataSource:
                                                                  _businessDetailController
                                                                      .businessStatsHistory,
                                                            );
                                                          }),
                                                      SizedBox(height: 3.h),
                                                      CommonWidgets.getTextWithSeeAll(
                                                          leadingText: Strings
                                                              .recentContributions,
                                                          trailingText:
                                                              Strings.seeAll,
                                                          onPressSeeAllButton:
                                                              () {}),
                                                      SizedBox(height: 2.h),
                                                      _businessDetailController
                                                              .businessStats!
                                                              .recentContributions!
                                                              .isNotEmpty
                                                          ? ListView.separated(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              shrinkWrap: true,
                                                              physics:
                                                                  const ScrollPhysics(),
                                                              itemCount: _businessDetailController
                                                                          .businessStats!
                                                                          .recentContributions!
                                                                          .length >
                                                                      9
                                                                  ? 9
                                                                  : _businessDetailController
                                                                      .businessStats!
                                                                      .recentContributions!
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return RecentContributions(
                                                                    contributorName: _businessDetailController
                                                                        .businessStats!
                                                                        .recentContributions![
                                                                            index]
                                                                        .name,
                                                                    amount: _businessDetailController
                                                                        .businessStats!
                                                                        .recentContributions![
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
                                                                        .borderColor);
                                                              },
                                                            )
                                                          : handleEmptyState(
                                                              context,
                                                              Strings
                                                                  .noRecentContributions),
                                                      SizedBox(
                                                          height: getHeight() *
                                                              0.03),
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
      ),
    );
  }

  getBusinessDetails(int _id) {
    _businessDetailController.getBusinessDetails(id: _id);
    _businessDetailController.getBusinessStats(id: _id);
    _businessDetailController.getRecentlyFundedBusinessCauses(id: _id);
    _businessDetailController.getPastFundedBusinessCauses(id: _id);
    bool _isUserAuthenticated = PreferenceUtils.isUserAuthenticated();
    if (_isUserAuthenticated) {
      _businessDetailController.getFollowBusiness(id: _id);
    }
  }
}
