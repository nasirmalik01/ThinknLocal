import 'package:flutter_test/flutter_test.dart';

import 'calculator.dart';

void main() {
  late Calculator calculator;
  setUpAll(() {
    calculator = Calculator();
  });
  
  group("I want to test my calculator", () {
    test('Lets test addition', () {

      int result = calculator.add(3, 3);

      expect(result,6);

      expect(result, isNot(10));
    });

    test('Lets test Subtraction', () {


      int result = calculator.sub(3, 3);

      expect(result, 0);

      expect(result, isNot(1));
    });
  });

  tearDownAll(() {
    // print('Calculator tests completed');
  });
}