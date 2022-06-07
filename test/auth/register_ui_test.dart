import 'package:flutter/material.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/screens/sign_up/sign_up.dart';
import 'package:flutter_app/screens/sign_up/sign_up_controller.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  final SignUpController _signUpController = Get.put(SignUpController());

  group("Register UI Testing", () {
    testWidgets("Register Screen Widgets Testing", (WidgetTester tester) async {
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
              home: SignUpScreen());
        },
      ));

      /// Checking all the texts
      expect(find.text(Strings.alreadyAnAccount),findsOneWidget);
      expect(find.text(Strings.signIn),findsOneWidget);
      expect(find.text(Strings.partOfClubOrGroup),findsOneWidget);

      /// Checking the text fields
      expect(find.byType(TextField), findsNWidgets(7));
      expect(find.byKey(const ValueKey(Strings.firstName)), findsOneWidget);
      expect(find.byKey(const ValueKey(Strings.lastName)), findsOneWidget);
      expect(find.byKey(const ValueKey(Strings.email)), findsOneWidget);
      expect(find.byKey(const ValueKey(Strings.password)), findsOneWidget);
      expect(find.byKey(const ValueKey(Strings.passwordConfirmation)), findsOneWidget);
      expect(find.byKey(const ValueKey(Strings.zip)), findsOneWidget);
      expect(find.byKey(const ValueKey(Strings.groupCode)), findsOneWidget);

      /// Checking the sign up button
      expect(find.byType(Button), findsOneWidget);

      /// Initialization
      Finder firstNameText = find.byKey(const ValueKey(Strings.firstName));
      Finder lastNameTextField = find.byKey(const ValueKey(Strings.lastName));
      Finder emailTextField = find.byKey(const ValueKey(Strings.email));
      Finder passwordTextField = find.byKey(const ValueKey(Strings.password));
      Finder passwordConfirmationTextField = find.byKey(const ValueKey(Strings.passwordConfirmation));
      Finder zipTextField = find.byKey(const ValueKey(Strings.zip));
      Finder signUpButton = find.byKey(const ValueKey(Strings.signUpKeyButton));

      Future<void> buttonTap() async {
        await tester.ensureVisible(find.byKey(const ValueKey(Strings.signUpKeyButton)));
        await tester.pumpAndSettle();
        await tester.tap(signUpButton);
        await tester.pumpAndSettle(const Duration(seconds: 2));
      }

      Future<void> setTextFieldValues({
        required String firstName,
        required String lastName,
        required String email,
        required String password,
        required String confirmPassword,
        required String sipCode,} )
      async {
        await tester.enterText(firstNameText, firstName);
        await tester.enterText(lastNameTextField, lastName);
        await tester.enterText(emailTextField, email);
        await tester.enterText(passwordTextField, password);
        await tester.enterText(passwordConfirmationTextField, confirmPassword);
        await tester.enterText(zipTextField, sipCode);
      }

      /// Checking that text fields are empty or not
      await setTextFieldValues(firstName: '', lastName: '', email: '', password: '', confirmPassword: '', sipCode: '');
      await buttonTap();
      expect(true, _signUpController.isEmptyTextFieldValues.value);

      /// Checking that password length should not be less than the required
      await setTextFieldValues(firstName: 'Admin', lastName: 'User', email: 'admin@example.com', password: '12', confirmPassword: '12', sipCode: '12345');
      await buttonTap();
      expect(true, _signUpController.isShortPassword.value);

      /// Checking that password and confirm password should be the same
      await setTextFieldValues(firstName: 'Admin', lastName: 'User', email: 'admin@example.com', password: '123456', confirmPassword: '123455', sipCode: '12345');
      await buttonTap();
      expect(true, _signUpController.isPasswordNotMatches.value);

      /// Checking that Zip code should not be less than 5
      await setTextFieldValues(firstName: 'Admin', lastName: 'User', email: 'admin@example.com', password: '123456', confirmPassword: '123456', sipCode: '123');
      await buttonTap();
      expect(true, _signUpController.isZipLengthNotFive.value);
    });
  });
}

