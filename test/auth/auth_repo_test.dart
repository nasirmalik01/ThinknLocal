import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/network/remote_repositories/auth_repository.dart';
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
      test('Request reset password', () async {
        final response = await AuthRepository.login(email: 'admin@example.com', password: 'admin123');
        expect(true, response != null);
        /// It only returns 200 status code so we are only testing response here
      });

      test('Verify ResetPin', () async {
        final response = await AuthRepository.verifyResetPin(email: 'admin@example.com', pin: '374101');
        expect(true, response['token'] != null);
        expect(true, response.resetToken != null);
      });

      test('Set New Password', () async {
        final response = await AuthRepository.setNewPassword(
            token: 'BAh7CEkiCGdpZAY6BkVUSSIfZ2lkOi8vdGhpbmtubG9jYWwvVXNlci8xMTIGOwBUSSIMcHVycG9zZQY7AFRJIhNwYXNzd29yZF9yZXNldAY7AFRJIg9leHBpcmVzX2F0BjsAVEkiHTIwMjItMDctMDZUMTA6NDM6MTUuNzU5WgY7AFQ=--45317b802b81caac13bb673d9b89495314c26c0a',
            password: '112233',
            confirmPassowrd: '112233',
            email: 'admin@example.com');

        expect(true, response['token'] != null);
        expect(true, response.email == 'admin@example.com');
        expect(true, response.firstName == 'Admin');
        expect(true, response.lastName == 'User');
      });

      /// Failure cases
      test('Request reset password', () async {
        final response = await AuthRepository.login(email: 'admin@example.com', password: 'admin123');
        expect(false, response == null);
        /// It only returns 200 status code so we are only testing response here
      });

      test('Verify ResetPin', () async {
        final response = await AuthRepository.verifyResetPin(email: 'admin@example.com', pin: '374101');
        expect(false, response['token'] == null);
        expect(false, response.resetToken == null);
      });

      test('Set New Password', () async {
        final response = await AuthRepository.setNewPassword(
            token: 'BAh7CEkiCGdpZAY6BkVUSSIfZ2lkOi8vdGhpbmtubG9jYWwvVXNlci8xMTIGOwBUSSIMcHVycG9zZQY7AFRJIhNwYXNzd29yZF9yZXNldAY7AFRJIg9leHBpcmVzX2F0BjsAVEkiHTIwMjItMDctMDZUMTA6NDM6MTUuNzU5WgY7AFQ=--45317b802b81caac13bb673d9b89495314c26c0a',
            password: '112233',
            confirmPassowrd: '112233',
            email: 'admin@example.com');

        expect(false, response['token'] == null);
        expect(false, response.email != 'admin@example.com');
        expect(false, response.firstName != 'Admin');
        expect(false, response.lastName != 'User');
      });
    },
  );
}
