import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/enums/cause_request_type.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_controller.dart';
import 'package:flutter_app/screens/bottom_tab/causes/upcoming_causes.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';

class RecentCausesListing extends StatelessWidget {
  final String? title;
  RecentCausesListing({Key? key, this.title,}) : super(key: key);

  final CausesController _causesController = Get.put(CausesController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10), (){
      _causesController.requestType.value = CauseRequestType.recent;
      _causesController.setPagination(isFirst: true);
      _causesController.getRecentlyStartedCauses(page: 1);
    });

    return Scaffold(
      body: Obx(() =>( _causesController.isRecentlyStartedCausesLoading.value && !_causesController.isPaginatedLoading.value && (Get.isDialogOpen == false))
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _causesController.recentlyStartedCauses!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                             Get.toNamed(Routes.causesDetailScreen, arguments: _causesController.recentlyStartedCauses![index].id);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: sizes.height*0.001),
                            child: UpcomingCauses(
                                image:  _causesController.recentlyStartedCauses![index].image ?? Strings.dummyBgImage,
                                headerText: _causesController.recentlyStartedCauses![index].organization!.name,
                                description:   _causesController.recentlyStartedCauses![index].name!,
                                onViewCourse: (){},
                                totalAmount:  _causesController.recentlyStartedCauses![index].raised.toString(),
                                date: _causesController.recentlyStartedCauses![index].start.toString()
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
    );
  }
}
