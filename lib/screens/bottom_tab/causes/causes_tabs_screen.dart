import 'package:flutter/material.dart';
import 'package:flutter_app/local/dummy_data/causes.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/res/assets.dart';
import 'package:flutter_app/res/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_components.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail.dart';
import 'package:flutter_app/screens/causes_upcoming/causes_upcoming.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:sizer/sizer.dart';

class CausesTabScreen extends StatelessWidget {
  final CausesComponents _causesComponents = CausesComponents();

  CausesTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getHeight() * 0.01),
        Padding(
          padding: EdgeInsets.only(left: sizes.width*0.06),
          child: SizedBox(
            height: 23.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredCausesList.length,
              itemBuilder: (context, index){
                return index == recentlyStartedList.length - 1  ? Padding(
                  padding: EdgeInsets.only(left: 1.h, right: 1.5.h),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFF7DDFC3),
                    child: TextView.getMediumText15('See All', color: Colors.white),
                  ),
                ) : _causesComponents.getCausesFundsContainer(
                  name: featuredCausesList[index].title,
                  fullBoxImage: featuredCausesList[index].backgroundImage,
                  logoImage: featuredCausesList[index].icon,
                  completePercentage: 0.7,
                  collectedAmount: featuredCausesList[index].collectedAmount,
                  totalAmount: featuredCausesList[index].totalAmount,
                  endDate: featuredCausesList[index].endDate,
                  onClickBox: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CausesDetail()));
                  },
                );
              },
            ),
          ),
        ),
        SizedBox(height: getHeight() * 0.045),
        Padding(
          padding: EdgeInsets.only(left: sizes.width * 0.06),
          child: TextView.getMediumText15("Recently Started", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
        ),
        SizedBox(height: getHeight() * 0.018),
        Padding(
          padding: EdgeInsets.only(left: sizes.width*0.06),
          child: SizedBox(
            height: getHeight()*0.17,
            child:
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recentlyStartedList.length,
              itemBuilder: (context, index){
                return index == recentlyStartedList.length - 1 ? Padding(
                  padding: EdgeInsets.only(left: 1.h, right: 1.5.h),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFF7DDFC3),
                    child: TextView.getMediumText15('See All', color: Colors.white, fontSize: 9.sp),
                  ),
                ) : _causesComponents.getRecentlyStartedContainer(
                  name: recentlyStartedList[index].title,
                  image: recentlyStartedList[index].backgroundImage,
                  colors: recentlyStartedList[index].colors,
                  onPressFullContainer: (){},
                );
              },
            ),
          ),
        ),
        SizedBox(height: getHeight() * 0.045),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
          child: Column(
            children: [
              CommonWidgets.getTextWithSeeAll(
                  text1: "Upcoming Causes",
                  text2: "See All",
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
                  return CommonWidgets.getUpcomingCausesList(
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
