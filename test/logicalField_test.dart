import 'package:flutter_test/flutter_test.dart';

void main() {
  test('check if a value between 2 values ', () {
    var value = 0.5;
    var result = false;

    if (value >= 0.3 && value <= 0.6)
      result = true;
    else
      result = false;

    expect(result, true);
  });
}
