import 'package:flutter/material.dart';
import 'package:flutter_app/screens/on_boarding_page/on_boarding_page.dart';
import 'package:flutter_app/screens/sign_in/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SignIn signIn;

  setUp(() {
    signIn = const SignIn();
  });

  group("OnBoarding Screen testing", () {
    testWidgets("OnBoarding Page Widgets test", (WidgetTester tester) async {

      var PageWidget = find.byKey(const ValueKey("onBoardingPageSettingWidget"));
      await tester.pumpWidget(const MaterialApp(
          home: OnBoardingPage()));
      await tester.tap(PageWidget);
      await tester.pump();

      expect(find.text('Welcome!'),findsOneWidget);



    });
  });
}