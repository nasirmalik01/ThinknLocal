import 'package:flutter/material.dart';
import 'package:flutter_app/local/dummy_data/location.dart';
import 'package:flutter_app/screens/location_search/get_cities.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';

class LocationSearchScreen extends StatelessWidget {
  LocationSearchScreen({Key? key}) : super(key: key);


  final TextEditingController? searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              CommonWidgets.getAppBarWithSearch(
                  title: "Chino Hills CA",
                  hint: "Search for a city...",
                  textEditingController: searchController,
                  onPressBackArrow: () {
                    Navigator.pop(context);
                  }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TextView.title("Cities near you", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize20),
                    SizedBox(height: getHeight() * 0.02),
                    ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: getHeight()*0.02),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: citiesNearMeList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: getHeight()*0.01),
                          child: GetCities(
                              cityName: citiesNearMeList[index].placeName,
                              distance: citiesNearMeList[index].distance.toString()),
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
    );
  }
}
