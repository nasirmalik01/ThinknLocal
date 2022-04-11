import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/businesses_components.dart';
import 'package:flutter_app/screens/businesses_categories/business_category.dart';
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
    return Scaffold(
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
              height: getHeight() * 0.12,
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
                      CommonWidgets.searchLocationTextField(
                          controller: searchController,
                          hint: "Search for a business",
                          onPressSearch: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const CauseSearch()));
                          }
                      ),
                      SizedBox(height: getHeight() * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _businessesComponents.getBusinessesCategoriesIcon(
                              image: Assets.foodIcon, label: "Food & Drink",
                            onPressCategory: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const BusinessCategory(businessType: "Food & Drink")));
                            }
                          ),
                          _businessesComponents.getBusinessesCategoriesIcon(
                              image: Assets.thingsIcon, label: "Things to do",
                              onPressCategory: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => const BusinessCategory(businessType: "Things to do")));
                              }
                          ),
                          _businessesComponents.getBusinessesCategoriesIcon(
                              image: Assets.bagIcon, label: "Retail",
                              onPressCategory: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => const BusinessCategory(businessType: "Retail")));
                              }
                          ),
                          _businessesComponents.getBusinessesCategoriesIcon(
                              image: Assets.servicesIcon, label: "Services",
                              onPressCategory: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => const BusinessCategory(businessType: "Services")));
                              }
                          ),
                        ],
                      ),
                      SizedBox(height: getHeight() * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _businessesComponents.typesFeaturedText(title: "Featured", isSelected: true),
                          _businessesComponents.typesFeaturedText(title: "Trending", isSelected: false),
                          _businessesComponents.typesFeaturedText(title: "Favorites", isSelected: false),
                          _businessesComponents.typesFeaturedText(title: "Past", isSelected: false),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getHeight() * 0.01),
                SizedBox(
                  height: getHeight()*0.26,
                  child: ListView.builder(
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
                SizedBox(height: getHeight() * 0.045),
                Padding(
                  padding: EdgeInsets.only(left: sizes.width * 0.06),
                  child: TextView.getMediumText15("Recently Added", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium),
                ),
                SizedBox(height: getHeight() * 0.018),
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
                SizedBox(height: getHeight() * 0.045),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                  child: Column(
                    children: [
                      CommonWidgets.getTextWithSeeAll(
                          text1: "Nearby",
                          text2: "See All",
                          onPressSeeAllButton: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const BusinessesNearBy()));
                          }
                      ),
                      SizedBox(height: getHeight() * 0.018),
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index){
                          return CommonWidgets.businessesDetailListView(
                              image:  Assets.dummyNearBy,
                              headerText: "Andy's Xpress Wash ",
                              onViewCourse: (){
                              },
                              address: "Chino, CA 91710",
                              streetAddress: "15705 Euclid Ave",
                              phoneNumber: "908-900-1791"
                          );
                        }, separatorBuilder: (BuildContext context, int index) {
                        return Divider(height: getHeight() * 0.04, thickness: getHeight() * 0.001 ,color: AppColors.borderColor);
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
    );
  }
}
