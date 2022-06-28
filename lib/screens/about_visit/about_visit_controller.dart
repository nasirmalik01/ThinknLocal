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

class AboutVisitController extends GetxController {
  Rx<IsFirstTime> isVisitFirstTime = IsFirstTime.nothing.obs;
  RxString selectedBusiness = ''.obs;
  RxString selectedCourse = ''.obs;
  RxInt selectedCauseId = 0.obs;
  RxInt selectedBusinessId = 0.obs;
  List<Causes>? causesList = [];
  List<Businesses>? businessList = [];
  RxBool isCausesLoading = false.obs;
  RxBool isBusinessLoading = false.obs;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;


  changeFirstTimeVisit({bool isFirst = false}) {
    isVisitFirstTime.value = isFirst ? IsFirstTime.yes : !isFirst ? IsFirstTime.no : IsFirstTime.nothing;
  }

  @override
  void onInit() {
    getBusinesses();
    super.onInit();
  }

  getCauses(int businessId) async {
    causesList = await (CausesRemoteRepository.fetchCauses({
      Strings.businessId: businessId
    }));
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

  Iterable<String> setOptionsBuilder({TextEditingValue? value, bool isBusiness = false, bool isEmptyTextFieldValue = false}) {
    List<String> causesStringList = [];
    List<String> businessStringList = [];

    if (isBusiness) {
      if (businessList!.isNotEmpty) {
        for (int i = 0; i < businessList!.length; i++) {
          businessStringList.add(businessList![i].name!);
        }
        if(isEmptyTextFieldValue){
          return businessStringList;
        }
        else {
          return businessStringList.where((business) =>
              business.toLowerCase().startsWith(value!.text.toLowerCase()));
        }
      }
    }
    else {
      if (causesList!.isNotEmpty) {
        for (int i = 0; i < causesList!.length; i++) {
          causesStringList.add(causesList![i].name!);
        }
        if(isEmptyTextFieldValue){
          return causesStringList;
        }
        else {
          return causesStringList.where((causes) =>
              causes.toLowerCase().startsWith(value!.text.toLowerCase()));
        }
      }
    }
    return [];
  }

  onCauseCompletePress(value) {
    selectedCourse.value = value;
    for (var item in causesList!) {
      if (item.name == value) {
        selectedCauseId.value = item.id!;
      }
    }
    dismissKeyboard();
  }

   onBusinessCompletePress(value) {
    selectedBusiness.value = value;
    for (var item in businessList!) {
      if (item.name == value) {
        selectedBusinessId.value = item.id!;
        getCauses(selectedBusinessId.value);
        log('selectedBusinessId.value: ${selectedBusinessId.value}');
      }
    }
    dismissKeyboard();
   }

}
