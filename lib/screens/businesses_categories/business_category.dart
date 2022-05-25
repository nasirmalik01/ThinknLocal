import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/business_nearby.dart';
import 'package:flutter_app/screens/businesses_categories/business_category_controller.dart';
import 'package:get/get.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/text_views.dart';

class BusinessCategory extends StatelessWidget {
  final String businessType;
  final String icon;
  final int id;
  BusinessCategory({Key? key, required this.businessType, required this.icon, required this.id}) : super(key: key);

  final BusinessCategoryController _businessCategoryController = Get.put(BusinessCategoryController());

  @override
  Widget build(BuildContext context) {
    _businessCategoryController.getBusinessCategory(id);

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
                  title: "",
                  onPressBackArrow: () {
                    Navigator.pop(context);
                  }),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth()*0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView.title(Strings.showingResultsFor,
                            color: AppColors.lightBlack,
                            fontFamily: Assets.poppinsMedium),
                        SizedBox(height: getHeight() * 0.02),
                        CommonWidgets.getCategoryWithText(
                            image: icon,
                            title: businessType
                        ),
                        SizedBox(height: getHeight() * 0.04),
                        Obx(() =>
                          _businessCategoryController.isLoading.value
                          ? circularProgressIndicator()
                          : ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: _businessCategoryController.businessCategoryList!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: getHeight()*0.01, left: getWidth()*0.03),
                              child: GestureDetector(
                                onTap: (){
                                  Get.toNamed(Routes.businessDetailScreen, arguments: _businessCategoryController.businessCategoryList![index].id);
                                },
                                child: BusinessNearBy(
                                  image: _businessCategoryController.businessCategoryList![index].image,
                                  headerText: _businessCategoryController.businessCategoryList![index].name,
                                  onViewCourse: (){},
                                  address: _businessCategoryController.businessCategoryList![index].address1,
                                  streetAddress: _businessCategoryController.businessCategoryList![index].address2,
                                  phoneNumber: _businessCategoryController.businessCategoryList![index].phone.toString(),
                                  isBusinessCategory: true,
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
                        ),),
                        SizedBox(height: getHeight() * 0.04),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
