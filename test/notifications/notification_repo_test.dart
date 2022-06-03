import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/model/contributions.dart';
import 'package:flutter_app/model/notification.dart';
import 'package:flutter_app/network/remote_repositories/notification_repository.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  /// this is required to inject the Remote dependencies
  setUpAll(() {
    dependencyInjectionSetUp();
  });

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

    /// NOTE : Failed don't test this yet in
    test('Create Contribution', () async {
      var result = await NotificationRepository.createContribution({
        Strings.uploadId:
            'eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBFZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19',
        Strings.businessId: 2,
        Strings.causeId: 8,
        Strings.rating: 3,
        Strings.firstPurchase: '1234',
      });
      expect(true, result != null);
    },);
  });
}
