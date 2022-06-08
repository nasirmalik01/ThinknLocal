import 'package:flutter/material.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/screens/sign_in/login_controller.dart';
import 'package:flutter_app/screens/sign_in/login_screen.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  final LogInController _logInController = Get.put(LogInController());

  group("Login UI Testing", () {
    testWidgets("Login Screen Widgets Testing", (WidgetTester tester) async {
      await tester.pumpWidget(Sizer(
        builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
          return GetMaterialApp(
              builder: (BuildContext context, child){
                initializeResources(context: context);
                final mediaQueryData = MediaQuery.of(context);
                final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.07);
                return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
                    child: child!);
              },
              home: LoginScreen());
        },
      ));

      /// Checking all the texts
      expect(find.text(Strings.forgotPassword),findsOneWidget);
      expect(find.text(Strings.orContinueWith),findsOneWidget);
      expect(find.text(Strings.resetIt),findsOneWidget);
      expect(find.text(Strings.didNotHaveAccount),findsOneWidget);
      expect(find.text(Strings.register),findsOneWidget);

      /// Checking the text fields - email and password
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byKey(const ValueKey(Strings.emailTextField)), findsOneWidget);
      expect(find.byKey(const ValueKey(Strings.passwordTextField)), findsOneWidget);

      /// Checking the sign in button
      expect(find.byType(Button), findsOneWidget);

      /// Initialization
      Finder emailTextField = find.byKey(const ValueKey(Strings.emailTextField));
      Finder passwordTextField = find.byKey(const ValueKey(Strings.passwordTextField));
      Finder signInButton = find.byKey(const ValueKey(Strings.signInKeyButton));

      /// Checking that text fields are empty or not
      await tester.enterText(emailTextField, '');
      await tester.enterText(passwordTextField, '');
      await tester.tap(signInButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(true, _logInController.isEmptyTextFieldValues.value);

      /// Checking that password length should not be less than the required
      await tester.enterText(emailTextField, 'admin@example.com');
      await tester.enterText(passwordTextField, '123');
      await tester.tap(signInButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(true, _logInController.isPasswordShort.value);
    });
  });
}

