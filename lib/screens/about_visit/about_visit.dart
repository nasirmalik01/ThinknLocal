import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/enums/first_time_visit.dart';
import 'package:flutter_app/screens/about_visit/about_visit_controller.dart';
import 'package:flutter_app/screens/about_visit/auto_complete_text_field.dart';
import 'package:flutter_app/screens/bottom_tab/scan/contribution_controller.dart';
import 'package:flutter_app/screens/upload/uploading/uploading.dart';
import 'package:flutter_app/screens/upload/uploading_failed/uploading_failed.dart';
import 'package:flutter_app/screens/upload/uploading_success/uploading_success.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../res/res.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';

// ignore: must_be_immutable
class AboutVisit extends StatelessWidget {
  AboutVisit({Key? key}) : super(key: key);

  final AboutVisitController _aboutVisitController = Get.put(AboutVisitController());
  final ContributionController _contributionController = Get.put(ContributionController());
  double getRating = 0.0;

  @override
  Widget build(BuildContext context) {
    final _xFile = ModalRoute.of(context)!.settings.arguments as XFile;

    return Scaffold(
      body: Obx(
        () => (_aboutVisitController.isBusinessLoading.value || _aboutVisitController.isCausesLoading.value)
            ? circularProgressIndicator()
            : _contributionController.isUploading.value ? const Uploading()
            : _contributionController.isUploadSuccess.value ? const UploadSuccess()
            : _contributionController.isUploadFailed.value ? UploadFailed(
              onTryAgainClick: (){
                    Map<String, dynamic> body = {};
                    body['business_id'] = _aboutVisitController.selectedBusinessId.value;
                    body['cause_id'] = _aboutVisitController.selectedCauseId.value;
                    body['rating'] = getRating;
                    body['first_purchase'] = _aboutVisitController.isVisitFirstTime.value == IsFirstTime.yes ? true : _aboutVisitController.isVisitFirstTime.value == IsFirstTime.no ? false : null;
                    _contributionController.uploadAndCreateContributions(body, File(_xFile.path),);
                },)
            : SingleChildScrollView(
                child: Container(
                  width: sizes.width,
                  decoration: const BoxDecoration(
                    color: AppColors.lightBlack,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: sizes.width * 0.06,
                            right: sizes.width * 0.06,
                            top: sizes.width * 0.2,
                            bottom: getHeight() * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView.header(Strings.tellUsAboutVisit,
                                color: AppColors.greenColor,
                                fontFamily: Assets.poppinsSemiBold,
                                fontSize: sizes.fontSize27),
                            SizedBox(
                              height: getHeight() * 0.02,
                            ),
                            TextView.headerWithBlurRadius(
                              Strings.howWasYourExperience,
                              color: AppColors.pureWhiteColor,
                              fontFamily: Assets.poppinsRegular,
                              fontSize: sizes.fontSize15,
                            ),
                            SizedBox(
                              height: getHeight() * 0.04,
                            ),
                            TextView.headerWithBlurRadius(Strings.whereDidYouGo,
                                color: AppColors.pureWhiteColor,
                                fontFamily: Assets.poppinsRegular),
                            SizedBox(
                              height: getHeight() * 0.01,
                            ),
                            AutoFieldTextField(
                              hintText: Strings.businessName,
                              onSelect: _aboutVisitController.onBusinessCompletePress,
                              isBusiness: true,
                            ),
                            SizedBox(
                              height: getHeight() * 0.04,
                            ),
                            TextView.headerWithBlurRadius(
                                Strings.howWasYourVisit,
                                color: AppColors.pureWhiteColor,
                                fontFamily: Assets.poppinsRegular),
                            SizedBox(
                              height: getHeight() * 0.01,
                            ),
                            Container(
                              width: getWidth(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: getHeight() * 0.02,
                                  vertical: getWidth() * 0.03),
                              decoration: BoxDecoration(
                                color: AppColors.blackColor,
                                borderRadius:
                                    BorderRadius.circular(getHeight() * 0.01),
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
                            TextView.headerWithBlurRadius(
                                Strings.wasThisFirstTime,
                                color: AppColors.pureWhiteColor,
                                fontFamily: Assets.poppinsRegular),
                            SizedBox(
                              height: getHeight() * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Button(
                                    onPress: () {
                                        _aboutVisitController.changeFirstTimeVisit(isFirst: true);
                                    },
                                    text: Strings.yes,
                                    btnColor: _aboutVisitController.isVisitFirstTime.value == IsFirstTime.nothing ? AppColors.blackColor : _aboutVisitController.isVisitFirstTime.value == IsFirstTime.yes ? AppColors.greenColor : AppColors.blackColor,
                                    textColor: _aboutVisitController.isVisitFirstTime.value == IsFirstTime.nothing ? AppColors.darkGrey : _aboutVisitController.isVisitFirstTime.value == IsFirstTime.yes ? AppColors.pureWhiteColor : AppColors.darkGrey,
                                    width: getWidth() * 0.43,
                                    height: getHeight() * 0.08),
                                Button(
                                    onPress: () {
                                        _aboutVisitController.changeFirstTimeVisit(isFirst: false);
                                    },
                                    text: Strings.no,
                                    btnColor: _aboutVisitController.isVisitFirstTime.value == IsFirstTime.nothing ? AppColors.blackColor : _aboutVisitController.isVisitFirstTime.value == IsFirstTime.no ? AppColors.greenColor : AppColors.blackColor ,
                                    textColor: _aboutVisitController.isVisitFirstTime.value == IsFirstTime.nothing ? AppColors.darkGrey : _aboutVisitController.isVisitFirstTime.value == IsFirstTime.no ? AppColors.pureWhiteColor : AppColors.darkGrey,
                                    width: getWidth() * 0.43,
                                    height: getHeight() * 0.08),
                              ],
                            ),
                            SizedBox(height: getHeight() * 0.04),
                            TextView.headerWithBlurRadius(
                                Strings.whatCauseYouSupport,
                                color: AppColors.pureWhiteColor,
                                fontFamily: Assets.poppinsRegular),
                            SizedBox(height: getHeight() * 0.01),
                            AutoFieldTextField(
                                hintText: Strings.courseName,
                                onSelect: _aboutVisitController.onCauseCompletePress,
                                isEnabled: _aboutVisitController.selectedBusinessId.value == 0 ? false : true,
                            ),
                            SizedBox(height: getHeight() * 0.07),
                            Button(
                              onPress: () async {
                                if(_aboutVisitController.selectedBusinessId.value == 0){
                                  return showSnackBar(subTitle: 'Please select business');
                                }
                                if(_aboutVisitController.selectedCauseId.value == 0){
                                  return showSnackBar(subTitle: 'Please select cause');
                                }
                                Map<String, dynamic> body = {};
                                body['business_id'] = _aboutVisitController.selectedBusinessId.value;
                                body['cause_id'] = _aboutVisitController.selectedCauseId.value;
                                body['rating'] = getRating;
                                body['first_purchase'] = _aboutVisitController.isVisitFirstTime.value == IsFirstTime.yes ? true : _aboutVisitController.isVisitFirstTime.value == IsFirstTime.no ? false : null;
                                _contributionController.uploadAndCreateContributions(body, File(_xFile.path),);
                              },
                              text: Strings.looksGood,
                              height: getHeight() * 0.08,
                              textColor: AppColors.pureWhiteColor,
                              btnColor: AppColors.greenColor,
                            ),
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
