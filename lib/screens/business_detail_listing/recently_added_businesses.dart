import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/enums/business_request_type.dart';
import 'package:thinknlocal_app/screens/bottom_tab/businesses/business_list_view_layout.dart';
import 'package:thinknlocal_app/screens/bottom_tab/businesses/businesses_controller.dart';
import 'package:thinknlocal_app/screens/businesses_detail/businesses_detail.dart';
import 'package:thinknlocal_app/widgets/empty_state.dart';
import 'package:thinknlocal_app/widgets/loading_indicator.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';

class RecentBusinessListing extends StatelessWidget {
  final String? title;
  RecentBusinessListing({required this.title, Key? key}) : super(key: key);

  final BusinessesController _businessesController =
      Get.put(BusinessesController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10), () {
      _businessesController.requestType.value = BusinessRequestType.recent;
      _businessesController.setPagination(isFirst: true);
      _businessesController.getRecentlyAddedBusinesses(page: 1);
    });

    return Scaffold(
        body: RefreshIndicator(
      color: AppColors.greenColor,
      onRefresh: () async {
        _businessesController.requestType.value = BusinessRequestType.recent;
        _businessesController.setPagination(isFirst: true);
        _businessesController.getRecentlyAddedBusinesses(page: 1);
      },
      child: Obx(
        () => (_businessesController.isRecentlyAddedBusinessLoading.value &&
                !_businessesController.isPaginatedLoading.value)
            ? bouncingLoadingIndicator()
            : SingleChildScrollView(
                controller: _businessesController.scrollController,
                child: Container(
                  width: sizes.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      CommonWidgets.getSimpleAppBar(
                          title: title,
                          onPressBackArrow: () {
                            Navigator.pop(context);
                          }),
                      _businessesController
                                  .recentlyAddedBusinessList?.isEmpty ??
                              false
                          ? emptyState('No recently added businesses')
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizes.width * 0.06),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount: _businessesController
                                        .recentlyAddedBusinessList!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          pushNewScreen(
                                            context,
                                            screen: BusinessesDetailScreen(
                                                businessId: _businessesController
                                                    .recentlyAddedBusinessList![
                                                        index]
                                                    .id),
                                            withNavBar: true,
                                          );
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: BusinessListViewLayout(
                                              image: _businessesController.recentlyAddedBusinessList![index].logo ?? Strings.dummyBgImage,
                                              headerText: _businessesController.recentlyAddedBusinessList![index].name,
                                              onViewCourse: () {},
                                              address: '${_businessesController.recentlyAddedBusinessList![index].address1}\n${_businessesController.recentlyAddedBusinessList![index].city}, ${_businessesController.recentlyAddedBusinessList![index].state}, ${_businessesController.recentlyAddedBusinessList![index].zip}',
                                              streetAddress: _businessesController
                                                  .recentlyAddedBusinessList![
                                                      index]
                                                  .address2,
                                              phoneNumber:
                                                  '(${_businessesController.recentlyAddedBusinessList![index].phone!.substring(0, 3)}) ${_businessesController.recentlyAddedBusinessList![index].phone!.substring(3, 6)}-${_businessesController.recentlyAddedBusinessList![index].phone!.substring(
                                                6,
                                              )}'),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Divider(
                                          height: getHeight() * 0.04,
                                          thickness: getHeight() * 0.002,
                                          color: AppColors.barSeperatorGrey);
                                    },
                                  ),
                                  SizedBox(height: getHeight() * 0.04),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
      ),
    ));
  }
}
