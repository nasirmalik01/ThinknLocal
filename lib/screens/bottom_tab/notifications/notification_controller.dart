import 'package:flutter_app/model/contributions.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController{
  RxBool isNotificationsLoading = false.obs;
  List<Contributions>? contributionsList = [];

  @override
  void onInit() {
    getContributions();
    super.onInit();
  }

  getNotifications(){}

  // For pending and sent receipts
  getContributions() async {
    isNotificationsLoading.value = true;
    // contributionsList = await RemoteRepository.fetchContributions({});
    isNotificationsLoading.value = false;
  }
}