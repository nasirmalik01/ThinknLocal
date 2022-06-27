import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/handling_empty_states.dart';
import 'package:thinknlocal_app/common/utils.dart';
import 'package:thinknlocal_app/constants/routes.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/screens/bottom_tab/businesses/business_nearby.dart';
import 'package:thinknlocal_app/screens/bottom_tab/businesses/business_tabs_container.dart';
import 'package:thinknlocal_app/screens/bottom_tab/businesses/businesses_components.dart';
import 'package:thinknlocal_app/screens/bottom_tab/businesses/businesses_controller.dart';
import 'package:thinknlocal_app/screens/bottom_tab/businesses/recently_added_business.dart';
import 'package:thinknlocal_app/screens/business_detail_listing/main_businesses_listing.dart';
import 'package:thinknlocal_app/screens/business_detail_listing/nearby_businesses_listing.dart';
import 'package:thinknlocal_app/screens/business_detail_listing/recently_added_businesses.dart';
import 'package:thinknlocal_app/screens/businesses_categories/business_category.dart';
import 'package:thinknlocal_app/screens/businesses_detail/businesses_detail.dart';
import 'package:thinknlocal_app/screens/location_search/location_search_controller.dart';
import 'package:thinknlocal_app/widgets/custom_tab_bar.dart';
import 'package:thinknlocal_app/widgets/loading_indicator.dart';
import 'package:thinknlocal_app/widgets/network_error.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';
class BusinessesScreen extends StatelessWidget {
  BusinessesScreen({Key? key}) : super(key: key);
  final TextEditingController? searchController = TextEditingController();
  final BusinessesComponents _businessesComponents = BusinessesComponents();
  final BusinessesController _businessesController =
  Get.put(BusinessesController());
  final LocationSearchController _locationSearchController =
  Get.put(LocationSearchController());
  final bool _isUserAuthenticated = PreferenceUtils.isUserAuthenticated();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        color: AppColors.greenColor,
        onRefresh: () async {
          _businessesController
              .getBusinesses(_businessesController.selectedCategory.value);
          _businessesController.getRecentlyAddedBusinesses();
          _businessesController.getNearbyBusinesses();
        },
        child: Obx(
              () => _businessesController.isError.value
              ? NetworkErrorException(
              exceptionMessage: _businessesController.errorMessage.value,
              onPress: () {
                _businessesController.isError.value = false;
                _businessesController.getBusinesses(Strings.featured);
              })
              : Container(
            height: sizes.height,
            width: sizes.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: PreferenceUtils.getGradient()
              ),
            ),
            child: ListView(
              // controller: _businessesController.scrollController,
              children: [
                Container(
                  height: getHeight() * 0.12,
                  width: getWidth(),
                  padding: EdgeInsets.only(
                      left: sizes.width * 0.06,
                      right: sizes.width * 0.06,
                      top: sizes.height * 0.02),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: PreferenceUtils.getGradient()),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView.titleWithDecoration(
                        Strings.businessNear,
                        color: AppColors.darkGrey,
                        fontFamily: Assets.poppinsRegular,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Get.toNamed(
                              Routes.locationSearchScreen);
                          _businessesController.onInit();
                        },
                        child: Row(
                          children: [
                            TextView.header(
                                _locationSearchController
                                    .locationAddress.value,
                                color: AppColors.greenColor,
                                fontFamily: Assets.poppinsRegular,
                                textDecoration:
                                TextDecoration.underline,
                                fontSize: sizes.fontSize25),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 1.w, bottom: 0.5.h),
                              child: Image(
                                color: AppColors.greenColor,
                                height: getHeight() * 0.03,
                                image:
                                const AssetImage(Assets.vectorIcon),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: AppColors.pureWhiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizes.width * 0.06),
                        child: Column(
                          children: [
                            CommonWidgets.searchLocationTextField(
                                controller: searchController,
                                hint: Strings.searchBusiness,
                                onPressSearch: () {
                                  Get.toNamed(Routes.businessSearch);
                                }),
                            SizedBox(height: getHeight() * 0.03),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                _businessesComponents
                                    .businessCategoryIcon(
                                    image: Assets.foodIcon,
                                    label: Strings.foodDrink,
                                    onPressCategory: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BusinessCategory(
                                                    businessType:
                                                    Strings
                                                        .foodDrink,
                                                    icon: Assets
                                                        .foodIcon,
                                                    id: 22,
                                                  )));
                                    }),
                                _businessesComponents
                                    .businessCategoryIcon(
                                    image: Assets.thingsIcon,
                                    label: Strings.toDoThings,
                                    onPressCategory: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BusinessCategory(
                                                    businessType:
                                                    Strings
                                                        .toDoThings,
                                                    icon: Assets
                                                        .thingsIcon,
                                                    id: 29,
                                                  )));
                                    }),
                                _businessesComponents
                                    .businessCategoryIcon(
                                    image: Assets.bagIcon,
                                    label: Strings.retail,
                                    onPressCategory: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BusinessCategory(
                                                    businessType:
                                                    Strings
                                                        .retail,
                                                    icon: Assets
                                                        .bagIcon,
                                                    id: 3,
                                                  )));
                                    }),
                                _businessesComponents
                                    .businessCategoryIcon(
                                    image: Assets.servicesIcon,
                                    label: Strings.services,
                                    onPressCategory: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BusinessCategory(
                                                    businessType:
                                                    Strings
                                                        .services,
                                                    icon: Assets
                                                        .servicesIcon,
                                                    id: 33,
                                                  )));
                                    }),
                              ],
                            ),
                            SizedBox(height: getHeight() * 0.04),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                customTabBar(
                                    title: Strings.featured.capitalize!,
                                    isSelected: _businessesController
                                        .isFeatured.value,
                                    onTap: () {
                                      _businessesController
                                          .setFeaturedTab();
                                    }),
                                customTabBar(
                                    title: Strings.trending.capitalize!,
                                    isSelected: _businessesController
                                        .isTrending.value,
                                    onTap: () {
                                      _businessesController
                                          .setTrendingTab();
                                    }),
                                _isUserAuthenticated
                                    ? customTabBar(
                                    title:
                                    Strings.favorites.capitalize!,
                                    isSelected: _businessesController
                                        .isFavorites.value,
                                    onTap: () {
                                      _businessesController
                                          .setFavoritesTab();
                                    })
                                    : SizedBox(
                                  width: getWidth() * 0.14,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: getHeight() * 0.01),
                      SizedBox(
                        height: 20.h,
                        child: _businessesController
                            .isBusinessLoading.value
                            ? bouncingLoadingIndicator()
                            : _businessesController
                            .businessList!.isNotEmpty
                            ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: _businessesController
                              .businessList!.isEmpty
                              ? 0
                              : _businessesController
                              .businessList!
                              .length >
                              6
                              ? 6
                              : _businessesController
                              .businessList!.length,
                          itemBuilder: (context, index) {
                            return index == 5
                                ? GestureDetector(
                                onTap: () async {
                                  Get.to(() =>
                                      MainBusinessListing(
                                          title: _businessesController
                                              .selectedCategory
                                              .value ==
                                              Strings
                                                  .featured
                                              ? Strings
                                              .featured
                                              .capitalizeFirst
                                              : _businessesController
                                              .selectedCategory
                                              .value ==
                                              Strings
                                                  .trending
                                              ? Strings
                                              .trending
                                              .capitalizeFirst
                                              : Strings
                                              .favorites));
                                },
                                child:
                                CommonWidgets
                                    .seeAllButton(40))
                                : BusinessTabContainer(
                                name: _businessesController.businessList![index].name,
                                fullBoxImage: _businessesController.businessList![index].image ?? Strings.dummyBgImage,
                                logoImage: _businessesController.businessList![index].logo ?? Strings.dummyLogo,
                                bookName: '',
                                streetAddress: _businessesController.businessList![index].address1,
                                address: _businessesController.businessList![index].address2,
                                phoneNumber: '(${_businessesController.businessList![index].phone!.substring(0, 3)}) ${_businessesController.businessList![index].phone!.substring(3, 6)}-${_businessesController.businessList![index].phone!.substring(6,
                                )}',
                                index: index,
                                isFavorite: false,
                                onClickBox: () async {
                                  pushNewScreen(
                                    context,
                                    screen: BusinessesDetailScreen(
                                        businessId: _businessesController.businessList![index].id
                                    ), withNavBar: true,
                                  );
                                },
                                onPressFavoriteIcon: () {});
                          },
                        )
                            : handleEmptyState(
                            context,
                            _businessesController
                                .selectedCategory.value ==
                                Strings.favorite
                                ? Strings.noBusinessFavorites
                                : Strings.noBusinesses),
                      ),
                      SizedBox(height: getHeight() * 0.045),
                      Padding(
                        padding:
                        EdgeInsets.only(left: sizes.width * 0.06),
                        child: TextView.titleWithDecoration(
                            Strings.recentlyAdded,
                            color: AppColors.blackColor,
                            fontFamily: Assets.poppinsMedium,
                            fontSize: sizes.fontSize16),
                      ),
                      SizedBox(height: getHeight() * 0.01),
                      SizedBox(
                        height: getHeight() * 0.15,
                        child: _businessesController
                            .isRecentlyAddedBusinessLoading.value
                            ? bouncingLoadingIndicator()
                            : _businessesController.recentlyAddedBusinessList
                            ?.isNotEmpty ?? false
                            ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: _businessesController
                              .recentlyAddedBusinessList!
                              .isEmpty
                              ? 0
                              : _businessesController
                              .recentlyAddedBusinessList!
                              .length > 6 ? 6
                              : _businessesController
                              .recentlyAddedBusinessList!
                              .length,
                                itemBuilder: (context, index) {
                                  return index == 5
                                ? GestureDetector(
                                onTap: () {
                                  Get.to(() =>
                                      RecentBusinessListing(title: Strings.recentlyAddedBusiness));
                                },
                                child: CommonWidgets
                                    .seeAllButton(30))
                                : GestureDetector(
                              onTap: () {
                                pushNewScreen(
                                  context,
                                  screen: BusinessesDetailScreen(
                                      businessId:
                                      _businessesController
                                          .recentlyAddedBusinessList![
                                      index]
                                          .id),
                                  withNavBar: true,
                                );
                              },
                              child:
                              RecentlyAddedBusiness(
                                name: _businessesController
                                    .recentlyAddedBusinessList![
                                index]
                                    .name,
                                fullImage:
                                _businessesController
                                    .recentlyAddedBusinessList![
                                index]
                                    .image ??
                                    Strings
                                        .dummyBgImage,
                                logoImage:
                                _businessesController
                                    .recentlyAddedBusinessList![
                                index]
                                    .logo ??
                                    Strings.dummyLogo,
                                index: index,
                                onPressFullContainer:
                                    () {},
                              ),
                            );
                          },
                        )
                            : handleEmptyState(
                            context, Strings.noRecentBusinesses),
                      ),
                      SizedBox(height: getHeight() * 0.045),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizes.width * 0.06),
                        child: Column(
                          children: [
                            CommonWidgets.getTextWithSeeAll(
                                leadingText: 'Nearby',
                                trailingText: Strings.seeAll,
                                onPressSeeAllButton: () {
                                  Get.to(() => NearbyBusinessListing(
                                      title: Strings.businessesNearYou));
                                }),
                            SizedBox(height: getHeight() * 0.018),
                            _businessesController
                                .isNearByBusinessLoading.value
                                ? bouncingLoadingIndicator()
                                : _businessesController.nearbyBusinessList
                                ?.isNotEmpty ??
                                false
                                ? ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: _businessesController
                                  .nearbyBusinessList!
                                  .isEmpty
                                  ? 0
                                  : _businessesController
                                  .nearbyBusinessList!
                                  .length >
                                  3
                                  ? 3
                                  : _businessesController
                                  .nearbyBusinessList!
                                  .length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    pushNewScreen(
                                      context,
                                      screen: BusinessesDetailScreen(
                                          businessId:
                                          _businessesController
                                              .nearbyBusinessList![
                                          index]
                                              .id),
                                      withNavBar: true,
                                    );
                                  },
                                  child: BusinessNearBy(
                                    image: _businessesController
                                        .nearbyBusinessList![
                                    index]
                                        .logo ??
                                        Strings.dummyBgImage,
                                    headerText:
                                    _businessesController
                                        .nearbyBusinessList![
                                    index]
                                        .name,
                                    onViewCourse: () {},
                                    address:
                                    _businessesController
                                        .nearbyBusinessList![
                                    index]
                                        .address1,
                                    streetAddress:
                                    _businessesController
                                        .nearbyBusinessList![
                                    index]
                                        .address2 ??
                                        Strings.unknown,
                                    phoneNumber:
                                    '(${_businessesController.nearbyBusinessList![index].phone!.substring(0, 3)}) ${_businessesController.nearbyBusinessList![index].phone!.substring(3, 6)}-${_businessesController.nearbyBusinessList![index].phone!.substring(
                                      6,
                                    )}',
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context,
                                  int index) {
                                return Divider(
                                    height: getHeight() * 0.04,
                                    thickness:
                                    getHeight() * 0.001,
                                    color: AppColors
                                        .barSeperatorGrey);
                              },
                            )
                                : handleEmptyState(context,
                                Strings.noNearbyBusinesses),
                            SizedBox(height: getHeight() * 0.03),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}