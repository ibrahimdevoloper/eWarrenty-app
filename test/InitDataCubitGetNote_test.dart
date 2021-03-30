import 'package:ewarrenty/Blocs/InitData/init_data_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('check if the user entered only carNote ', () {
    InitDataCubit cubit = InitDataCubit();
    cubit.notesCarName = "Skoda";
    cubit.getNote();
    expect(cubit.notes, "\nCar Name: Skoda\n");
  });
  test('check if the user entered only MarketAddressNote ', () {
    InitDataCubit cubit = InitDataCubit();
    cubit.notesMarketAddress = "Skoda";
    cubit.getNote();
    expect(cubit.notes, null);
  });
  test('check if the user entered only MarketNameNote ', () {
    InitDataCubit cubit = InitDataCubit();
    cubit.notesMarketName = "Skoda";
    cubit.getNote();
    expect(cubit.notes, null);
  });
  test('check if the user entered both MarketNameNote and MarketAddressNote',
      () {
    InitDataCubit cubit = InitDataCubit();
    cubit.notesMarketName = "Skoda";
    cubit.notesMarketAddress = "Skoda";
    cubit.getNote();
    expect(
        cubit.notes,
        "\nMarket Name: ${cubit.notesMarketName}\n" +
            "\nMarket Address: ${cubit.notesMarketAddress}\n");
  });
  test(
      'check if the user entered all MarketNameNote and MarketAddressNote and carNote',
      () {
    InitDataCubit cubit = InitDataCubit();
    cubit.notesCarName = "Skoda";
    cubit.notesMarketName = "Skoda";
    cubit.notesMarketAddress = "Skoda";
    cubit.getNote();
    expect(
        cubit.notes,
        "\nCar Name: ${cubit.notesMarketName}\n" +
            "\nMarket Name: ${cubit.notesMarketName}\n" +
            "\nMarket Address: ${cubit.notesMarketAddress}\n");
  });
  // test('check if the user didn\'t enter any car details', () {
  //   InitDataCubit cubit = InitDataCubit();
  //   expect(cubit.checkCarValidation(), false);
  // });
  // test('check if the user enter both car details', () {
  //   InitDataCubit cubit = InitDataCubit();
  //   cubit.notesCarName = "Skoda";
  //   cubit.carTypeId = 1;
  //   expect(cubit.checkCarValidation(), true);
  // });
}
