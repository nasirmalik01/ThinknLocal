import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/screens/location_search/get_cities.dart';
import 'package:flutter_app/screens/location_search/location_search_controller.dart';
import 'package:flutter_app/widgets/empty_state.dart';
import 'package:flutter_app/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import '/constants/assets.dart';
import '/constants/colors.dart';
import '/res/res.dart';
import '/widgets/common_widgets.dart';
import '/widgets/text_views.dart';

class LocationSearchScreen extends StatelessWidget {
  LocationSearchScreen({Key? key}) : super(key: key);
  final TextEditingController? searchController = TextEditingController();
  final LocationSearchController _locationSearchController = Get.put(LocationSearchController());

  @override
  Widget build(BuildContext context) {
    _locationSearchController.getLocationAddress();
    _locationSearchController.getCities('');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: sizes.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Obx(() => CommonWidgets.getAppBarWithSearch(
                  title: _locationSearchController.noLocation.value,
                  hint: Strings.searchForCity,
                  textEditingController: searchController,
                  onChanged: (val){
                    _locationSearchController.getCities(val);
                  },
                  onPressBackArrow: () {
                    Navigator.pop(context);
                  }),),
             Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TextView.title(Strings.citiesNearYou,
                        color: AppColors.lightBlack,
                        fontFamily: Assets.poppinsMedium,
                        fontSize: sizes.fontSize20),
                    SizedBox(height: getHeight() * 0.02),
                MixinBuilder<LocationSearchController>(builder: (_){
                  return  _locationSearchController.isLoading.value
                      ? bouncingLoadingIndicator()
                      :  _locationSearchController.citiesList.isEmpty
                      ? emptyState('No results', height: getHeight()*0.2)
                      :  ListView.separated(
                    padding: EdgeInsets.symmetric(
                        vertical: getHeight() * 0.02),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: _locationSearchController.citiesList.length,
                    itemBuilder: (context, index) {
                      dynamic formattedDistance =  commaFormatter(_locationSearchController.citiesList[index].distance);

                      return GestureDetector(
                        onTap: ()  {
                          _locationSearchController.saveSelectedAddress(index);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: getHeight() * 0.01),
                          child: GetCities(
                              cityName: _locationSearchController.citiesList[index].name,
                              distance: formattedDistance
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
                  );
                }),
                    SizedBox(height: getHeight() * 0.04),
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