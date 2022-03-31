import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/businesses_components.dart';
import 'package:flutter_app/screens/businesses_categories/food_and_drink/food_and_drink.dart';
import 'package:flutter_app/screens/businesses_categories/retail/retail.dart';
import 'package:flutter_app/screens/businesses_categories/services/services.dart';
import 'package:flutter_app/screens/businesses_categories/things_to_do/things_to_do.dart';
import 'package:flutter_app/screens/businesses_detail/businesses_detail.dart';
import 'package:flutter_app/screens/businesses_nearby/businesses_nearby.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';
import '../../cause_search/cause_search.dart';
import '../../sign_in/sign_in.dart';


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
                    TextView.getMediumText15("Businesses near", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular,),
                    TextView.bold22Text("Chino Hills, CA", color: AppColors.greenColor, fontFamily: Assets.poppinsSemiBold,
                        textDecoration: TextDecoration.underline)
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                    child: Column(
                      children: [
                        CommonWidgets.searchLocation(
                            controller: searchController,
                            hint: "Search for a cause",
                            onPressSearch: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const CauseSearch()));
                            }
                        ),
                        SizedBox(height: getHeight() * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _businessesComponents.getIconsContainer(
                                image: Assets.foodIcon, label: "Food & Drink",
                              onPressCategory: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => const FoodAndDrink()));
                              }
                            ),
                            _businessesComponents.getIconsContainer(
                                image: Assets.thingsIcon, label: "Things to do",
                                onPressCategory: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => const ThingsToDo()));
                                }
                            ),
                            _businessesComponents.getIconsContainer(
                                image: Assets.bagIcon, label: "Retail",
                                onPressCategory: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => const Retail()));
                                }
                            ),
                            _businessesComponents.getIconsContainer(
                                image: Assets.servicesIcon, label: "Services",
                                onPressCategory: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => const Services()));
                                }
                            ),
                          ],
                        ),
                        SizedBox(height: getHeight() * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _businessesComponents.typesText(title: "Featured", isSelected: true),
                            _businessesComponents.typesText(title: "Trending", isSelected: false),
                            _businessesComponents.typesText(title: "Favorites", isSelected: false),
                            _businessesComponents.typesText(title: "Past", isSelected: false),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.01),
                  SizedBox(
                    height: getHeight()*0.2,
                    child:
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
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
                              withNavBar: true,
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );
                          },
                          onPressFavoriteIcon: () {
                            pushNewScreen(
                              context,
                              screen: const SignIn(),
                              withNavBar: false,
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );
                          }
                        );
                      },
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.02),
                  Padding(
                    padding: EdgeInsets.only(left: sizes.width * 0.06),
                    child: TextView.getMediumText15("Recently Added", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                  ),
                  SizedBox(height: getHeight() * 0.002),
                  SizedBox(
                    height: getHeight()*0.16,
                    child:
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
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
                  SizedBox(height: getHeight() * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                    child: Column(
                      children: [
                        CommonWidgets.get2TextRow(
                            text1: "Nearby",
                            text2: "See All",
                            onPressSeeAllButton: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const BusinessesNearBy()));
                            }
                        ),
                        SizedBox(height: sizes.height * 0.01),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index){
                            return CommonWidgets.nearByContainer(
                                image:  Assets.dummyNearBy,
                                headerText: "Andy's Xpress Wash ",
                                onViewCourse: (){
                                },
                                address: "Chino, CA 91710",
                                streetAddress: "15705 Euclid Ave",
                                phoneNumber: "908-900-1791"
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
