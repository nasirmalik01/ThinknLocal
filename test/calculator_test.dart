import 'package:flutter_test/flutter_test.dart';

import 'calculator.dart';

void main() {
  test('Lets test addition', () {

    Calculator calculator = Calculator();
    
    int result = calculator.add(3, 3);
    
    expect(result, 6);
    
    expect(result, isNot(10));
  });

  test('Lets test Subtraction', () {

    Calculator calculator = Calculator();

    int result = calculator.sub(3, 3);

    expect(result, 0);

    expect(result, isNot(1));
  });
}