import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/businesses_components.dart';
import 'package:flutter_app/screens/businesses_detail/businesses_detail.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';
import '../../causes_detail/causes_detail.dart';


class Businesses extends StatefulWidget {
  const Businesses({Key? key}) : super(key: key);

  @override
  _BusinessesState createState() => _BusinessesState();
}

class _BusinessesState extends State<Businesses> {
  TextEditingController? searchController;
  final BusinessesComponents _businessesComponents = BusinessesComponents();

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
                    TextView.getMediumText15("Businesses near", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular,),
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
                    //SizedBox(height: getHeight() * 0.02),
                    CommonWidgets.searchLocation(controller: searchController, hint: "Search for a cause"),
                    SizedBox(height: getHeight() * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _businessesComponents.getIconsContainer(image: Assets.foodIcon, label: "Food & Drink"),
                        _businessesComponents.getIconsContainer(image: Assets.thingsIcon, label: "Things to do"),
                        _businessesComponents.getIconsContainer(image: Assets.bagIcon, label: "Retail"),
                        _businessesComponents.getIconsContainer(image: Assets.servicesIcon, label: "Services"),
                      ],
                    ),
                    SizedBox(height: getHeight() * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _businessesComponents.typesText(title: "Featured", isSelected: true),
                        _businessesComponents.typesText(title: "Trending", isSelected: false),
                        _businessesComponents.typesText(title: "Favorites", isSelected: false),
                        _businessesComponents.typesText(title: "Past", isSelected: false),
                      ],
                    ),
                    SizedBox(height: getHeight() * 0.01),
                    SizedBox(
                      height: getHeight()*0.2,
                      child:
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        //padding: EdgeInsets.symmetric(horizontal: getWidth()*0.05),
                        itemBuilder: (context, index){
                          return _businessesComponents.getBusinessesContainer(
                            name: "Chino Hills Pizza Co.",
                            fullBoxImage: Assets.dummyRestaurant,
                            logoImage: Assets.dummyRestaurantLogo,
                            bookName:  "",
                            streetAddress: "15705 Euclid Ave",
                            address: "Chino, CA 9170",
                            phoneNumber: "909-254-7898",
                            isFavorite: false,
                            onClickBox: (){
                              pushNewScreen(
                                context,
                                screen: const BusinessesDetail(),
                                withNavBar: true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                              );
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (_) => const BusinessesDetail()));
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: getHeight() * 0.02),
                    TextView.getMediumText15("Recently Added", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                    SizedBox(height: getHeight() * 0.002),
                    SizedBox(
                      height: getHeight()*0.15,
                      child:
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        //padding: EdgeInsets.symmetric(horizontal: getWidth()*0.05),
                        itemBuilder: (context, index){
                          return _businessesComponents.getRecentlyAddedContainer(
                            name: "It's Yogurt",
                            fullImage: "",
                            logoImage: "",
                            onPressFullContainer: (){
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: getHeight() * 0.02),
                    _businessesComponents.get2TextRow(
                        text1: "Nearby",
                        text2: "See All"),
                    SizedBox(height: sizes!.height * 0.02),
                    Wrap(
                      children: [
                        ...List.generate(
                            3,
                                (index) {
                              return _businessesComponents.nearByContainer(
                                  image:  Assets.dummyNearBy,
                                  headerText: "Andy's Xpress Wash ",
                                  onViewCourse: (){
                                  },
                                  address: "Chino, CA 91710",
                                  streetAddress: "15705 Euclid Ave",
                                  phoneNumber: "908-900-1791"
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
