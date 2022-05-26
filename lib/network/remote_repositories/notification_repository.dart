import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/api_endpoints.dart';
import 'package:flutter_app/model/contributions.dart';
import 'package:flutter_app/model/contributions_direct_upload.dart';
import 'package:flutter_app/model/notification.dart';
import 'package:flutter_app/network/remote_services.dart';

class NotificationRepository {
  static Future<List<Contributions>?> fetchContributions(
      Map<String, dynamic> query) async {
    List<Contributions> contributionsList = [];
    final response = await getItLocator<RemoteServices>()
        .getRequest(ApiEndPoints.contributions, query);
    if (response == null) {
      return null;
    }
    final List<dynamic> _contributionsDecodeList =
        response.map((item) => Contributions.fromJson(item)).toList();
    for (var contributionItem in _contributionsDecodeList) {
      contributionsList.add(contributionItem);
    }
    return contributionsList;
  }

  static Future<UploadDirectContributions?> uploadContributions(
      Map<String, dynamic> query,
      {void Function(int, int)? uploadFile}) async {
    final response = await getItLocator<RemoteServices>().postRequest(
      ApiEndPoints.uploadContributions,
      query,
      uploadFile: uploadFile,
    );

    if (response == null) {
      return null;
    }

    UploadDirectContributions _uploadDirectContributions =
        UploadDirectContributions.fromJson(response);
    return _uploadDirectContributions;
  }

  static Future<dynamic> createContribution(Map<String, dynamic> query) async {
    final response = await getItLocator<RemoteServices>()
        .postRequest(ApiEndPoints.contributions, query);

    if (response == null) {
      return;
    }

    return response;
  }

  static Future<List<Notification>?> getNotifications(
      Map<String, dynamic> query) async {
    final response = await getItLocator<RemoteServices>()
        .getRequest(ApiEndPoints.notifications, query);
    List<Notification> _notificationList = [];

    if (response == null) {
      return null;
    }

    final List<dynamic> _notificationsDecodeList =
        response.map((item) => Notification.fromJson(item)).toList();
    for (var notification in _notificationsDecodeList) {
      _notificationList.add(notification);
    }
    return _notificationList;
  }
}
