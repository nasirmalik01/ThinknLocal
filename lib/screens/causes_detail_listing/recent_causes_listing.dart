import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/enums/cause_request_type.dart';
import 'package:thinknlocal_app/screens/bottom_tab/causes/causes_controller.dart';
import 'package:thinknlocal_app/screens/bottom_tab/causes/upcoming_causes.dart';
import 'package:thinknlocal_app/screens/causes_detail/causes_detail.dart';
import 'package:thinknlocal_app/widgets/empty_state.dart';
import 'package:thinknlocal_app/widgets/loading_indicator.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';

class RecentCausesListing extends StatefulWidget {
  final String? title;
  const RecentCausesListing({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  State<RecentCausesListing> createState() => _RecentCausesListingState();
}

class _RecentCausesListingState extends State<RecentCausesListing> {
  final CausesController _causesController = Get.put(CausesController());

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0), () {
      _causesController.requestType.value = CauseRequestType.recent;
      _causesController.setPagination(isFirst: true);
      _causesController.getRecentlyStartedCauses(page: 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.greenColor,
        onRefresh: () async {
          _causesController.requestType.value = CauseRequestType.recent;
          _causesController.setPagination(isFirst: true);
          _causesController.getRecentlyStartedCauses(page: 1);
        },
        child: Obx(
          () => (_causesController.isRecentlyStartedCausesLoading.value &&
                  !_causesController.isPaginatedLoading.value &&
                  (Get.isDialogOpen == false))
              ? bouncingLoadingIndicator()
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _causesController.scrollController,
                  child: Container(
                    width: sizes.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        CommonWidgets.getSimpleAppBar(
                            title: widget.title,
                            onPressBackArrow: () {
                              Navigator.pop(context);
                            }),
                        _causesController.recentlyStartedCauses?.isEmpty ??
                                false
                            ? emptyState('No recently started causes')
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizes.width * 0.06),
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: _causesController
                                          .recentlyStartedCauses!.length,
                                      itemBuilder: (context, index) {
                                        dynamic _raisedFormattedAmount =
                                            commaFormatter(_causesController
                                                .recentlyStartedCauses![index]
                                                .raised);
                                        return GestureDetector(
                                          onTap: () {
                                            pushNewScreen(
                                              context,
                                              screen: CausesDetail(
                                                  causeId: _causesController
                                                      .recentlyStartedCauses![
                                                          index]
                                                      .id,
                                                  organizationId:
                                                      _causesController
                                                          .recentlyStartedCauses![
                                                              index]
                                                          .organization!
                                                          .id),
                                              withNavBar: true,
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: sizes.height * 0.001),
                                            child: UpcomingCauses(
                                                image: _causesController.recentlyStartedCauses![index].organization?.logo ?? Strings.dummyBgImage,
                                                headerText: _causesController
                                                    .recentlyStartedCauses![
                                                        index]
                                                    .organization!
                                                    .name,
                                                description: _causesController
                                                    .recentlyStartedCauses![
                                                        index]
                                                    .name!,
                                                onViewCourse: () {},
                                                totalAmount:
                                                    _raisedFormattedAmount,
                                                date: _causesController
                                                    .recentlyStartedCauses![
                                                        index]
                                                    .start
                                                    .toString()),
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
      ),
    );
  }
}
