import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/causes/upcoming_causes.dart';
import 'package:flutter_app/screens/businesses_detail/businesses_detail_components.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../../res/res.dart';
import '../sign_in/sign_in.dart';


class BusinessesDetail extends StatefulWidget {
  const BusinessesDetail({Key? key}) : super(key: key);

  @override
  _BusinessesDetailState createState() => _BusinessesDetailState();
}

class _BusinessesDetailState extends State<BusinessesDetail> with SingleTickerProviderStateMixin {
  final BusinessesDetailComponents _businessesDetailComponents = BusinessesDetailComponents();
  TabController? _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: sizes.height,
          width: sizes.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: sizes.height * 0.32,
                child: _businessesDetailComponents.getBusinessesDetailImageContainer(
                    name: "Chino Hills High School Girls Softball Fundraiser",
                    fullBoxImage: Assets.dummyRestaurant,
                    logoImage: Assets.dummyRestaurantLogo,
                    completePercentage: 0.7,
                    contributedAmount: "3942.61",
                    totalAmount: "450",
                    joinDate: "Jan 2020",
                    streetAddress: "15705 Euclid Ave",
                    address: "Chino, CA 9170",
                    phoneNumber: "909-254-7898",
                    isFavorite: false,
                    onClickBox: (){

                    },
                    onPressBackArrow: () {
                      Navigator.pop(context);
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
                    fontSize: sizes.fontRatio * 12,
                    fontFamily: Assets.poppinsMedium,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelColor: AppColors.darkGrey,
                  unselectedLabelStyle: TextStyle(
                      fontSize: sizes.fontRatio * 12,
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
                    ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                          child: Column(
                            children: [
                              TextView.caption("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ultricies, ipsum et ullamcorper dignissim, massa quam congue arcu, non facilisis.",
                                  color: AppColors.blackColor, fontFamily: Assets.poppinsRegular,lines: 3),
                              SizedBox(height: sizes.height * 0.02),
                              _businessesDetailComponents.ratingContainer(
                                  starRating: 3,
                                  onPress: () {}
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: sizes.height * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.06),
                              child: TextView.headerWithBlurRadius("Recently Funded", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize12),
                            ),
                            SizedBox(
                              height: getHeight()*0.17,
                              child:
                              ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index){
                                  return _businessesDetailComponents.recentlyFundedContainer(
                                    name: "Ayala High School Cheer Fundraiser",
                                    fullImage: "",
                                    logoImage: "",
                                    isFavorite: false,
                                    endDate: "Mar 2nd",
                                    raisedAmount: "342.5",
                                    totalAmount: "450",
                                    onPressFullContainer: (){
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: sizes.height * 0.01),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView.headerWithBlurRadius("Past Funded Causes", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize12),
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizes.pagePadding),
                      child: Column(
                        children: [
                          TextView.header("", color: AppColors.greenColor, fontSize: sizes.fontSize22),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizes.pagePadding),
                        child: TextView.header("", color: AppColors.greenColor, fontSize: sizes.fontSize22)
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
