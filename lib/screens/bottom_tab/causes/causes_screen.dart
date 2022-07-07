import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:thinknlocal_app/common/utils.dart';
import 'package:thinknlocal_app/constants/routes.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/screens/bottom_tab/causes/causes_category_screen.dart';
import 'package:thinknlocal_app/screens/bottom_tab/causes/causes_controller.dart';
import 'package:thinknlocal_app/screens/location_search/location_search_controller.dart';
import 'package:thinknlocal_app/widgets/common_widgets.dart';
import 'package:thinknlocal_app/widgets/custom_tab_bar.dart';
import 'package:thinknlocal_app/widgets/network_error.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';
import '../businesses/businesses_controller.dart';

class CausesScreen extends StatelessWidget {
  CausesScreen({Key? key}) : super(key: key);

  final TextEditingController? searchController = TextEditingController();
  final LocationSearchController _locationSearchController = Get.put(LocationSearchController());
  final CausesController _causesController = Get.put(CausesController());
  final BusinessesController _businessesController = Get.put(BusinessesController());

  @override
  Widget build(BuildContext context) {
    final bool _isUserAuthenticated = PreferenceUtils.isUserAuthenticated();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        color: AppColors.greenColor,
        onRefresh: () async {
          _causesController.getCauses(_causesController.selectedCategory.value);
          _causesController.getRecentlyStartedCauses();
          _causesController.getUpComingCauses();
        },
        child: Obx(
          () => _causesController.isError.value
              ? NetworkErrorException(
                  exceptionMessage: _causesController.errorMessage.value,
                  onPress: () {
                    _causesController.isError.value = false;
                    _causesController.getCauses(Strings.featured);
                    _causesController.getRecentlyStartedCauses();
                    _causesController.getUpComingCauses();
                  })
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
                              Strings.showingCausesNear,
                              color: AppColors.darkGrey,
                              fontFamily: Assets.poppinsRegular,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await Get.toNamed(Routes.locationSearchScreen);
                                _causesController.onInit();
                                _businessesController.onInit();
                              },
                              child: Row(
                                children: [
                                  Obx(
                                    () => TextView.header(
                                        _locationSearchController.locationAddress.value,
                                        color: AppColors.greenColor,
                                        fontFamily: Assets.poppinsRegular,
                                        textDecoration:
                                            TextDecoration.underline,
                                        fontSize: sizes.fontSize25),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 0.2.h, left: 1.w),
                                    child: Image(
                                      color: AppColors.greenColor,
                                      height: getHeight() * 0.03,
                                      image:
                                          const AssetImage(Assets.vectorIcon),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizes.width * 0.06),
                              child: CommonWidgets.searchLocationTextField(
                                  controller: searchController,
                                  hint: Strings.searchForCause,
                                  onPressSearch: () {
                                    Get.toNamed(Routes.causeSearch);
                                  }),
                            ),
                            SizedBox(height: getHeight() * 0.02),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: sizes.width * 0.06,
                                  right: sizes.width * 0.06,
                                  bottom: 1.h),
                              child: _isUserAuthenticated
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        customTabBar(
                                            title: Strings.featured.capitalize!,
                                            isSelected: _causesController
                                                .isFeatured.value,
                                            onTap: () {
                                              _causesController
                                                  .setFeaturedTab();
                                            }),
                                        customTabBar(
                                            title: Strings.trending.capitalize!,
                                            isSelected: _causesController
                                                .isTrending.value,
                                            onTap: () {
                                              _causesController
                                                  .setTrendingTab();
                                            }),
                                        customTabBar(
                                            title:
                                                Strings.favorites.capitalize!,
                                            isSelected: _causesController
                                                .isFavorites.value,
                                            onTap: () {
                                              _causesController
                                                  .setFavoritesTab();
                                            }),
                                        customTabBar(
                                            title: Strings.past.capitalize!,
                                            isSelected:
                                                _causesController.isPast.value,
                                            onTap: () {
                                              _causesController.setPastTab();
                                            }),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        customTabBar(
                                            title: Strings.featured.capitalize!,
                                            isSelected: _causesController
                                                .isFeatured.value,
                                            onTap: () {
                                              _causesController
                                                  .setFeaturedTab();
                                            }),
                                        customTabBar(
                                            title: Strings.trending.capitalize!,
                                            isSelected: _causesController
                                                .isTrending.value,
                                            onTap: () {
                                              _causesController
                                                  .setTrendingTab();
                                            }),
                                        customTabBar(
                                            title: Strings.past.capitalize!,
                                            isSelected:
                                                _causesController.isPast.value,
                                            onTap: () {
                                              _causesController.setPastTab();
                                            }),
                                      ],
                                    ),
                            ),
                            const CausesCategoryScreen(),
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
