import 'package:flutter_app/model/business_stats.dart';
import 'package:flutter_app/network/remote_repository.dart';
import 'package:get/get.dart';

class BusinessDetailController extends GetxController{
  late BusinessStats businessStats;
  RxBool isLoading = false.obs;


  getBusinessStats() async {
    isLoading.value = true;
    businessStats = (await RemoteRepository.fetchBusinessStats({}))!;
    isLoading.value = false;
  }


}