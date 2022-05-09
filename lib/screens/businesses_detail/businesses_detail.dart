import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/dummy_data/businesses.dart';
import 'package:flutter_app/local/dummy_data/causes_detail.dart';
import 'package:flutter_app/screens/bottom_tab/causes/upcoming_causes.dart';
import 'package:flutter_app/screens/businesses_detail/business_detail_controller.dart';
import 'package:flutter_app/screens/businesses_detail/business_detail_top_container.dart';
import 'package:flutter_app/screens/businesses_detail/business_rating.dart';
import 'package:flutter_app/screens/businesses_detail/recently_funded_business.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail_components.dart';
import 'package:flutter_app/screens/causes_detail/recent_contributions.dart';
import 'package:flutter_app/screens/causes_detail/update_fund_raiser.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../../res/res.dart';


class BusinessesDetailScreen extends StatefulWidget {
  const BusinessesDetailScreen({Key? key}) : super(key: key);

  @override
  _BusinessesDetailScreenState createState() => _BusinessesDetailScreenState();
}

class _BusinessesDetailScreenState extends State<BusinessesDetailScreen> with SingleTickerProviderStateMixin{
  final CauseDetailComponents _causeDetailComponents = CauseDetailComponents();
  final BusinessDetailController _businessDetailController = Get.put(BusinessDetailController());
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final _id = ModalRoute.of(context)!.settings.arguments as int;
    _businessDetailController.getBusinessDetails(id: _id);
    _businessDetailController.getBusinessStats(id: _id);

    return SafeArea(
      child: Scaffold(
        body: Obx(() => (_businessDetailController.isLoading.value || _businessDetailController.isStatsLoading.value)
          ? circularProgressIndicator()
          : SingleChildScrollView(
          child: Container(
            height: sizes.height + sizes.height * 0.45,
            width: sizes.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: sizes.height * 0.35,
                  child:  _businessDetailController.isLoading.value
                      ? circularProgressIndicator()
                      :  BusinessDetailTopContainer(
                      name: _businessDetailController.businessDetail.name,
                      fullBoxImage: _businessDetailController.businessDetail.image ?? Strings.dummyBgImage,
                      logoImage: _businessDetailController.businessDetail.logo ?? Strings.dummyLogo,
                      completePercentage: 0.7,
                      contributedAmount: _businessDetailController.businessDetail.contributionAmount.toString(),
                      totalAmount: _businessDetailController.businessDetail.totalContributions.toString(),
                      joinDate: _businessDetailController.businessDetail.createdAt.toString(),
                      streetAddress: _businessDetailController.businessDetail.address2,
                      address: _businessDetailController.businessDetail.address1,
                      phoneNumber: _businessDetailController.businessDetail.phone.toString(),
                      isFavorite: false,
                      onClickBox: (){},
                      onPressBackArrow: () {
                        Navigator.pop(context, 1);
                        return Future.value(true);
                      },
                      onPressFavoriteIcon: () {}
                  ),
                ),
                SizedBox(height: sizes.height * 0.01),
                Container(
                  height: getHeight()* 0.045,
                  margin: EdgeInsets.symmetric(
                      horizontal: getWidth() * 0.05,
                      vertical: getHeight() * 0.01),
                  decoration: BoxDecoration(
                    color: AppColors.boxGrey,
                    borderRadius: BorderRadius.circular(getHeight() * 0.01),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    onTap: (index) {},
                    indicator: BoxDecoration(

                      borderRadius: BorderRadius.circular(getHeight() * 0.01),
                      color: AppColors.lightBlue,
                    ),
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
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _businessDetailController.isLoading.value
                          ? circularProgressIndicator()
                          : ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                            child: Column(
                              children: [
                                TextView.caption(_businessDetailController.businessDetail.description, color: AppColors.blackColor, fontFamily: Assets.poppinsRegular,lines: 3, fontSize: sizes.fontSize12),
                                SizedBox(height: sizes.height * 0.03),
                                BusinessRating(
                                    starRating: _businessDetailController.businessDetail.rating,
                                    onPress: () {}
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: sizes.height * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.06),
                                child: TextView.titleWithDecoration("Recently Funded", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize17),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: getHeight() * 0.01),
                                child: SizedBox(
                                  height: getHeight()*0.18,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: recentlyFundedBusinessList.length,
                                    itemBuilder: (context, index){
                                      return RecentlyFundedBusiness(
                                        name: recentlyFundedBusinessList[index].title,
                                        fullImage: recentlyFundedBusinessList[index].backgroundImage,
                                        logoImage: recentlyFundedBusinessList[index].icon,
                                        isFavorite: false,
                                        endDate: recentlyFundedBusinessList[index].endDate,
                                        raisedAmount: recentlyFundedBusinessList[index].raisedAmount.toString(),
                                        totalAmount: recentlyFundedBusinessList[index].totalAmount.toString(),
                                        colors: recentlyFundedBusinessList[index].color!,
                                        index: index,
                                        onPressFullContainer: (){
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: sizes.height * 0.03),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: sizes.height * 0.01),
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
                          ),
                        ],
                      ),
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
                                  itemCount: 8,
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
                      _businessDetailController.isLoading.value
                          ? Padding(
                        padding: EdgeInsets.only(top: getHeight()*0.1),
                        child: Wrap(
                          children:  [
                            Center(
                              child: SizedBox(
                                width: getWidth() * 1,
                                child: const SpinKitFadingCircle(color: AppColors.greenColor,),
                              ),
                            )
                          ],
                        ),
                      )
                          : ListView(
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
                                  itemCount: _businessDetailController.businessStats.recentContributions!.length,
                                  itemBuilder: (context, index){
                                    return RecentContributions(
                                        contributorName: _businessDetailController.businessStats.recentContributions![index].name,
                                        amount: _businessDetailController.businessStats.recentContributions![index].amount.toString()
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
        ),),
      ),
    );
  }
}

