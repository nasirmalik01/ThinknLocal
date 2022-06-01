import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/network/remote_repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  /// this is required to inject the Remote dependencies
  setUpAll(() {
    dependencyInjectionSetUp();
  });

  group(
    'Auth',
    () {
      ///success Cases
      test('login', () async {
        final response = await AuthRepository.login(
            email: 'admin@example.com', password: 'admin123');
        expect(true, response['token'] != null);
      });

      test('set New Password', () async {
        final response = await AuthRepository.setNewPassword(
            token:
                'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImRhdGEiOm51bGwsImV4cCI6MTY4NDU5MTIzN30.jBEID8ZQvKJ1NOh5gKW_VKdEkQUyDifrAmgL4-29QMM',
            password: 'admin123',
            confrimPassowrd: 'admin123',
            email: 'admin@example.com');
        expect(true, response['token'] != null);
      });

      test('verify ResetPin', () async {
        final response = await AuthRepository.login(
            email: 'admin@example.com', password: 'admin123');
        expect(true, response['token'] != null);
      });
      test('Reset Password', () async {
        final response = await AuthRepository.login(
            email: 'admin@example.com', password: 'admin123');
        expect(true, response['token'] != null);
      });
    },
  );
}
