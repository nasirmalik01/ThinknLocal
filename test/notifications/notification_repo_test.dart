import 'dart:io';

import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/model/contributions.dart';
import 'package:flutter_app/model/notification.dart';
import 'package:flutter_app/network/remote_repositories/notification_repository.dart';
import 'package:flutter_app/screens/bottom_tab/scan/contribution_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

Future<void> main() async {
  /// this is required to inject the Remote dependencies
  setUpAll(() {
    dependencyInjectionSetUp();
  });
  final ContributionController _contributionController = Get.put(ContributionController());

  group('Notifications', () {
    test('Fetch Contributions', () async {
      List<Contributions>? contributionsList = await NotificationRepository.fetchContributions({});
      expect(true, contributionsList?.isNotEmpty ?? false,
      );
    });

    test('get Notifications', () async {
      List<Notification>? _notificationList = await NotificationRepository.getNotifications({});
      expect(true, _notificationList?.isNotEmpty ?? false);
    });

    test('Upload and create Contribution', () async {
      Map<String, dynamic> _uploadContributionsQuery  = {
        Strings.uploadId: 'eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBFZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19',
        Strings.businessId: 2,
        Strings.causeId: 8,
        Strings.rating: 3,
        Strings.firstPurchase: '1234',
      };

      /// Give file path according to your device
      var result = await _contributionController.uploadAndCreateContributions(_uploadContributionsQuery, File('/storage/emulated0/Download/test.jpg'));
      expect(true, result != null);
    },);

    /// Failure cases
    test('Fetch Contributions', () async {
      List<Contributions>? contributionsList = await NotificationRepository.fetchContributions({});
      expect(false, contributionsList?.isEmpty,
      );
    });

    test('get Notifications', () async {
      List<Notification>? _notificationList = await NotificationRepository.getNotifications({});
      expect(false, _notificationList?.isEmpty);
    });

    test('Upload and create Contribution', () async {
      Map<String, dynamic> _uploadContributionsQuery  = {
        Strings.uploadId: 'eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBFZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19',
        Strings.businessId: 2,
        Strings.causeId: 8,
        Strings.rating: 3,
        Strings.firstPurchase: '1234',
      };

      /// Give file path according to your device
      var result = await _contributionController.uploadAndCreateContributions(_uploadContributionsQuery, File('/storage/emulated0/Download/test.jpg'));
      expect(false, result == null);
    },);

  });
}
