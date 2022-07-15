import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/enums/first_time_visit.dart';
import 'package:thinknlocal_app/model/businesses.dart';
import 'package:thinknlocal_app/model/causes.dart';
import 'package:thinknlocal_app/network/remote_repositories/business_repository.dart';
import 'package:thinknlocal_app/network/remote_repositories/cause_repository.dart';
import 'package:thinknlocal_app/network/remote_services.dart';

class SuggestionModel {
  int id;
  String title;
  String? subTitle;

  SuggestionModel({required this.id, required this.title, this.subTitle});
}

class AboutVisitController extends GetxController {
  Rx<IsFirstTime> isVisitFirstTime = IsFirstTime.nothing.obs;
  RxInt selectedCauseId = 0.obs;
  RxInt selectedBusinessId = 0.obs;
  RxList<Causes>? causesList = <Causes>[].obs;
  List<Businesses>? businessList = [];
  RxBool isCausesLoading = false.obs;
  RxBool isBusinessLoading = false.obs;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;

  ///these will help in suggestions
  List<SuggestionModel> causesSuggestionList = [];
  List<SuggestionModel> businessSuggestionList = <SuggestionModel>[];

  changeFirstTimeVisit({bool isFirst = false}) {
    isVisitFirstTime.value = isFirst
        ? IsFirstTime.yes
        : !isFirst
            ? IsFirstTime.no
            : IsFirstTime.nothing;
  }

  getCauses(Map<String, dynamic> query) async {
    causesList?.clear();
    causesList!.value = (await (CausesRemoteRepository.fetchCauses({
      Strings.businessId: query['businessId'],
      Strings.active: true,
      'q': query['q']
    })))!;
    log('Final Result : ${causesList?.length}');
    if (RemoteServices.statusCode != 200 &&
        RemoteServices.statusCode != 201 &&
        RemoteServices.statusCode != 204) {
      isError.value = true;
      isCausesLoading.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
  }

  getBusinesses(Map<String, dynamic> query) async {
    businessList = await (BusinessRemoteRepository.fetchBusinesses(query));
    if (RemoteServices.statusCode != 200 &&
        RemoteServices.statusCode != 201 &&
        RemoteServices.statusCode != 204) {
      isError.value = true;
      isBusinessLoading.value = false;
      errorMessage.value = RemoteServices.error;
      return;
    }
  }

  addBusinessesToSuggestionList() {
    if (businessList!.isNotEmpty) {
      businessSuggestionList.clear();

      for (int i = 0; i < businessList!.length; i++) {
        var item = SuggestionModel(
            id: businessList![i].id!,
            title: businessList![i].name!.trim(),
            subTitle: businessList![i].address1.toString());
        businessSuggestionList.add(item);
      }
    }
  }

  Future<Iterable<SuggestionModel>> setOptionsBuilder(
      {TextEditingValue? value,
      bool isBusiness = false,
      bool isEmptyTextFieldValue = false}) async {
    if (isBusiness) {
      if (!isEmptyTextFieldValue) {
        await getBusinesses({'q': value!.text.toLowerCase(), 'active': true});
      } else {
        await getBusinesses({'active': true});
      }

      addBusinessesToSuggestionList();
      return businessSuggestionList;
    } else {
      if (!isEmptyTextFieldValue) {
        await getCauses({
          'q': value!.text.toLowerCase(),
          'businessId': selectedBusinessId.value
        });
      } else {
        await getCauses({'businessId': selectedBusinessId.value});
      }

      addItemIntoSugCausesList();
      return causesSuggestionList;
    }
  }

  void addItemIntoSugCausesList() {
    causesSuggestionList.clear();
    for (int i = 0; i < causesList!.length; i++) {
      var item = SuggestionModel(
          id: causesList![i].id!,
          title: causesList![i].name!,
          subTitle: causesList![i].organization!.name);
      causesSuggestionList.add(item);
    }
  }

  onCauseCompletePress(SuggestionModel value) {
    selectedCauseId.value = value.id;
    dismissKeyboard();
  }

  onBusinessCompletePress(SuggestionModel value) {
    dismissKeyboard();
    selectedBusinessId.value = value.id;
    getCauses({'businessId': value.id});
  }
}
