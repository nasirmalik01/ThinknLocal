import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/screens/sign_in/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SignIn signIn;

  setUp(() {
    signIn = const SignIn();
  });

  group("SignIn screen test", () {
    testWidgets("Lets test signin", (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      var textField = find.byType(TextField);
      
      expect(textField, findsWidgets);
    });
  });
}