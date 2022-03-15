import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail.dart';
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
        // backgroundColor: AppColors.appBackground,
        body: Container(
          height: sizes!.height,
          width: sizes!.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            children: [
              Container(
                height: getHeight() * 0.1,
                width: getWidth(),
                padding: EdgeInsets.only(left: sizes!.width * 0.06, right: sizes!.width * 0.06, top: sizes!.height * 0.02),
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
                    TextView.bold22Text("Chino Hills, CA", color: AppColors.greenColor, fontFamily: Assets.poppinsSemiBold,
                        textDecoration: TextDecoration.underline)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes!.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getHeight() * 0.01),
                    CommonWidgets.searchLocation(controller: searchController, hint: "Search for a cause"),
                    SizedBox(height: getHeight() * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _causesComponents.typesText(title: "Featured", isSelected: true),
                        _causesComponents.typesText(title: "Trending", isSelected: false),
                        _causesComponents.typesText(title: "Favorites", isSelected: false),
                        _causesComponents.typesText(title: "Past", isSelected: false),
                      ],
                    ),
                    SizedBox(height: getHeight() * 0.01),
                    SizedBox(
                      height: getHeight()*0.24,
                      child:
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        //padding: EdgeInsets.symmetric(horizontal: getWidth()*0.05),
                        itemBuilder: (context, index){
                          return _causesComponents.getCausesFundsContainer(
                            name: "Chino Hills High School Girls Softall Fundraiser",
                            fullBoxImage: Assets.schoolDummy1,
                            logoImage: Assets.huskiesLogo,
                            bookName:  "",
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
                    TextView.getMediumText15("Recently Started", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                    SizedBox(height: getHeight() * 0.002),
                    SizedBox(
                      height: getHeight()*0.16,
                      child:
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        //padding: EdgeInsets.symmetric(horizontal: getWidth()*0.05),
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
                    _causesComponents.get2TextRow(
                        text1: "Upcoming Causes",
                        text2: "See All"),
                    SizedBox(height: getHeight() * 0.02),
                    Wrap(
                      children: [
                        ...List.generate(
                            3,
                                (index) {
                              return _causesComponents.getUpcomingCauses(
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
              ),

            ],
          ),
        ),
      ),
    );
  }
}
