import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/model/account.dart';
import 'package:thinknlocal_app/network/remote_repositories/profile_repository.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  setUpAll(() {
    dependencyInjectionSetUp();
  });

  test('user profile data should not be null', () async {
    Account? _response = await ProfileRemoteRepository.fetchProfileInfo({});
    expect(true, _response != null);
    expect(1, _response!.id);
    expect('Admin', _response.firstName);
    expect('User', _response.lastName);
    expect('admin@example.com', _response.email);
  });

  test('Edit account settings', () async {
    Account? _response = await ProfileRemoteRepository.editAccountInfo({
      Strings.firstName: 'Nasir',
      Strings.lastName: 'Mehmood',
      Strings.email: 'nasir@example.com',
      Strings.zip: '33333',
      Strings.groupCode: '45',
    });
    expect(true, _response != null);
    expect(1, _response!.id);
    expect('Nasir', _response.firstName);
    expect('Mehmood', _response.lastName);
    expect('nasir@example.com', _response.email);
  });
}
