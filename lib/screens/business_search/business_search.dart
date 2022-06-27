import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:thinknlocal_app/constants/routes.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/screens/bottom_tab/businesses/business_list_view_layout.dart';
import 'package:thinknlocal_app/screens/business_search/business_search_controller.dart';
import 'package:thinknlocal_app/screens/businesses_detail/businesses_detail.dart';
import 'package:thinknlocal_app/widgets/empty_state.dart';
import 'package:thinknlocal_app/widgets/loading_indicator.dart';
import 'package:thinknlocal_app/widgets/network_error.dart';
import 'package:get/get.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';


class BusinessSearch extends StatelessWidget {
  final TextEditingController? _searchController = TextEditingController();
  final BusinessSearchController _businessSearchController = Get.put(BusinessSearchController());

  BusinessSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  Obx(() =>
      _businessSearchController.isError.value
          ?  NetworkErrorException(exceptionMessage: _businessSearchController.errorMessage.value, onPress: (){
        _businessSearchController.isError.value = false;
        _businessSearchController.getSearchedBusinesses('');
        _searchController!.clear();
      })
          :
      SingleChildScrollView(
        child: Container(
          width: sizes.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              CommonWidgets.getAppBarWithSearch(
                  title: "",
                  hint: '${Strings.searchForA} ${Strings.business}',
                  textEditingController: _searchController,
                  onChanged: (val){
                    _businessSearchController.getSearchedBusinesses(val);
                  },
                  onPressBackArrow: () {
                    Navigator.pop(context);
                  }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                child: ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: [
                    TextView.title(Strings.showingResultsFor,
                        color: AppColors.lightBlack,
                        fontFamily: Assets.poppinsMedium),
                    SizedBox(height: getHeight() * 0.01),
                    TextView.headerWithBlurRadius("- ${_businessSearchController.locationAddress.value}", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular, lines: 1, fontSize: sizes.fontSize12),
                    SizedBox(height: getHeight() * 0.02),
                    _businessSearchController.isSearchedBusinessLoading.value
                        ? bouncingLoadingIndicator()
                        :  _businessSearchController.searchedBusinessList?.isEmpty ?? false
                        ? emptyState('No results', height: getHeight()*0.2)
                        : ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: _businessSearchController.searchedBusinessList!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    pushNewScreen(context,
                                      screen: BusinessesDetailScreen(businessId: _businessSearchController.searchedBusinessList![index].id),
                                      withNavBar: true,
                                    );
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: BusinessListViewLayout(
                                        image:  _businessSearchController.searchedBusinessList![index].image,
                                        headerText: _businessSearchController.searchedBusinessList![index].name,
                                        onViewCourse: (){},
                                        address: _businessSearchController.searchedBusinessList![index].address1,
                                        streetAddress: _businessSearchController.searchedBusinessList![index].address2,
                                        phoneNumber: _businessSearchController.searchedBusinessList![index].phone.toString()
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Divider(
                                    height: getHeight() * 0.04,
                                    thickness: getHeight() * 0.002,
                                    color: AppColors.borderColor);
                              },
                            ),
                            SizedBox(height: getHeight() * 0.04),
                          ],
                        ),
                    SizedBox(height: getHeight() * 0.04),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
