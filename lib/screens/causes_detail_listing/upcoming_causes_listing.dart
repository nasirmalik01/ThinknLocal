import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/enums/cause_request_type.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_controller.dart';
import 'package:flutter_app/screens/bottom_tab/causes/upcoming_causes.dart';
import 'package:flutter_app/widgets/empty_state.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';

class UpcomingCausesListing extends StatelessWidget {
  final String? title;
  UpcomingCausesListing({Key? key, this.title,}) : super(key: key);

  final CausesController _causesController = Get.put(CausesController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10), (){
      _causesController.requestType.value = CauseRequestType.upcoming;
      _causesController.setPagination(isFirst: true,);
      _causesController.getUpComingCauses(page: 1);
    });

    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.greenColor,
        onRefresh: () async{
          _causesController.requestType.value = CauseRequestType.upcoming;
          _causesController.setPagination(isFirst: true,);
          _causesController.getUpComingCauses(page: 1);
        },
        child: Obx(() =>( _causesController.isUpcomingCausesLoading.value && !_causesController.isPaginatedLoading.value && (Get.isDialogOpen == false))
            ? circularProgressIndicator()
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
                    title: title,
                    onPressBackArrow: () {
                      Navigator.pop(context);
                    }),
                _causesController.upcomingCauses?.isEmpty ?? false
                    ? emptyState('No upcoming causes')
                    :  Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _causesController.upcomingCauses!.length,
                        itemBuilder: (context, index) {
                          dynamic _upcomingFormattedAmount = commaFormatter(_causesController.upcomingCauses![index].raised);

                          return GestureDetector(
                            onTap: (){
                              Get.toNamed(Routes.causesDetailScreen, arguments: {
                                Strings.causeId: _causesController.upcomingCauses![index].id,
                                Strings.organizationId: _causesController.upcomingCauses![index].organization!.id,
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: sizes.height*0.001),
                              child: UpcomingCauses(
                                  image:  _causesController.upcomingCauses![index].image ?? Strings.dummyBgImage,
                                  headerText: _causesController.upcomingCauses![index].organization!.name,
                                  description:   _causesController.upcomingCauses![index].name!,
                                  onViewCourse: (){},
                                  totalAmount: _upcomingFormattedAmount,
                                  date: _causesController.upcomingCauses![index].start.toString()
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                              height: getHeight() * 0.04,
                              thickness: getHeight() * 0.002,
                              color: AppColors.borderColor);
                        },
                      ),
                      SizedBox(height: getHeight() * 0.04),
                    ],
                  ),
                ),
              ],
            ),),
        ),
        ),
      ),
    );
  }
}
