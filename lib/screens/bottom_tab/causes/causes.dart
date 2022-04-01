import 'package:flutter/material.dart';
import 'package:flutter_app/screens/cause_search/cause_search.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail.dart';
import 'package:flutter_app/screens/causes_upcoming/causes_upcoming.dart';
import 'package:flutter_app/screens/location_search/location_search.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_components.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';


class Causes extends StatefulWidget {
  const Causes({Key? key}) : super(key: key);

  @override
  _CausesState createState() => _CausesState();
}

class _CausesState extends State<Causes> {
  final CausesComponents _causesComponents = CausesComponents();
  TextEditingController? searchController;


  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: sizes.height,
          width: sizes.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            children: [
              Container(
                height: getHeight() * 0.1,
                width: getWidth(),
                padding: EdgeInsets.only(left: sizes.width * 0.06, right: sizes.width * 0.06, top: sizes.height * 0.02),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.gradientColor1,
                      AppColors.pureWhiteColor,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView.getMediumText15("Causes near", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular,),
                    Row(
                      children: [
                        TextView.bold22Text("Chino Hills, CA", color: AppColors.greenColor, fontFamily: Assets.poppinsSemiBold,
                            textDecoration: TextDecoration.underline),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const LocationSearch()));
                            },
                            child: Icon(Icons.location_on_outlined, size: getHeight() * 0.03, color: AppColors.greenColor,)),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getHeight() * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                    child: CommonWidgets.searchLocationTextField(
                        controller: searchController,
                        hint: "Search for a cause",
                        onPressSearch: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const CauseSearch()));
                        }
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _causesComponents.typesFeaturedText(title: "Featured", isSelected: true),
                        _causesComponents.typesFeaturedText(title: "Trending", isSelected: false),
                        _causesComponents.typesFeaturedText(title: "Favorites", isSelected: false),
                        _causesComponents.typesFeaturedText(title: "Past", isSelected: false),
                      ],
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.01),
                  SizedBox(
                    height: getHeight()*0.24,
                    child:
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index){
                        return _causesComponents.getCausesFundsContainer(
                          name: "Chino Hills High School Girls Softall Fundraiser",
                          fullBoxImage: Assets.schoolDummy1,
                          logoImage: Assets.huskiesLogo,
                          completePercentage: 0.7,
                          collectedAmount: "342.5",
                          totalAmount: "450",
                          endDate: "March 2nd",
                          onClickBox: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const CausesDetail()));
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.02),
                  Padding(
                    padding: EdgeInsets.only(left: sizes.width * 0.06),
                    child: TextView.getMediumText15("Recently Started", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                  ),
                  SizedBox(height: getHeight() * 0.002),
                  SizedBox(
                    height: getHeight()*0.17,
                    child:
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index){
                        return _causesComponents.getRecentlyStartedContainer(
                          name: "Ayala High School Cheer Fundraiser",
                          image: "",
                          onPressFullContainer: (){
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.02),
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
                        SizedBox(height: getHeight() * 0.02),
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
              ),

            ],
          ),
        ),
      ),
    );
  }
}
