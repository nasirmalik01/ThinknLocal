import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/model/account.dart';
import 'package:flutter_app/network/remote_repositories/profile_repository.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  setUpAll(() {
    dependencyInjectionSetUp();
  });

  test('user profile data shouldn\'t be null', () async {
    Account? _response = await ProfileRemoteRepository.fetchProfileInfo({});
    expect(true, _response != null);
  });
}
