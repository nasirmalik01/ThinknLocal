import 'package:flutter/material.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/model/businesses.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/business_list_view_layout.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';


class BusinessesNearBy extends StatelessWidget {
  final List<Businesses>? nearbyBusinesses;

  const BusinessesNearBy({this.nearbyBusinesses, Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: sizes.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              CommonWidgets.getSimpleAppBar(
                  title: "Businesses near you",
                  onPressBackArrow: () {
                    Navigator.pop(context);
                  }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: nearbyBusinesses!.length,
                      itemBuilder: (context, index) {
                        return BusinessListViewLayout(
                            image:  nearbyBusinesses![index].image ?? Strings.dummyBgImage,
                            headerText: nearbyBusinesses![index].name,
                            onViewCourse: (){},
                            address: nearbyBusinesses![index].address1,
                            streetAddress: nearbyBusinesses![index].address2,
                            phoneNumber: nearbyBusinesses![index].phone.toString()
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
