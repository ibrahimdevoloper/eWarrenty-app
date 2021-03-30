import 'package:ewarrenty/Blocs/InitData/init_data_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('check if the user entered only carId ', () {
    InitDataCubit cubit = InitDataCubit();
    cubit.carTypeId = 1;
    expect(cubit.checkCarValidation(), true);
  });
  test('check if the user entered only carNote ', () {
    InitDataCubit cubit = InitDataCubit();
    cubit.notesCarName = "Skoda";
    expect(cubit.checkCarValidation(), true);
  });
  test('check if the user didn\'t enter any car details', () {
    InitDataCubit cubit = InitDataCubit();
    expect(cubit.checkCarValidation(), false);
  });
  test('check if the user enter both car details', () {
    InitDataCubit cubit = InitDataCubit();
    cubit.notesCarName = "Skoda";
    cubit.carTypeId = 1;
    expect(cubit.checkCarValidation(), true);
  });
}
