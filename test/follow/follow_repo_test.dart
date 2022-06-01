import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/model/follows.dart';
import 'package:flutter_app/network/remote_repositories/follows_repository.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  /// this is required to inject the Remote dependencies
  setUpAll(() {
    dependencyInjectionSetUp();
  });

  group('Follows', () {
    test('Fetch Follows', () async {
      Follows? follows = await FollowsRemoteRepository.fetchFollows();

      expect(
        true,
        (follows?.businesses?.isNotEmpty ?? false) &&
            (follows?.causes?.isNotEmpty ?? false) &&
            (follows?.organizations?.isNotEmpty ?? false),
      );
    });
  });
}
