import 'package:flutter/material.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail_components.dart';
import 'package:flutter_app/screens/sign_in/sign_in.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';


class CausesDetail extends StatefulWidget {
  const CausesDetail({Key? key}) : super(key: key);

  @override
  _CausesDetailState createState() => _CausesDetailState();
}

class _CausesDetailState extends State<CausesDetail> with SingleTickerProviderStateMixin {
  final CauseDetailComponents _causeDetailComponents = CauseDetailComponents();
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
                child: _causeDetailComponents.getCausesFundsContainer(
                  name: "Chino Hills High School Girls Softball Fundraiser",
                  fullBoxImage: Assets.schoolDummy1,
                  logoImage: Assets.huskiesLogo,
                  completePercentage: 0.7,
                  collectedAmount: "342.5",
                  totalAmount: "450",
                  endDate: "Feb 4 - Feb 21",
                  isFavorite: false,
                  onClickBox: (){
                  },
                  onPressBackArrow: () {
                    Navigator.pop(context);
                  },
                  onPressFavoriteIcon: () {
                    pushNewScreen(
                      context,
                      screen: const SignIn(),
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
              //SizedBox(height: sizes!.height * 0.01),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                              child: _causeDetailComponents.descriptionOverview(
                                  heading: "Chino Hills HS Girls Water Polo",
                                  description: "Help support the Chino-Hills 2021-2022 Water polo team. They are raising money to purchase new water polo equipment."
                              ),
                            ),
                            SizedBox(height: sizes.height * 0.02),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                              child: TextView.bold15Text("Featured Sponsors", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                            ),

                            SizedBox(
                              height: getHeight()*0.16,
                              child:
                              ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index){
                                  return _causeDetailComponents.featuredContainer(
                                    name: "Grocery outlet",
                                    image: "",
                                    logoImage: Assets.dummyFeaturedShort,
                                    givingBack: "20%",
                                    onPressFullContainer: (){
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: sizes.height * 0.02),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _causeDetailComponents.typesText(title: "Food & Drink", isSelected: true),
                                      _causeDetailComponents.typesText(title: "Things to do", isSelected: false),
                                      _causeDetailComponents.typesText(title: "Retail", isSelected: false),
                                      _causeDetailComponents.typesText(title: "Services", isSelected: false),
                                    ],
                                  ),
                                  SizedBox(height: sizes.height * 0.02),
                                  ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount: 3,
                                    itemBuilder: (context, index){
                                      return _causeDetailComponents.overViewCategoryContainer(
                                          image:  Assets.dummyFeatured,
                                          headerText: "Andy's Xpress Wash",
                                          onViewCourse: (){
                                          },
                                          categoryPercent: "50%",
                                          address: "Chino, CA 91710",
                                          streetAddress: "15705 Euclid Ave",
                                          phoneNumber: "908-900-1791"
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
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizes.pagePadding),
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: 8,
                                itemBuilder: (context, index){
                                  return _causeDetailComponents.updateListTabContainer(
                                      header: "It's Begone!",
                                      detail: "Our fundraiser has started!",
                                      date: "Mar 6th"
                                  );

                                }, separatorBuilder: (BuildContext context, int index) {
                                return Divider(height: getHeight() * 0.04, thickness: getHeight() * 0.002 ,color: AppColors.borderColor);
                              },),
                              SizedBox(height: sizes.height * 0.03),

                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizes.pagePadding),
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
