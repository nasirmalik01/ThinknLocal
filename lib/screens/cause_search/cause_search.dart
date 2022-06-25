import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/routes.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/screens/bottom_tab/causes/upcoming_causes.dart';
import 'package:thinknlocal_app/screens/cause_search/cause_search_controller.dart';
import 'package:thinknlocal_app/widgets/empty_state.dart';
import 'package:thinknlocal_app/widgets/loading_indicator.dart';
import 'package:thinknlocal_app/widgets/network_error.dart';
import 'package:get/get.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';


class CauseSearch extends StatelessWidget {
  final TextEditingController? searchController = TextEditingController();
  final bool isBusiness;
  final CauseSearchController _causeSearchController = Get.put(CauseSearchController());
  CauseSearch({this.isBusiness = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  Obx(() =>
      _causeSearchController.isError.value
          ?  NetworkErrorException(exceptionMessage: _causeSearchController.errorMessage.value, onPress: (){
        _causeSearchController.isError.value = false;
        _causeSearchController.getSearchedCauses('');
         searchController!.clear();
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
                  hint: '${Strings.searchForA} ${isBusiness ? Strings.business : Strings.cause}',
                  textEditingController: searchController,
                  onChanged: (val){
                      _causeSearchController.getSearchedCauses(val);
                  },
                  onPressBackArrow: () {
                    Navigator.pop(context);
                  }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TextView.title(Strings.showingResultsFor,
                        color: AppColors.lightBlack,
                        fontFamily: Assets.poppinsMedium),
                    SizedBox(height: getHeight() * 0.01),
                    TextView.headerWithBlurRadius("- ${_causeSearchController.locationAddress.value}", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular, lines: 1, fontSize: sizes.fontSize12),
                    SizedBox(height: getHeight() * 0.02),
                      _causeSearchController.isSearchedCauseLoading.value
                      ? bouncingLoadingIndicator()
                      :  _causeSearchController.searchedCausesList?.isEmpty ?? false
                      ? emptyState('No results', height: getHeight()*0.2)
                      : ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: _causeSearchController.searchedCausesList!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.toNamed(Routes.causesDetailScreen, arguments: {
                              Strings.causeId: _causeSearchController.searchedCausesList![index].id,
                              Strings.organizationId: _causeSearchController.searchedCausesList![index].organization!.id,
                            });
                          },
                          child: UpcomingCauses(
                              image:  _causeSearchController.searchedCausesList![index].image,
                              headerText: _causeSearchController.searchedCausesList![index].name,
                              description:  _causeSearchController.searchedCausesList![index].description,
                              onViewCourse: (){},
                              totalAmount: _causeSearchController.searchedCausesList![index].raised.toString(),
                              date: _causeSearchController.searchedCausesList![index].start.toString()
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
              ),
            ],
          ),
      ),
        ),
      ),
    );
  }
}
