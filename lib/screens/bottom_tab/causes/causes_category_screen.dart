import 'package:flutter/material.dart';
import 'package:flutter_app/local/dummy_data/causes.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_funds_container.dart';
import 'package:flutter_app/screens/bottom_tab/causes/recently_started_container.dart';
import 'package:flutter_app/screens/bottom_tab/causes/upcoming_causes.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail.dart';
import 'package:flutter_app/screens/causes_upcoming/causes_upcoming.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:sizer/sizer.dart';

class CausesCategoryScreen extends StatefulWidget {
  const CausesCategoryScreen({Key? key}) : super(key: key);

  @override
  State<CausesCategoryScreen> createState() => _CausesCategoryScreenState();
}

class _CausesCategoryScreenState extends State<CausesCategoryScreen> {
  final ScrollController _recentlyStartedController = ScrollController();
  final ScrollController _tabViewsController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getHeight() * 0.01),
        SizedBox(
          height: 23.h,
          child: ListView.builder(
            controller: _tabViewsController,
            scrollDirection: Axis.horizontal,
            itemCount: featuredCausesList.length,
            itemBuilder: (context, index){
              return index == recentlyStartedCauseList.length - 1 ? Padding(
                padding: EdgeInsets.only(left: 1.h, right: 1.5.h),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color(0xFF7DDFC3),
                  child: TextView.titleWithDecoration('See All', color: Colors.white),
                ),
              ) : CausesFundContainer(
                name: featuredCausesList[index].title!,
                fullBoxImage: featuredCausesList[index].backgroundImage!,
                logoImage: featuredCausesList[index].icon!,
                completePercentage:   0.7,
                collectedAmount: featuredCausesList[index].collectedAmount!,
                totalAmount: featuredCausesList[index].totalAmount!,
                endDate: featuredCausesList[index].endDate!,
                index: index,
                onClickBox: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CausesDetail()));
                },
              );
            },
          ),
        ),
        SizedBox(height: getHeight() * 0.03),
        Padding(
          padding: EdgeInsets.only(left: sizes.width * 0.06),
          child: TextView.titleWithDecoration("Recently Started", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize16),
        ),
        SizedBox(height: getHeight() * 0.018),
        SizedBox(
          height: getHeight()*0.17,
          child: ListView.builder(
            controller: _recentlyStartedController,
            scrollDirection: Axis.horizontal,
            itemCount: recentlyStartedCauseList.length,
            itemBuilder: (context, index){
              return index == recentlyStartedCauseList.length - 1 ? Padding(
                padding: EdgeInsets.only(left: 1.h, right: 1.5.h),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFF7DDFC3),
                  child: TextView.titleWithDecoration('See All', color: Colors.white, fontSize:sizes.fontSize12),
                ),
              ) : RecentlyStartedContainer(
                name: recentlyStartedCauseList[index].title,
                image: recentlyStartedCauseList[index].backgroundImage,
                colors: recentlyStartedCauseList[index].colors!,
                index: index,
                onPressFullContainer: (){},
              );
            },
          ),
        ),
        SizedBox(height: getHeight() * 0.03),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
          child: Column(
            children: [
              CommonWidgets.getTextWithSeeAll(
                  leadingText: "Upcoming Causes",
                  trailingText: "See All",
                  onPressSeeAllButton: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CausesUpcoming()));
                  }
              ),
              SizedBox(height: getHeight() * 0.018),
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index){
                  return UpcomingCauses(
                      image:  "",
                      headerText: "Chino Hills High Softball Team",
                      description:  "Spring Training Equipment Fundraiser",
                      onViewCourse: (){
                      },
                      totalAmount: "500",
                      date: "Mar 25"
                  );

                }, separatorBuilder: (BuildContext context, int index) {
                return Divider(height: getHeight() * 0.04, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
              },
              ),
              SizedBox(height: getHeight() * 0.03),
            ],
          ),
        )
      ],
    );
  }
}
