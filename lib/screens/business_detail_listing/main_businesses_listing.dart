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

class MainBusinessListing extends StatelessWidget {
  final String? title;
  MainBusinessListing({required this.title, Key? key}) : super(key: key);

  final BusinessesController _businessesController =
      Get.put(BusinessesController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10), () {
      String _selectedCategory = _businessesController.getSelectedCategory();
      _businessesController.requestType.value = BusinessRequestType.business;
      _businessesController.setPagination(
        isFirst: true,
      );
      _businessesController.getBusinesses(_selectedCategory, page: 1);
    });

    return Scaffold(
        body: RefreshIndicator(
      color: AppColors.greenColor,
      onRefresh: () async {
        String _selectedCategory = _businessesController.getSelectedCategory();
        _businessesController.requestType.value = BusinessRequestType.business;
        _businessesController.setPagination(
          isFirst: true,
        );
        _businessesController.getBusinesses(_selectedCategory, page: 1);
      },
      child: Obx(
        () => (_businessesController.isBusinessLoading.value &&
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
                      _businessesController.businessList?.isEmpty ?? false
                          ? emptyState('No businesses')
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
                                        .businessList!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          pushNewScreen(
                                            context,
                                            screen: BusinessesDetailScreen(
                                                businessId:
                                                    _businessesController
                                                        .businessList![index]
                                                        .id),
                                            withNavBar: true,
                                          );
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: BusinessListViewLayout(
                                            image: _businessesController.businessList![index].logo ?? Strings.dummyBgImage,
                                            headerText: _businessesController.businessList![index].name,
                                            onViewCourse: () {},
                                            address: '${_businessesController.businessList![index].address1}\n${_businessesController.businessList![index].city}, ${_businessesController.businessList![index].state}, ${_businessesController.businessList![index].zip}',
                                            streetAddress: _businessesController.businessList![index].address2,
                                            phoneNumber: '(${_businessesController.businessList![index].phone!.substring(0, 3)}) ${_businessesController.businessList![index].phone!.substring(3, 6)}-${_businessesController.businessList![index].phone!.substring(6,
                                            )}',
                                          ),
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
