import 'package:flutter/material.dart';
import 'package:flutter_app/local/dummy_data/about_visit.dart';
import 'package:flutter_app/screens/about_visit/about_visit_controller.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../../res/res.dart';
import '../../constants/assets.dart';
import '../upload/uploading/uploading.dart';


class AboutVisit extends StatefulWidget {
  const AboutVisit({Key? key}) : super(key: key);

  @override
  _AboutVisitState createState() => _AboutVisitState();
}

class _AboutVisitState extends State<AboutVisit> {
  double getRating = 0.0;
  String? _cause;
  String? _businessName;
  final AboutVisitController _aboutVisitController = Get.put(AboutVisitController());

  void updateCause(String value){
    setState(() {
      _cause = value;
    });
  }
  void updateBusiness(String value){
    setState(() {
      _businessName = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: sizes.height,
        width: sizes.width,
        decoration: const BoxDecoration(
          color: AppColors.lightBlack,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: sizes.width * 0.06, right: sizes.width * 0.06, top: sizes.width * 0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView.header("Tell us about your visit!", color: AppColors.greenColor, fontFamily: Assets.poppinsSemiBold, fontSize: sizes.fontSize27),
                  SizedBox(height: getHeight() * 0.02,),
                  TextView.headerWithBlurRadius("How was your experience?", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular, fontSize: sizes.fontSize15,),
                  SizedBox(height: getHeight() * 0.04,),
                  TextView.headerWithBlurRadius("Where did you go?", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                  SizedBox(height: getHeight() * 0.01,),
                  CommonWidgets.dropDownField(
                    selectedCategory: _businessName,
                    updateSelectedCategory: updateBusiness,
                    categories: businessList,
                    hint:"Business Name",
                  ),
                  SizedBox(height: getHeight() * 0.04,),
                  TextView.headerWithBlurRadius("How was your visit?", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                  SizedBox(height: getHeight() * 0.01,),
                  Container(
                    width: getWidth(),
                    padding: EdgeInsets.symmetric(horizontal: getHeight() * 0.02, vertical: getWidth() * 0.03),
                    decoration: BoxDecoration(
                      color: AppColors.blackColor,
                      borderRadius: BorderRadius.circular(getHeight() * 0.01),
                    ),
                    child: RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 35,
                      itemPadding: EdgeInsets.symmetric(
                          horizontal: sizes.width * 0.005),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: AppColors.yellowStarColor,
                        size: 50,
                      ),
                      onRatingUpdate: (rating) {
                        getRating = rating;
                      },
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.04),
                  TextView.headerWithBlurRadius("Was this your first time?", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                  SizedBox(height: getHeight() * 0.01,),
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonWidgets.getButton(
                          onPress: (){
                            if(_aboutVisitController.isVisitFirstTime.value == false) {
                              _aboutVisitController.changeFirstTimeVisit();
                            }
                          },
                          text: "Yes",
                          btnColor: _aboutVisitController.isVisitFirstTime.value ? AppColors.greenColor : AppColors.blackColor,
                          textColor: _aboutVisitController.isVisitFirstTime.value ? AppColors.pureWhiteColor : AppColors.darkGrey,
                          width: getWidth() * 0.43,
                          height: getHeight() * 0.08
                      ),
                      CommonWidgets.getButton(
                          onPress: (){
                            if(_aboutVisitController.isVisitFirstTime.value == true) {
                              _aboutVisitController.changeFirstTimeVisit();
                            }
                          },
                          text: "No",
                          btnColor: _aboutVisitController.isVisitFirstTime.value ? AppColors.blackColor : AppColors.greenColor,
                          textColor: _aboutVisitController.isVisitFirstTime.value ? AppColors.darkGrey : AppColors.pureWhiteColor,
                          width: getWidth() * 0.43,
                          height: getHeight() * 0.08

                      ),
                    ],
                  ),) ,
                  SizedBox(height: getHeight() * 0.04),
                  TextView.headerWithBlurRadius("What cause do you want to support?", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsRegular),
                  SizedBox(height: getHeight() * 0.01),
                  CommonWidgets.dropDownField(
                    selectedCategory: _cause,
                    updateSelectedCategory: updateCause,
                    categories: causesList,
                    hint:"Causes Name",
                  ),
                  SizedBox(height: getHeight() * 0.07),
                  CommonWidgets.getButton(
                      onPress: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const Uploading()));
                      },
                      text: "Looks Good!",
                      height: getHeight() * 0.08,
                      textColor: AppColors.pureWhiteColor,
                      btnColor: AppColors.greenColor),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}