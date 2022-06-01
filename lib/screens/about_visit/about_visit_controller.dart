import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/config/aws_response.dart';
import 'package:flutter_app/config/aws_service.dart';
import 'package:flutter_app/model/businesses.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/network/remote_repositories/business_repository.dart';
import 'package:flutter_app/network/remote_repositories/cause_repository.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';

class AboutVisitController extends GetxController {
  RxBool isVisitFirstTime = true.obs;
  RxString selectedBusiness = ''.obs;
  RxString selectedCourse = ''.obs;
  RxInt selectedCourseId = 0.obs;
  RxInt selectedBusinessId = 0.obs;
  List<Causes>? causesList = [];
  List<Businesses>? businessList = [];
  RxBool isCausesLoading = false.obs;
  RxBool isBusinessLoading = false.obs;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;


  changeFirstTimeVisit() {
    isVisitFirstTime.value = !isVisitFirstTime.value;
  }

  @override
  void onInit() {
    getCauses();
    getBusinesses();
    super.onInit();
  }

  getCauses() async {
    isCausesLoading.value = true;
    causesList = await (CausesRemoteRepository.fetchCauses({}));
    if (RemoteServices.statusCode != 200 &&
        RemoteServices.statusCode != 201 &&
        RemoteServices.statusCode != 204) {
      isError.value = true;
      isCausesLoading.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
    isCausesLoading.value = false;
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

  Iterable<String> setOptionsBuilder(TextEditingValue value,
      {bool isBusiness = false}) {
    if (value.text.isEmpty) {
      return [];
    }
    List<String> causesStringList = [];
    List<String> businessStringList = [];

    if (isBusiness) {
      if (businessList!.isNotEmpty) {
        for (int i = 0; i < businessList!.length; i++) {
          businessStringList.add(businessList![i].name!);
        }
        return businessStringList.where((business) =>
            business.toLowerCase().startsWith(value.text.toLowerCase()));
      }
    } else {
      if (causesList!.isNotEmpty) {
        for (int i = 0; i < causesList!.length; i++) {
          causesStringList.add(causesList![i].name!);
        }
        return causesStringList.where((causes) =>
            causes.toLowerCase().startsWith(value.text.toLowerCase()));
      }
    }

    return [];
  }

  onCauseCompletePress(value) {
    selectedCourse.value = value;
    for (var item in causesList!) {
      if (item.name == value) {
        selectedCourseId.value = item.id!;
      }
    }
  }

   onBusinessCompletePress(value) {
    selectedBusiness.value = value;
    for (var item in businessList!) {
      if (item.name == value) {
        selectedBusinessId.value = item.id!;
      }
    }
  }

}
