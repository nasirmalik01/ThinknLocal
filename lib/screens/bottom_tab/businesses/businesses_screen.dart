import 'package:flutter/material.dart';
import 'package:flutter_app/common/handling_empty_states.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/business_nearby.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/business_tabs_container.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/businesses_components.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/businesses_controller.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/recently_added_business.dart';
import 'package:flutter_app/screens/businesses_categories/business_category.dart';
import 'package:flutter_app/screens/businesses_nearby/businesses_nearby.dart';
import 'package:flutter_app/widgets/custom_tab_bar.dart';
import 'package:flutter_app/widgets/network_error.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';


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
        body:  Obx(() =>
          _businessesController.isError.value
          ? NetworkErrorException(exceptionMessage: _businessesController.errorMessage.value, onPress: (){
            _businessesController.isError.value = false;
            _businessesController.getBusinesses(Strings.featured);
          })
          : Container(
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
                    TextView.titleWithDecoration(Strings.businessNear, color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular,),
                    GestureDetector(
                      onTap: () async {
                         await Get.toNamed(Routes.locationSearchScreen);
                        _businessesController.onInit();
                      },
                      child: Row(
                        children: [
                          TextView.header(_businessesController.locationAddress.value, color: AppColors.greenColor, fontFamily: Assets.poppinsRegular, textDecoration: TextDecoration.underline, fontSize: sizes.fontSize25),
                          Padding(
                            padding: EdgeInsets.only(left: 1.w, bottom: 0.5.h),
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
                            hint: Strings.searchBusiness,
                            onPressSearch: () {
                              Get.toNamed(Routes.businessSearch);
                            }
                        ),
                        SizedBox(height: getHeight() * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _businessesComponents.businessCategoryIcon(
                                image: Assets.foodIcon, label: Strings.foodDrink,
                                onPressCategory: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => BusinessCategory(businessType: Strings.foodDrink, icon: Assets.foodIcon, id: 22,)));
                                }
                            ),
                            _businessesComponents.businessCategoryIcon(
                                image: Assets.thingsIcon, label: Strings.toDoThings,
                                onPressCategory: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => BusinessCategory(businessType: Strings.toDoThings, icon: Assets.thingsIcon, id: 29,)));
                                }
                            ),
                            _businessesComponents.businessCategoryIcon(
                                image: Assets.bagIcon, label: Strings.retail,
                                onPressCategory: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => BusinessCategory(businessType: Strings.retail, icon: Assets.bagIcon, id: 3,)));
                                }
                            ),
                            _businessesComponents.businessCategoryIcon(
                                image: Assets.servicesIcon, label: Strings.services,
                                onPressCategory: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => BusinessCategory(businessType: Strings.services, icon: Assets.servicesIcon, id: 33,)));
                                }
                            ),
                          ],
                        ),
                        SizedBox(height: getHeight() * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customTabBar(title: Strings.featured.capitalize!, isSelected: _businessesController.isFeatured.value,  onTap: (){ _businessesController.setFeaturedTab(); }),
                            customTabBar(title: Strings.trending.capitalize!, isSelected: _businessesController.isTrending.value, onTap: (){ _businessesController.setTrendingTab(); }),
                            customTabBar(title: Strings.favorites.capitalize!, isSelected: _businessesController.isFavorites.value, onTap: (){ _businessesController.setFavoritesTab(); }),
                            customTabBar(title: Strings.past.capitalize!, isSelected: _businessesController.isPast.value, onTap: (){ _businessesController.setPostTab(); }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.01),
                  SizedBox(
                    height: 20.h,
                    child: _businessesController.isBusinessLoading.value
                        ? circularProgressIndicator()
                        : _businessesController.businessList!.isNotEmpty
                        ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index){
                        return index == 5 ? GestureDetector(
                            onTap: (){
                              Get.to(BusinessesDetail(title: Strings.allBusinesses, detailList: _businessesController.businessList!,));
                            },
                            child: CommonWidgets.seeAllButton(40)
                        )
                            : BusinessTabContainer(
                            name: _businessesController.businessList![index].name,
                            fullBoxImage: _businessesController.businessList![index].image ?? Strings.dummyBgImage,
                            logoImage: _businessesController.businessList![index].logo ?? Strings.dummyLogo,
                            bookName:  '',
                            streetAddress: _businessesController.businessList![index].address1,
                            address: _businessesController.businessList![index].address2,
                            phoneNumber:  '+1 ${_businessesController.businessList![index].phone!.substring(0,3)} ${_businessesController.businessList![index].phone!.substring(4, )}',
                            index: index,
                            isFavorite: false,
                            onClickBox: () async {
                              Get.toNamed(Routes.businessDetailScreen, arguments: _businessesController.businessList![index].id);
                            },
                            onPressFavoriteIcon: () {}
                        );
                      },
                    )
                    : handleEmptyState(context, Strings.noBusinesses),
                  ),
                  SizedBox(height: getHeight() * 0.045),
                  Padding(
                    padding: EdgeInsets.only(left: sizes.width * 0.06),
                    child: TextView.titleWithDecoration(Strings.recentlyAdded, color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize16),
                  ),
                  SizedBox(height: getHeight() * 0.01),
                  SizedBox(
                    height: getHeight()*0.14,
                    child: _businessesController.isRecentlyAddedBusinessLoading.value
                        ? circularProgressIndicator()
                        : _businessesController.recentlyAddedBusinessList!.isNotEmpty
                        ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index){
                        return index == 5
                            ? GestureDetector(
                            onTap: (){
                              Get.to(BusinessesDetail(title: Strings.recentlyAddedBusiness, detailList: _businessesController.recentlyAddedBusinessList!,));
                            },
                            child: CommonWidgets.seeAllButton(30))
                            : GestureDetector(
                           onTap: (){
                             Get.toNamed(Routes.businessDetailScreen, arguments: _businessesController.recentlyAddedBusinessList![index].id);
                           },
                           child: RecentlyAddedBusiness(
                          name: _businessesController.recentlyAddedBusinessList![index].name,
                          fullImage: _businessesController.recentlyAddedBusinessList![index].image ?? Strings.dummyBgImage,
                          logoImage: _businessesController.recentlyAddedBusinessList![index].logo ?? Strings.dummyLogo,
                          index: index,
                          onPressFullContainer: (){},
                        ),
                       );
                      },
                    )
                    : handleEmptyState(context, Strings.noRecentBusinesses),
                  ),
                  SizedBox(height: getHeight() * 0.045),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                    child: Column(
                      children: [
                        CommonWidgets.getTextWithSeeAll(
                            leadingText: Strings.nearby,
                            trailingText: Strings.seeAll,
                            onPressSeeAllButton: () {
                              Get.to(BusinessesDetail(title: Strings.businessesNearYou, detailList: _businessesController.nearbyBusinessList!,));
                            }
                        ),
                        SizedBox(height: getHeight() * 0.018),
                        _businessesController.isNearByBusinessLoading.value
                            ? circularProgressIndicator()
                            : _businessesController.nearbyBusinessList!.isNotEmpty
                            ? ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: _businessesController.nearbyBusinessList!.isEmpty ? 0 : 3,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                 Get.toNamed(Routes.businessDetailScreen, arguments: _businessesController.nearbyBusinessList![index].id);
                              },
                              child: BusinessNearBy(
                                  image:  _businessesController.nearbyBusinessList![index].image ?? Strings.dummyBgImage,
                                  headerText: _businessesController.nearbyBusinessList![index].name,
                                  onViewCourse: (){},
                                  address: _businessesController.nearbyBusinessList![index].address1,
                                  streetAddress: _businessesController.nearbyBusinessList![index].address2 ?? Strings.unknown,
                                  phoneNumber: '+1 ${_businessesController.nearbyBusinessList![index].phone!.substring(0,3)} ${_businessesController.nearbyBusinessList![index].phone!.substring(4, )}',
                              ),
                            );
                          }, separatorBuilder: (BuildContext context, int index) {
                          return Divider(height: getHeight() * 0.04, thickness: getHeight() * 0.001 ,color: AppColors.borderColor);
                        },
                        )
                        : handleEmptyState(context, Strings.noNearbyBusinesses),
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
      ),
    );
  }
}
