import 'package:flutter/material.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/dummy_data/causes_detail.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail_components.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail_controller.dart';
import 'package:flutter_app/screens/causes_detail/detail_category_list.dart';
import 'package:flutter_app/screens/causes_detail/featured_sponsors.dart';
import 'package:flutter_app/screens/causes_detail/recent_contributions.dart';
import 'package:flutter_app/screens/causes_detail/top_image_container.dart';
import 'package:flutter_app/screens/causes_detail/update_fund_raiser.dart';
import 'package:flutter_app/screens/sign_in/sign_in.dart';
import 'package:flutter_app/widgets/custom_tab_bar.dart';
import 'package:flutter_app/widgets/status_bar.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../../res/res.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/common_widgets.dart';


class CausesDetail extends StatefulWidget {
  const CausesDetail({Key? key}) : super(key: key);

  @override
  _CausesDetailState createState() => _CausesDetailState();
}

class _CausesDetailState extends State<CausesDetail> with SingleTickerProviderStateMixin {
  final CauseDetailComponents _causeDetailComponents = CauseDetailComponents();
  final CausesDetailController _causesDetailController = Get.put(CausesDetailController());
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(color: Colors.transparent);

    return WillPopScope(
      onWillPop: () {
         Navigator.pop(context, 1);
         return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          body: Obx(() =>  SingleChildScrollView(
            child: Container(
              height: sizes.height + sizes.height * 0.46,
              width: sizes.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  /// top image container
                  SizedBox(
                    height: sizes.height * 0.35,
                    child: CausesDetailTopImageContainer(
                        name: "Chino Hills High School Girls Softball Fundraiser",
                        fullBoxImage: Assets.schoolDummy1,
                        logoImage: Assets.huskiesLogo,
                        completePercentage: 0.7,
                        collectedAmount: "342.5",
                        totalAmount: "450",
                        endDate: "Feb 4 - Feb 21",
                        isFavorite: false,
                        onClickBox: (){},
                        onPressBackArrow: () {
                          Navigator.pop(context, 1);
                          return Future.value(true);
                        },
                        onPressFavoriteIcon: () {
                          pushNewScreen(
                            context,
                            screen: const LoginScreen(),
                            withNavBar: false,
                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          );
                        }
                    ),
                  ),
                  SizedBox(height: sizes.height * 0.04),
                  Container(
                    height: getHeight()* 0.045,
                    margin: EdgeInsets.symmetric(horizontal: getWidth() * 0.05,),
                    decoration: BoxDecoration(
                      color: AppColors.boxGrey,
                      borderRadius: BorderRadius.circular(getHeight() * 0.01),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      onTap: (index) {
                      },
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(getHeight() * 0.01),
                        color: AppColors.lightBlue,
                      ),
                      //indicatorColor: AppColors.pureWhiteColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: AppColors.pureWhiteColor,
                      labelStyle: TextStyle(
                        fontSize: sizes.fontRatio * 13,
                        fontFamily: Assets.poppinsMedium,
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelColor: AppColors.darkGrey,
                      unselectedLabelStyle: TextStyle(
                          fontSize: sizes.fontRatio * 13,
                          fontFamily: Assets.poppinsRegular,
                          fontWeight: FontWeight.w400
                      ),
                      //labelPadding: EdgeInsets.all(sizes!.smallPadding),
                      tabs: const [
                        Tab(
                          text: 'Overview',

                        ),
                        Tab(
                          text: 'Update',
                        ),
                        Tab(
                          text: 'Stats',
                        ),
                      ],
                    ),
                  ),
                  ///parent tabview
                  Flexible(
                    ///this is the tab-bar view
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        /// 1st page
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///Chino Hills HS Girls Water Polo
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                                  child: _causeDetailComponents.descriptionTextContainer(
                                      heading: "Chino Hills HS Girls Water Polo",
                                      description: "Help support the Chino-Hills 2021-2022 Water polo team. They are raising money to purchase new water polo equipment."
                                  ),
                                ),
                                SizedBox(height: sizes.height * 0.045),
                                ///FeaturedSponsors
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                                  child: TextView.titleWithDecoration("Featured Sponsors", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize17),
                                ),
                                SizedBox(height: getHeight() * 0.01),
                                Padding(
                                  padding: EdgeInsets.only(left: getWidth()*0.06, ),
                                  child: SizedBox(
                                    height: getHeight()*0.16,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: featuredSponsorsList.length,
                                      itemBuilder: (context, index){
                                        return FeaturedSponsors(
                                          name: featuredSponsorsList[index].title,
                                          image:featuredSponsorsList[index].backgroundImage,
                                          logoImage: featuredSponsorsList[index].icon,
                                          givingBack: featuredSponsorsList[index].detail,
                                          onPressFullContainer: (){},
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                ///end of FeaturedSponsors
                                SizedBox(height: sizes.height * 0.04),
                                ///child tabview => Food & drink
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                                  child: Column(
                                    children: [
                                      ///inner tabs =>Food & drink
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          customTabBar(title: "Food & drink", isSelected: _causesDetailController.isFoodAndDrink.value, isDetail: true,  onTap: (){ _causesDetailController.setFoodAndDrinkTab(); }),
                                          customTabBar(title: "Things to do", isSelected: _causesDetailController.isThingsToDo.value, isDetail: true,  onTap: (){ _causesDetailController.setThingsToDoTab(); }),
                                          customTabBar(title: "Retail", isSelected: _causesDetailController.isRetail.value, isDetail: true,  onTap: (){ _causesDetailController.setRetailTab(); }),
                                          customTabBar(title: "Services", isSelected: _causesDetailController.isServices.value, isDetail: true,  onTap: (){ _causesDetailController.setServicesTab(); }),
                                        ],
                                      ),
                                      SizedBox(height: sizes.height * 0.02),
                                      ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: causesDetailFoodList.length,
                                        itemBuilder: (context, index){
                                          return DetailCategoryList(
                                              image:  causesDetailFoodList[index].backgroundImage,
                                              headerText: causesDetailFoodList[index].title,
                                              onViewCourse: (){},
                                              categoryPercent: causesDetailFoodList[index].backAmount,
                                              address: causesDetailFoodList[index].mainAddress,
                                              streetAddress: causesDetailFoodList[index].streetAddress,
                                              phoneNumber: causesDetailFoodList[index].phoneNumber
                                          );
                                        }, separatorBuilder: (BuildContext context, int index) {
                                        return Divider(height: getHeight() * 0.04, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
                                      },),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ///2nd page
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                              child: Column(
                                children: [
                                  ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount: updateFundRaiserList.length,
                                    itemBuilder: (context, index){
                                      return  UpdateFundRaiser(
                                          header: updateFundRaiserList[index].title!,
                                          detail: updateFundRaiserList[index].detail!,
                                          date: updateFundRaiserList[index].date!
                                      );
                                    }, separatorBuilder: (BuildContext context, int index) {
                                    return Divider(height: getHeight() * 0.04, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
                                  },),
                                  SizedBox(height: sizes.height * 0.03),

                                ],
                              ),
                            ),
                          ],
                        ),
                        /// 3rd page
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView.caption("Contributions over time", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize18),
                                  SizedBox(height: 0.5.h),
                                  TextView.caption("Number of contributions from individuals over time.", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, fontSize: sizes.fontSize13),
                                  SizedBox(height: 0.7.h),
                                  AspectRatio(
                                    aspectRatio: 1.66,
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                      color: AppColors.boxGrey,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: getHeight() * 0.02),
                                        child: BarChart(
                                          BarChartData(
                                            alignment: BarChartAlignment.center,
                                            barTouchData: BarTouchData(
                                              enabled: true,
                                            ),
                                            titlesData: FlTitlesData(
                                              show: true,
                                              bottomTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                  showTitles: true,
                                                  reservedSize: getHeight() * 0.04,
                                                  getTitlesWidget: _causeDetailComponents.statsGraphBottomTitles,
                                                ),
                                              ),
                                              leftTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                  showTitles: true,
                                                  reservedSize: getWidth() * 0.08,
                                                  getTitlesWidget: _causeDetailComponents.statsGraphLeftTitles,
                                                ),
                                              ),
                                              topTitles: AxisTitles(
                                                sideTitles: SideTitles(showTitles: false),
                                              ),
                                              rightTitles: AxisTitles(
                                                sideTitles: SideTitles(showTitles: false),
                                              ),
                                            ),
                                            gridData: FlGridData(
                                              show: true,
                                              checkToShowHorizontalLine: (value) => value % 10 == 0,
                                              getDrawingHorizontalLine: (value) => FlLine(
                                                color: AppColors.borderColor,
                                                strokeWidth: getWidth() * 0.004,
                                              ),
                                              drawVerticalLine: false,
                                            ),
                                            borderData: FlBorderData(
                                              show: false,
                                            ),
                                            groupsSpace: getWidth() * 0.05,
                                            barGroups: PreferenceUtils.getGraphData(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  CommonWidgets.getTextWithSeeAll(
                                      leadingText: "Recent Contributions",
                                      trailingText: "See All",
                                      onPressSeeAllButton: () {
                                      }
                                  ),
                                  SizedBox(height: 2.h),
                                  ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount: recentContributionList.length,
                                    itemBuilder: (context, index){
                                      return RecentContributions(
                                          contributorName: recentContributionList[index].title!,
                                          amount: recentContributionList[index].amount.toString()
                                      );

                                    }, separatorBuilder: (BuildContext context, int index) {
                                    return Divider(height: getHeight() * 0.04, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
                                  },
                                  ),
                                  SizedBox(height: getHeight() * 0.03),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),)

        ),
      ),
    );
  }
}
