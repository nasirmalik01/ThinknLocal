import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/model/follows.dart';
import 'package:thinknlocal_app/network/remote_repositories/follows_repository.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  /// this is required to inject the Remote dependencies
  setUpAll(() {
    dependencyInjectionSetUp();
  });

  group('Follows', () {

    /// Success case
    test('Fetch Follows', () async {
      Follows? follows = await FollowsRemoteRepository.fetchFollows();
      expect(true, follows?.businesses?.isNotEmpty);
      expect(true, follows?.causes?.isNotEmpty);
      expect(true, follows?.organizations?.isNotEmpty);
    });

    /// Failure case
    test('Fetch Follows', () async {
      Follows? follows = await FollowsRemoteRepository.fetchFollows();
      expect(false, follows?.businesses?.isEmpty);
      expect(false, follows?.causes?.isEmpty);
      expect(false, follows?.organizations?.isEmpty);
    });
  });
}
