import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/model/account.dart';
import 'package:flutter_app/network/remote_repositories/profile_repository.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  setUpAll(() {
    dependencyInjectionSetUp();
  });

  test('user profile data should not be null', () async {
    Account? _response = await ProfileRemoteRepository.fetchProfileInfo({});
    expect(true, _response != null);
  });

  test('Edit account settings', () async {
    Account? _response = await ProfileRemoteRepository.editAccountInfo({
      Strings.firstName: 'Admin',
      Strings.lastName: 'User',
      Strings.email: 'admin@example.com',
      Strings.zip: '33333',
      Strings.groupCode: '45',
    });
    expect(true, _response != null);
  });
}
