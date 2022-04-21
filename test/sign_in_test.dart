import 'package:flutter/material.dart';
import 'package:flutter_app/screens/sign_in/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group("SignIn screen test", () {
    testWidgets("Lets test Button", (WidgetTester tester) async {

      var button = find.byKey(const ValueKey("Main button"));
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      await tester.tap(button);
      await tester.pump();

      expect(find.text('Sign In'),findsOneWidget);


    });
  });
}