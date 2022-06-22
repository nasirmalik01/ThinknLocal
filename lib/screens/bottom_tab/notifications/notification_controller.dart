import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/model/contributions.dart';
import 'package:flutter_app/model/notification.dart';
import 'package:flutter_app/network/remote_repositories/notification_repository.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationController extends GetxController{
  RxBool isNotificationsLoading = false.obs;
  RxBool isContributionLoading = false.obs;
  List<Contributions>? contributionsList = [];
  List<Notification>? notificationList = [];
  List<Notification>? notificationUnreadList = [];
  List<Contributions>? pendingContributionsList = [];
  List<Contributions>? approvedContributionsList = [];
  List<Contributions>? deniedContributionsList = [];
  @override
  void onInit() {
    getNotifications();
    getContributions();
    super.onInit();
  }

  getNotifications() async {
    isNotificationsLoading.value = true;
    notificationList?.clear();
    notificationList = await NotificationRepository.getNotifications({});
    isNotificationsLoading.value = false;
  }

  /// For pending and sent receipts
  getContributions() async {
    isContributionLoading.value = true;
    contributionsList = await NotificationRepository.fetchContributions({});
    pendingContributionsList = contributionsList?.where((e) => e.status == "pending").toList();
    approvedContributionsList = contributionsList?.where((e) => e.status == "approved").toList();
    deniedContributionsList = contributionsList?.where((e) => e.status == "denied").toList();
    isContributionLoading.value = false;
  }

  String getTime(String dateTime) {
    DateTime input =
    DateFormat('yyyy-MM-DDTHH:mm:ss.SSSSSSZ').parse(dateTime, true);
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return '${diff.inDays}d${diff.inDays == 1 ? '' : ''} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours}h${diff.inHours == 1 ? '' : ''} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes}m${diff.inMinutes == 1 ? '' : ''} ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds}s${diff.inSeconds == 1 ? '' : ''} ago';
    } else {
      return 'just now';
    }
  }

  markNotificationAsRead(int id) async {
    isNotificationsLoading.value = true;
    await getItLocator<RemoteServices>().postRequest('${ApiEndPoints.notifications}/$id/${ApiEndPoints.read}', {}) ;
  }

  markNotificationAsUnRead(int id) async {
    isNotificationsLoading.value = true;
    await getItLocator<RemoteServices>().postRequest('${ApiEndPoints.notifications}/$id/${ApiEndPoints.unread}', {}) ;
  }
}