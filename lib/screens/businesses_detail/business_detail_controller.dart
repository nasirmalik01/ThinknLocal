import 'package:flutter_app/model/business_detail.dart';
import 'package:flutter_app/model/dummy/business_stats.dart';
import 'package:flutter_app/network/remote_repository.dart';
import 'package:get/get.dart';

class BusinessDetailController extends GetxController{
  late BusinessDetail businessDetail;
  late BusinessStats businessStats;
  RxBool isLoading = false.obs;
  RxBool isStatsLoading = false.obs;

  getBusinessDetails({required int id}) async {
    isLoading.value = true;
    businessDetail = (await RemoteRepository.fetchBusinessDetails(id, {}))!;
    isLoading.value = false;
  }

  getBusinessStats({required int id}) async {
    isStatsLoading.value = true;
    businessStats = (await RemoteRepository.fetchBusinessStats(id, {}))!;
    isStatsLoading.value = false;
  }


}