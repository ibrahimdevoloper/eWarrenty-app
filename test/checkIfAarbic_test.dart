import 'package:ewarrenty/Function/checkIfArabic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'check if a string has arabic characters while the text has arabic characters',
      () {
    final testText = "إبراهيم طارق شغليل";

    expect(checkIfTextInArabic(testText), true);
  });
  test(
      'check if a string has arabic characters while the text has English characters',
      () {
    final testText = "Ibrahim tarek Shaglil";

    expect(checkIfTextInArabic(testText), false);
  });
  test(
      'check if a string has arabic characters while the text has both English and arabic characters',
      () {
    final testText = " Shaglil إبراهيم طارق شغليل";

    expect(checkIfTextInArabic(testText), true);
  });
}
