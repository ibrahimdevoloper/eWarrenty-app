import 'package:ewarrenty/Function/checkIfCurrentDateIsBeforeDueDate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'check if a date is before current date while the date is after the current date',
      () {
    final testDate = DateTime(2022, DateTime.august, 5);

    expect(checkIfCurrentDateIsBeforeDueDate(testDate), false);
  });
  test(
      'check if a date is before current date while the date is before the current date',
      () {
    final testDate = DateTime(2020, DateTime.august, 5);

    expect(checkIfCurrentDateIsBeforeDueDate(testDate), true);
  });
}
