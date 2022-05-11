import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_controller.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_funds_container.dart';
import 'package:flutter_app/screens/bottom_tab/causes/recently_started_container.dart';
import 'package:flutter_app/screens/bottom_tab/causes/upcoming_causes.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail.dart';
import 'package:flutter_app/screens/causes_upcoming/causes_upcoming.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CausesCategoryScreen extends StatefulWidget {
  const CausesCategoryScreen({Key? key}) : super(key: key);

  @override
  State<CausesCategoryScreen> createState() => _CausesCategoryScreenState();
}

class _CausesCategoryScreenState extends State<CausesCategoryScreen> {
  final ScrollController _recentlyStartedController = ScrollController();
  final ScrollController _tabViewsController = ScrollController();
  final CausesController _causesController = Get.put(CausesController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getHeight() * 0.01),
        SizedBox(
          height: 23.h,
          child: Obx(() =>  _causesController.isTopCausesContainersList.value
            ? circularProgressIndicator()
            : ListView.builder(
            controller: _tabViewsController,
            scrollDirection: Axis.horizontal,
            itemCount:  6,
            itemBuilder: (context, index){
              return index == 5 ? GestureDetector(
                onTap: (){
                  Get.to(DetailScreen(title: Strings.allCauses, detailList: _causesController.topCausesContainersList as dynamic));
                },
                child: CommonWidgets.seeAllButton(40)
              )
                : CausesFundContainer(
                name: _causesController.topCausesContainersList![index].name!,
                fullBoxImage: _causesController.topCausesContainersList![index].image ?? Strings.dummyBgImage,
                logoImage: _causesController.topCausesContainersList![index].organization!.logo ?? Strings.dummyLogo,
                completePercentage:   0.7,
                collectedAmount: _causesController.topCausesContainersList![index].raised.toString(),
                totalAmount: _causesController.topCausesContainersList![index].goal.toString(),
                endDate: _causesController.topCausesContainersList![index].end.toString(),
                index: index,
                onClickBox: () async {
                  Get.toNamed(Routes.causesDetailScreen,
                      arguments: _causesController.topCausesContainersList![index].id);
                },
              );
            },
          ),),
        ),
        SizedBox(height: getHeight() * 0.03),
        Padding(
          padding: EdgeInsets.only(left: sizes.width * 0.06),
          child: TextView.titleWithDecoration(Strings.recentlyStarted, color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize16),
        ),
        SizedBox(height: getHeight() * 0.018),

        /// Recently Started Causes
        Obx(() => _causesController.isRecentlyStartedCausesLoading.value
          ? circularProgressIndicator()
          : SizedBox(
          height: getHeight()*0.17,
          child: ListView.builder(
            controller: _recentlyStartedController,
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index){
              return index == 5
                ? GestureDetector(
                  onTap: (){
                    Get.to(DetailScreen(title: Strings.recentlyStarted, detailList: _causesController.recentlyStartedCauses as dynamic));
                  },
                  child: CommonWidgets.seeAllButton(30))
                : RecentlyStartedContainer(
                name: _causesController.recentlyStartedCauses![index].name,
                image: _causesController.recentlyStartedCauses![index].image ?? Strings.dummyBgImage,
                colors: const [Colors.transparent, AppColors.greenColor,],
                index: index,
                onPressFullContainer: (){},
              );
            },
          ),
        ),),
        SizedBox(height: getHeight() * 0.03),

        /// Upcoming causes
        Obx(() => Padding(
          padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
          child: Column(
            children: [
              CommonWidgets.getTextWithSeeAll(
                  leadingText: Strings.upcomingCauses,
                  trailingText: Strings.seeAll,
                  onPressSeeAllButton: () {
                    Get.to(DetailScreen(title: Strings.upcomingCausesNearYou, detailList:  _causesController.upcomingCauses as dynamic,));
                  }
              ),
              SizedBox(height: getHeight() * 0.018),
                _causesController.isUpcomingCausesLoading.value
                ? circularProgressIndicator()
                : ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index){
                  return UpcomingCauses(
                      image:  _causesController.upcomingCauses![index].image ?? Strings.dummyBgImage,
                      headerText: _causesController.upcomingCauses![index].organization!.name,
                      description:  _causesController.upcomingCauses![index].name,
                      onViewCourse: (){
                      },
                      totalAmount: _causesController.upcomingCauses![index].raised.toString(),
                      date: _causesController.upcomingCauses![index].start!.toString()

                  );

                }, separatorBuilder: (BuildContext context, int index) {
                return Divider(height: getHeight() * 0.04, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
              },
              ),
              SizedBox(height: getHeight() * 0.03),
            ],
          ),
        ))

      ],
    );
  }
}
