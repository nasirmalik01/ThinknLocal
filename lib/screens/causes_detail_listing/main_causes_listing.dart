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

class MainCausesListing extends StatelessWidget {
  final String? title;
  MainCausesListing({Key? key, this.title}) : super(key: key);

  final CausesController _causesController = Get.put(CausesController());

  @override
  Widget build(BuildContext context) {
   Future.delayed(const Duration(milliseconds: 2), (){
     String _selectedCategory = _causesController.getSelectedCategory();
     _causesController.requestType.value = CauseRequestType.causes;
     _causesController.setPagination(isFirst: true,);
     _causesController.getCauses(_selectedCategory, page: 1);
   });

    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.greenColor,
        onRefresh: () async{
          String _selectedCategory = _causesController.getSelectedCategory();
          _causesController.requestType.value = CauseRequestType.causes;
          _causesController.setPagination(isFirst: true,);
          _causesController.getCauses(_selectedCategory, page: 1);
        },
        child: Obx(() =>(_causesController.isTopCausesContainersList.value && !_causesController.isPaginatedLoading.value)
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
                _causesController.topCausesContainersList?.isEmpty ?? false
                    ? emptyState('No causes')
                    : Padding(
                      padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _causesController.topCausesContainersList!.length,
                        itemBuilder: (context, index) {
                          dynamic _raisedFormattedAmount = commaFormatter(_causesController.topCausesContainersList![index].raised);
                          return GestureDetector(
                            onTap: (){
                               Get.toNamed(Routes.causesDetailScreen, arguments: {
                                 Strings.causeId: _causesController.topCausesContainersList![index].id,
                                 Strings.organizationId: _causesController.topCausesContainersList![index].organization!.id,
                               });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: sizes.height*0.001),
                              child: UpcomingCauses(
                                  image:  _causesController.topCausesContainersList![index].image ?? Strings.dummyBgImage,
                                  headerText: _causesController.topCausesContainersList![index].organization!.name,
                                  description:   _causesController.topCausesContainersList![index].name!,
                                  onViewCourse: (){},
                                  totalAmount:  _raisedFormattedAmount,
                                  date: _causesController.topCausesContainersList![index].start.toString()
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
