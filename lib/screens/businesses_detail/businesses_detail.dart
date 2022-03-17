import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/businesses_components.dart';
import 'package:flutter_app/screens/businesses_detail/businesses_detail_components.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail_components.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_components.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';


class BusinessesDetail extends StatefulWidget {
  const BusinessesDetail({Key? key}) : super(key: key);

  @override
  _BusinessesDetailState createState() => _BusinessesDetailState();
}

class _BusinessesDetailState extends State<BusinessesDetail> with SingleTickerProviderStateMixin {
  //final CauseDetailComponents _causeDetailComponents = CauseDetailComponents();
  BusinessesDetailComponents _businessesDetailComponents = BusinessesDetailComponents();
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
        // backgroundColor: AppColors.appBackground,
        body: Container(
          height: sizes!.height,
          width: sizes!.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: sizes!.height * 0.32,
                child: _businessesDetailComponents.getBusinessesDetailContainer(
                    name: "Chino Hills High School Girls Softall Fundraiser",
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const BusinessesDetail()));
                    },
                    onPressBackArrow: () {
                      Navigator.pop(context);
                    }
                ),
              ),
              SizedBox(height: sizes!.height * 0.01),
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
                  onTap: (index) {
                    print("Tab: $index");
                  },
                  indicator: BoxDecoration(

                    borderRadius: BorderRadius.circular(getHeight() * 0.01),
                    color: AppColors.lightBlue,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.pureWhiteColor,
                  labelStyle: TextStyle(
                    fontSize: sizes!.fontRatio * 12,
                    fontFamily: Assets.poppinsMedium,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelColor: AppColors.darkGrey,
                  unselectedLabelStyle: TextStyle(
                      fontSize: sizes!.fontRatio * 12,
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
              //SizedBox(height: sizes!.height * 0.01),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizes!.pagePadding),
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView.regular11Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ultricies, ipsum et ullamcorper dignissim, massa quam congue arcu, non facilisis.",
                                  color: AppColors.blackColor, fontFamily: Assets.poppinsRegular,lines: 3),
                              SizedBox(height: sizes!.height * 0.02),
                              _businessesDetailComponents.ratingContainer(
                                  starRating: 3,
                                  onPress: () {}
                              ),
                              SizedBox(height: sizes!.height * 0.02),
                              TextView.bold15Text("Recently Funded", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                              SizedBox(
                                height: getHeight()*0.17,
                                child:
                                ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  //padding: EdgeInsets.symmetric(horizontal: getWidth()*0.05),
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
                              SizedBox(height: sizes!.height * 0.01),
                              TextView.bold15Text("Past Funded Causes", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                              SizedBox(height: sizes!.height * 0.01),
                              Wrap(
                                children: [
                                  ...List.generate(
                                      3,
                                          (index) {
                                        return CommonWidgets.getUpcomingCauses(
                                            image:  "",
                                            headerText: "Chino Hills High Softball Team",
                                            description:  "Spring Training Equipment Fundraiser",
                                            onViewCourse: (){
                                            },
                                            totalAmount: "500",
                                            date: "Mar 25"
                                        );
                                      })
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizes!.pagePadding),
                      child: Column(
                        children: [
                          TextView.bold22Text("", color: AppColors.greenColor),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizes!.pagePadding),
                        child: TextView.bold22Text("", color: AppColors.greenColor)
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
