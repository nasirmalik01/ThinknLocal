import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/enums/first_time_visit.dart';
import 'package:thinknlocal_app/model/businesses.dart';
import 'package:thinknlocal_app/model/causes.dart';
import 'package:thinknlocal_app/network/remote_repositories/business_repository.dart';
import 'package:thinknlocal_app/network/remote_repositories/cause_repository.dart';
import 'package:thinknlocal_app/network/remote_services.dart';
import 'package:get/get.dart';



class SuggestionModel{
   String title;
   String? subTitle;

  SuggestionModel({required this.title, this.subTitle});
}


class AboutVisitController extends GetxController {
  Rx<IsFirstTime> isVisitFirstTime = IsFirstTime.nothing.obs;
  RxString selectedBusiness = ''.obs;
  RxString selectedCourse = ''.obs;
  RxInt selectedCauseId = 0.obs;
  RxInt selectedBusinessId = 0.obs;
  RxList<Causes>? causesList = <Causes>[].obs;
  List<Businesses>? businessList = [];
  RxBool isCausesLoading = false.obs;
  RxBool isBusinessLoading = false.obs;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;

  TextEditingController businessController =  TextEditingController();
  TextEditingController  causesController = TextEditingController();


  changeFirstTimeVisit({bool isFirst = false}) {
    isVisitFirstTime.value = isFirst ? IsFirstTime.yes : !isFirst ? IsFirstTime.no : IsFirstTime.nothing;
  }

  @override
  void onInit() {
    getBusinesses();
    super.onInit();
  }

  getCauses(int businessId) async {
    causesList!.value = (await (CausesRemoteRepository.fetchCauses({Strings.businessId: businessId})))!;
    if (RemoteServices.statusCode != 200 &&
        RemoteServices.statusCode != 201 &&
        RemoteServices.statusCode != 204) {
          isError.value = true;
          isCausesLoading.value = false;
          errorMessage.value = RemoteServices.error;
          return;
    }
  }

  getBusinesses() async {
    isBusinessLoading.value = true;
    businessList = await (BusinessRemoteRepository.fetchBusinesses({}));
    if (RemoteServices.statusCode != 200 &&
        RemoteServices.statusCode != 201 &&
        RemoteServices.statusCode != 204) {
      isError.value = true;
      isBusinessLoading.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
    isBusinessLoading.value = false;
  }

  Iterable<SuggestionModel> setOptionsBuilder({TextEditingValue? value, bool isBusiness = false, bool isEmptyTextFieldValue = false}) {
    List<SuggestionModel> causesStringList = [];
    List<SuggestionModel> businessStringList = <SuggestionModel>[];

    if (isBusiness) {
      if (businessList!.isNotEmpty) {
        for (int i = 0; i < businessList!.length; i++) {
          var item = SuggestionModel(title: businessList![i].name!.trim(),subTitle: businessList![i].address1.toString());
          businessStringList.add(item);
        }
        if(isEmptyTextFieldValue){
          return businessStringList;
        }
        else {
          return businessStringList.where((business) =>
              business.title.toLowerCase().startsWith(value!.text.toLowerCase()));
        }
      }
    }
    else {
      if (causesList!.isNotEmpty) {
        for (int i = 0; i < causesList!.length; i++) {
          var item = SuggestionModel(title: causesList![i].name!);
          causesStringList.add(item);
        }
        if(isEmptyTextFieldValue){
          return causesStringList;
        }
        else {
          return causesStringList.where((causes) =>
              causes.title.toLowerCase().startsWith(value!.text.toLowerCase()));
        }
      }
    }
    return [];
  }

  onCauseCompletePress(SuggestionModel value) {
    selectedCourse.value = value.title;
    for (var item in causesList!) {
      if (item.name == value.title) {
        selectedCauseId.value = item.id!;
      }
    }
    dismissKeyboard();
}

   onBusinessCompletePress(SuggestionModel value) {
    selectedBusiness.value = value.title;
    List<String> _businessSplitValue = value.toString().split(' - ');
    String _businessName = _businessSplitValue[0];
    causesList?.clear();
    for (var item in businessList!) {
      if (item.name == _businessName) {
        selectedBusinessId.value = item.id!;
        getCauses(selectedBusinessId.value);
        log('selectedBusinessId.value: ${selectedBusinessId.value}');
        return;
      }
      update();
    }
    dismissKeyboard();
   }
}