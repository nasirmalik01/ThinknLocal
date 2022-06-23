import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/enums/business_request_type.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/business_list_view_layout.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/businesses_controller.dart';
import 'package:flutter_app/screens/businesses_detail/businesses_detail.dart';
import 'package:flutter_app/widgets/empty_state.dart';
import 'package:flutter_app/widgets/loading_indicator.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';

class NearbyBusinessListing extends StatelessWidget {
  final String? title;
  NearbyBusinessListing({required this.title, Key? key}) : super(key: key);

  final BusinessesController _businessesController =
      Get.put(BusinessesController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10), () {
      _businessesController.requestType.value = BusinessRequestType.nearby;
      _businessesController.setPagination(isFirst: true);
      _businessesController.getNearbyBusinesses(page: 1);
    });

    return Scaffold(
        body: RefreshIndicator(
      color: AppColors.greenColor,
      onRefresh: () async {
        _businessesController.requestType.value = BusinessRequestType.nearby;
        _businessesController.setPagination(isFirst: true);
        _businessesController.getNearbyBusinesses(page: 1);
      },
      child: Obx(
        () => (_businessesController.isNearByBusinessLoading.value &&
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
                      _businessesController.nearbyBusinessList?.isEmpty ?? false
                          ? emptyState('No nearby businesses')
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
                                        .nearbyBusinessList!.length,
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
                                        child: Container(
                                          color: Colors.transparent,
                                          child: BusinessListViewLayout(
                                              image: _businessesController
                                                      .nearbyBusinessList![
                                                          index]
                                                      .image ??
                                                  Strings.dummyBgImage,
                                              headerText: _businessesController
                                                  .nearbyBusinessList![index]
                                                  .name,
                                              onViewCourse: () {},
                                              address: _businessesController
                                                  .nearbyBusinessList![index]
                                                  .address1,
                                              streetAddress:
                                                  _businessesController
                                                      .nearbyBusinessList![
                                                          index]
                                                      .address2,
                                              phoneNumber:
                                                  '(${_businessesController.nearbyBusinessList![index].phone!.substring(0, 3)}) ${_businessesController.nearbyBusinessList![index].phone!.substring(3, 6)}-${_businessesController.nearbyBusinessList![index].phone!.substring(
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
