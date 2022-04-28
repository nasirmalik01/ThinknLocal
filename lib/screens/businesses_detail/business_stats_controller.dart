import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_app/model/business_stats.dart';
import 'package:flutter_app/network/remote_repository.dart';
import 'package:get/get.dart';

class BusinessStatsController extends GetxController{
  late BusinessStats businessStats;
  RxBool isLoading = false.obs;
  List<BarChartGroupData> barChartList = [];



  @override
  void onInit() {
    getBusinessStats();
    super.onInit();
  }

  getBusinessStats() async {
    isLoading.value = true;
    businessStats = (await RemoteRepository.fetchBusinessStats({}))!;
    isLoading.value = false;
  }
}