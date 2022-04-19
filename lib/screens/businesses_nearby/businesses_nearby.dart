import 'package:flutter/material.dart';
import 'package:flutter_app/local/dummy_data/business_category.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/business_list_view_layout.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';


class BusinessesNearBy extends StatelessWidget {
  const BusinessesNearBy({Key? key}) : super(key: key);


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
                      itemCount: businessCategoryDataList.length,
                      itemBuilder: (context, index) {
                        return BusinessListViewLayout(
                            image:  businessCategoryDataList[index].backgroundImage,
                            headerText: businessCategoryDataList[index].title,
                            onViewCourse: (){},
                            address: businessCategoryDataList[index].mainAddress,
                            streetAddress:businessCategoryDataList[index].streetAddress,
                            phoneNumber: businessCategoryDataList[index].phoneNumber
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
