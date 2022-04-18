import 'package:flutter/material.dart';
import 'package:flutter_app/local/dummy_data/business_category.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/business_nearby.dart';
import 'package:flutter_app/widgets/status_bar.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/text_views.dart';


class BusinessCategory extends StatelessWidget {
  final String businessType;
  final String icon;
  const BusinessCategory({Key? key, required this.businessType, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: sizes.height,
        width: sizes.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            CommonWidgets.getSimpleAppBar(
                title: "",
                onPressBackArrow: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth()*0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView.title("Showing results for",
                            color: AppColors.lightBlack,
                            fontFamily: Assets.poppinsMedium),
                        SizedBox(height: getHeight() * 0.02),
                        CommonWidgets.getCategoryWithText(
                            image: icon,
                            title: businessType
                        ),
                        SizedBox(height: getHeight() * 0.04),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: businessCategoryDataList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: getHeight()*0.01, left: getWidth()*0.03),
                              child: BusinessNearBy(
                                image:  businessCategoryDataList[index].backgroundImage,
                                headerText: businessCategoryDataList[index].title,
                                onViewCourse: (){},
                                address: businessCategoryDataList[index].mainAddress,
                                streetAddress: businessCategoryDataList[index].streetAddress,
                                phoneNumber: businessCategoryDataList[index].phoneNumber,
                                isBusinessCategory: true,
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
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
