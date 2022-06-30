import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import 'package:thinknlocal_app/common/handling_empty_states.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/common/utils.dart';
import 'package:thinknlocal_app/config/firebase_dynamic_links.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/local/deep_link_info.dart';
import 'package:thinknlocal_app/local/my_hive.dart';
import 'package:thinknlocal_app/screens/bottom_tab/causes/upcoming_causes.dart';
import 'package:thinknlocal_app/screens/businesses_detail/business_detail_controller.dart';
import 'package:thinknlocal_app/screens/businesses_detail/business_detail_top_container.dart';
import 'package:thinknlocal_app/screens/businesses_detail/business_rating.dart';
import 'package:thinknlocal_app/screens/businesses_detail/recently_funded_business.dart';
import 'package:thinknlocal_app/screens/causes_detail/causes_detail.dart';
import 'package:thinknlocal_app/screens/causes_detail/recent_contributions.dart';
import 'package:thinknlocal_app/screens/causes_detail_listing/causes_listing.dart';
import 'package:thinknlocal_app/widgets/common_widgets.dart';
import 'package:thinknlocal_app/widgets/graph_widget.dart';
import 'package:thinknlocal_app/widgets/loading_indicator.dart';
import 'package:thinknlocal_app/widgets/network_error.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';

import '../../../res/res.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';

class BusinessesDetailScreen extends StatelessWidget {
  final int? businessId;

  BusinessesDetailScreen({this.businessId, Key? key}) : super(key: key);
  final BusinessDetailController _businessDetailController = Get.put(BusinessDetailController());

  @override
  Widget build(BuildContext context) {
    final _id = businessId;
    getBusinessDetails(_id!);

    return Scaffold(
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
                  ? bouncingLoadingIndicator()
                  : _businessDetailController.businessDetail == null
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
                                  SizedBox(
                                    height: sizes.height * 0.35,
                                    child: _businessDetailController
                                            .isLoading.value
                                        ? bouncingLoadingIndicator()
                                        : BusinessDetailTopContainer(
                                            name: _businessDetailController
                                                .businessDetail!.name,
                                            fullBoxImage: _businessDetailController
                                                    .businessDetail?.image ??
                                                Strings.dummyBgImage,
                                            logoImage: _businessDetailController
                                                    .businessDetail?.logo ??
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
                                            address: '${_businessDetailController.businessDetail!.address1}\n${_businessDetailController.businessDetail!.city}, ${_businessDetailController.businessDetail!.state}, ${_businessDetailController.businessDetail!.zip}',
                                            phoneNumber:
                                                '(${_businessDetailController.businessDetail!.phone!.substring(0, 3)}) ${_businessDetailController.businessDetail!.phone!.substring(3, 6)}-${_businessDetailController.businessDetail!.phone!.substring(
                                              6,
                                            )}',
                                            isFavorite:
                                                _businessDetailController
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
                                              FirebaseDynamicApi.buildDynamicLinks(Strings.businesses, _id.toString());
                                              DeepLinkInfo? _deepLinkInfo = MyHive.getDeepLinkInfo();
                                              MyHive.setDeepLinkInfo(DeepLinkInfo(causeId: _deepLinkInfo?.causeId, businessId: _id, organizationId: _deepLinkInfo?.organizationId));
                                            },
                                            onPhoneClick: () {
                                              openPhoneDialPad('+1${_businessDetailController.businessDetail!.phone.toString()}', context);
                                            },
                                            onAddressClick: () {
                                              MapsLauncher.launchQuery('${_businessDetailController.businessDetail!.address1}\n${_businessDetailController.businessDetail!.city}, ${_businessDetailController.businessDetail!.state}, ${_businessDetailController.businessDetail!.zip}');
                                            }),
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
                                      controller: _businessDetailController
                                          .tabController,
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
                                      unselectedLabelColor:
                                          AppColors.darkGrey,
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
                                      controller: _businessDetailController
                                          .tabController,
                                      children: [
                                        _businessDetailController
                                                .isLoading.value
                                            ? bouncingLoadingIndicator()
                                            : ListView(
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
                                                        TextView.caption(
                                                            _businessDetailController
                                                                .businessDetail!
                                                                .description,
                                                            color: AppColors
                                                                .blackColor,
                                                            fontFamily: Assets
                                                                .poppinsRegular,
                                                            lines: 3,
                                                            fontSize: sizes
                                                                .fontSize12),
                                                        SizedBox(
                                                            height:
                                                                sizes.height *
                                                                    0.03),
                                                        BusinessRating(
                                                            starRating: _businessDetailController.businessDetail!.rating,
                                                            onPress: () {}
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: sizes.height * 0.03),
                                                  _businessDetailController.recentlyFundedBusinessCausesList!.isNotEmpty
                                                      ? Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.06),
                                                              child: TextView.titleWithDecoration(
                                                                  Strings.recentlyFunded,
                                                                  color: AppColors.blackColor,
                                                                  fontFamily: Assets.poppinsMedium,
                                                                  fontSize: sizes.fontSize16),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets.only(top: getHeight() * 0.01),
                                                                child: SizedBox(
                                                                  width: getWidth(),
                                                                  height: getHeight() * 0.18,
                                                                  child: ListView.builder(
                                                                    shrinkWrap: true,
                                                                    physics: const BouncingScrollPhysics(),
                                                                    scrollDirection: Axis.horizontal,
                                                                    itemCount: _businessDetailController.recentlyFundedBusinessCausesList!.length > 6 ? 6 : _businessDetailController.recentlyFundedBusinessCausesList!.length,
                                                                    itemBuilder: (context, index) {
                                                                      return index == (_businessDetailController.recentlyFundedBusinessCausesList!.length > 6 ? 5 : _businessDetailController.recentlyFundedBusinessCausesList!.length - 1)
                                                                          ? GestureDetector(
                                                                              onTap: () {
                                                                                Get.to(() => CausesListingScreen(title: Strings.recentlyFundedBusinessCauses, detailList: _businessDetailController.recentlyFundedBusinessCausesList as dynamic));
                                                                              },
                                                                              child: CommonWidgets.seeAllButton(30))
                                                                          : GestureDetector(
                                                                              onTap: () {
                                                                                pushNewScreen(
                                                                                  context,
                                                                                  screen: CausesDetail(causeId: _businessDetailController.recentlyFundedBusinessCausesList![index].id, organizationId: _businessDetailController.recentlyFundedBusinessCausesList![index].organization!.id),
                                                                                  withNavBar: true,
                                                                                );
                                                                              },
                                                                              child: RecentlyFundedBusiness(
                                                                                name: _businessDetailController.recentlyFundedBusinessCausesList![index].name,
                                                                                fullImage: _businessDetailController.recentlyFundedBusinessCausesList![index].image,
                                                                                logoImage: _businessDetailController.recentlyFundedBusinessCausesList![index].organization!.logo,
                                                                                isFavorite: _businessDetailController.recentlyFundedBusinessCausesList![index].isFavorite!,
                                                                                endDate: _businessDetailController.recentlyFundedBusinessCausesList![index].end,
                                                                                raisedAmount: _businessDetailController.recentlyFundedBusinessCausesList![index].raised.toString(),
                                                                                totalAmount: _businessDetailController.recentlyFundedBusinessCausesList![index].goal.toString(),
                                                                                dateStatus: _businessDetailController.recentlyFundedBusinessCausesList![index].status!,
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
                                                                                  }
                                                                                  else {
                                                                                    _businessDetailController.recentlyFundedBusinessCausesList![index].isFavorite = true;
                                                                                  }
                                                                                  _businessDetailController.getRecentlyFundedBusinessCauses(id: _id);
                                                                                },
                                                                              ),
                                                                            );
                                                                    },
                                                                  ),
                                                                )),
                                                            SizedBox(height: sizes.height * 0.03),
                                                          ],
                                                        )
                                                      : const SizedBox(),
                                                  _businessDetailController.pastFundedBusinessCausesList!.isNotEmpty
                                                      ? Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.06),
                                                              child: CommonWidgets
                                                                  .getTextWithSeeAll(
                                                                      leadingText: Strings.pastFundedCauses,
                                                                      trailingText: Strings.seeAll,
                                                                      onPressSeeAllButton: () {
                                                                        Get.to(() => CausesListingScreen(
                                                                            title: Strings.pastFundedBusinessCauses,
                                                                            detailList: _businessDetailController.pastFundedBusinessCausesList as dynamic));
                                                                      }),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal: sizes.width * 0.06,
                                                                  vertical: getHeight() * 0.005),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(height: sizes.height * 0.01),
                                                                  ListView.separated(
                                                                    scrollDirection: Axis.vertical,
                                                                    shrinkWrap: true,
                                                                    physics: const BouncingScrollPhysics(),
                                                                    itemCount: _businessDetailController.pastFundedBusinessCausesList!.length > 4
                                                                        ? 4
                                                                        : _businessDetailController.pastFundedBusinessCausesList!.length,
                                                                    itemBuilder: (context, index) {
                                                                      dynamic _raisedFormattedAmount = commaFormatter(double.parse(_businessDetailController.pastFundedBusinessCausesList![index].raised.toString()));
                                                                      return GestureDetector(
                                                                        onTap: (){
                                                                          pushNewScreen(
                                                                            context,
                                                                            screen: CausesDetail(
                                                                                causeId:  _businessDetailController.pastFundedBusinessCausesList![index].id,
                                                                                organizationId:  _businessDetailController.pastFundedBusinessCausesList![index].organization!.id),
                                                                                withNavBar: true,
                                                                          );
                                                                        },
                                                                        child: UpcomingCauses(
                                                                            image: _businessDetailController.pastFundedBusinessCausesList![index].organization!.logo,
                                                                            headerText: _businessDetailController.pastFundedBusinessCausesList![index].name,
                                                                            description: _businessDetailController.pastFundedBusinessCausesList![index].description,
                                                                            onViewCourse: () {},
                                                                            totalAmount: _raisedFormattedAmount,
                                                                            date: _businessDetailController.pastFundedBusinessCausesList![index].start),
                                                                      );
                                                                    },
                                                                    separatorBuilder:
                                                                        (BuildContext context,
                                                                            int index) {
                                                                      return Divider(
                                                                          height: getHeight() *
                                                                              0.04,
                                                                          thickness: getHeight() *
                                                                              0.002,
                                                                          color:
                                                                              AppColors.borderColor);
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                      height: getHeight() *
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
                                        _businessDetailController
                                                .isLoading.value
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
                                                    const BouncingScrollPhysics(),
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                sizes.width *
                                                                    0.06),
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
                                                            fontSize: sizes
                                                                .fontSize18),
                                                        SizedBox(
                                                            height: 0.5.h),
                                                        TextView.caption(
                                                            Strings
                                                                .numberOfContributions,
                                                            color: AppColors
                                                                .darkGrey,
                                                            fontFamily: Assets
                                                                .poppinsRegular,
                                                            fontSize: sizes
                                                                .fontSize13),
                                                        SizedBox(
                                                            height: 0.7.h),

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
                                                        TextView.titleWithDecoration(
                                                            Strings.recentContributions,
                                                            color: AppColors.blackColor,
                                                            fontFamily: Assets.poppinsMedium,
                                                            fontSize: sizes.fontSize16),
                                                        SizedBox(height: 2.h),
                                                        _businessDetailController
                                                                .businessStats!
                                                                .recentContributions!
                                                                .isNotEmpty
                                                            ? ListView
                                                                .separated(
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    const BouncingScrollPhysics(),
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
                                                                          .recentContributions![index]
                                                                          .amount
                                                                          ?.toStringAsFixed(2));
                                                                },
                                                                separatorBuilder: (BuildContext context, int index) {
                                                                  return Divider(
                                                                      height: getHeight() * 0.04,
                                                                      thickness: getHeight() * 0.002,
                                                                      color: AppColors.borderColor);
                                                                },
                                                              )
                                                            : handleEmptyState(context, Strings.noRecentContributions),
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
                            )
                          ],
                        ),
        ),
      ),
    );
  }

  getBusinessDetails(int _id) {
    Future.delayed(10.milliseconds, () {
      _businessDetailController.getBusinessDetails(id: _id);
      _businessDetailController.getBusinessStats(id: _id);
      _businessDetailController.getRecentlyFundedBusinessCauses(id: _id);
      _businessDetailController.getPastFundedBusinessCauses(id: _id);
      bool _isUserAuthenticated = PreferenceUtils.isUserAuthenticated();
      if (_isUserAuthenticated) {
        _businessDetailController.getFollowBusiness(id: _id);
      }
    });
  }
}
