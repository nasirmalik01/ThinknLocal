import 'package:flutter/material.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/local/dummy_data/businesses.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/business_nearby.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/business_tabs_container.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/businesses_components.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/businesses_controller.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/recently_added_business.dart';
import 'package:flutter_app/screens/businesses_categories/business_category.dart';
import 'package:flutter_app/screens/businesses_detail/businesses_detail.dart';
import 'package:flutter_app/screens/businesses_nearby/businesses_nearby.dart';
import 'package:flutter_app/widgets/custom_tab_bar.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';
import '../../cause_search/cause_search.dart';


class BusinessesScreen extends StatelessWidget {
  BusinessesScreen({Key? key}) : super(key: key);

  final TextEditingController? searchController = TextEditingController();
  final BusinessesComponents _businessesComponents = BusinessesComponents();
  final BusinessesController _businessesController = Get.put(BusinessesController());


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(() =>
            Container(
              height: sizes.height,
              width: sizes.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                // controller: _businessesController.scrollController,
                children: [
                  Container(
                    height: getHeight() * 0.12,
                    width: getWidth(),
                    padding: EdgeInsets.only(left: sizes.width * 0.06, right: sizes.width * 0.06, top: sizes.height * 0.02),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: PreferenceUtils.getGradient()
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView.titleWithDecoration("Businesses near", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular,),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(Routes.locationSearchScreen);
                          },
                          child: Row(
                            children: [
                              TextView.header("Chino Hills, CA", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular, textDecoration: TextDecoration.underline, fontSize: sizes.fontSize25),
                              Padding(
                                padding: EdgeInsets.only(left: 2.w, bottom: 0.5.h),
                                child: Image(
                                  height: getHeight() * 0.03,
                                  image: const AssetImage(Assets.vectorIcon),),
                              ),
                            ],
                          ),
                        )
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
                                      MaterialPageRoute(builder: (_) => CauseSearch(isBusiness: true,)));
                                }
                            ),
                            SizedBox(height: getHeight() * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _businessesComponents.businessCategoryIcon(
                                    image: Assets.foodIcon, label: "Food & Drink",
                                    onPressCategory: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) => const BusinessCategory(businessType: "Food & Drink", icon: Assets.foodIcon,)));
                                    }
                                ),
                                _businessesComponents.businessCategoryIcon(
                                    image: Assets.thingsIcon, label: "Things to do",
                                    onPressCategory: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) => const BusinessCategory(businessType: "Things to do", icon: Assets.thingsIcon,)));
                                    }
                                ),
                                _businessesComponents.businessCategoryIcon(
                                    image: Assets.bagIcon, label: "Retail",
                                    onPressCategory: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) => const BusinessCategory(businessType: "Retail", icon: Assets.bagIcon,)));
                                    }
                                ),
                                _businessesComponents.businessCategoryIcon(
                                    image: Assets.servicesIcon, label: "Services",
                                    onPressCategory: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) => const BusinessCategory(businessType: "Services", icon: Assets.servicesIcon,)));
                                    }
                                ),
                              ],
                            ),
                            SizedBox(height: getHeight() * 0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customTabBar(title: "Featured", isSelected: _businessesController.isFeatured.value,  onTap: (){ _businessesController.setFeaturedTab(); }),
                                customTabBar(title: "Trending", isSelected: _businessesController.isTrending.value, onTap: (){ _businessesController.setTrendingTab(); }),
                                customTabBar(title: "Favorites", isSelected: _businessesController.isFavorites.value, onTap: (){ _businessesController.setFavoritesTab(); }),
                                customTabBar(title: "Past", isSelected: _businessesController.isPast.value, onTap: (){ _businessesController.setPostTab(); }),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: getHeight() * 0.01),
                      SizedBox(
                        height: 20.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: businessTabViewDataList.length,
                          itemBuilder: (context, index){
                            return BusinessTabContainer(
                                name: businessTabViewDataList[index].title,
                                fullBoxImage: businessTabViewDataList[index].backgroundImage,
                                logoImage: businessTabViewDataList[index].icon,
                                bookName:  "",
                                streetAddress: businessTabViewDataList[index].streetAddress,
                                address: businessTabViewDataList[index].mainAddress,
                                phoneNumber: businessTabViewDataList[index].phoneNumber,
                                index: index,
                                isFavorite: false,
                                onClickBox: () async {
                                   pushNewScreen(context, screen: const BusinessesDetail(), withNavBar: true);
                                },
                                onPressFavoriteIcon: () {}
                            );
                          },
                        ),
                      ),
                      SizedBox(height: getHeight() * 0.045),
                      Padding(
                        padding: EdgeInsets.only(left: sizes.width * 0.06),
                        child: TextView.titleWithDecoration("Recently Added", color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize16),
                      ),
                      SizedBox(height: getHeight() * 0.01),
                      SizedBox(
                        height: getHeight()*0.14,
                        child:
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: recentlyStartedBusinessList.length,
                          itemBuilder: (context, index){
                            return index == recentlyStartedBusinessList.length - 1 ? Padding(
                              padding: EdgeInsets.only(left: 1.h, right: 1.5.h),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xFF7DDFC3),
                                child: TextView.titleWithDecoration('See All', color: Colors.white, fontSize:sizes.fontSize12),
                              ),
                            ) : RecentlyAddedBusiness(
                              name: recentlyStartedBusinessList[index].title,
                              fullImage: recentlyStartedBusinessList[index].backgroundImage,
                              logoImage: recentlyStartedBusinessList[index].icon,
                              index: index,
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
                                leadingText: "Nearby",
                                trailingText: "See All",
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
                              itemCount: nearbyBusinessesList.length,
                              itemBuilder: (context, index){
                                return BusinessNearBy(
                                    image:  nearbyBusinessesList[index].backgroundImage,
                                    headerText: nearbyBusinessesList[index].title,
                                    onViewCourse: (){},
                                    address: nearbyBusinessesList[index].mainAddress,
                                    streetAddress: nearbyBusinessesList[index].streetAddress,
                                    phoneNumber: nearbyBusinessesList[index].phoneNumber
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
        )
      ),
    );
  }
}
