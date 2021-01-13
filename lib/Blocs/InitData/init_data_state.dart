part of 'init_data_cubit.dart';

@immutable
abstract class InitDataState {
  const InitDataState();
}

class InitDataInitial extends InitDataState {
  const InitDataInitial();
}

class InitDataLoading extends InitDataState {
  InitDataLoading();
}

class InitDataLoaded extends InitDataState {
  final List<Battery> batteries;
  final List<CarType> carTypes;
  final List<CarProperty> carProperties;
  final List<Market> markets;

  InitDataLoaded(
      this.batteries, this.carTypes, this.carProperties, this.markets);


}

class InitDataError extends InitDataState {
  final String messageEn;
  final String messageAr;

  InitDataError(this.messageEn, this.messageAr);
}

class InitDataBillDate extends InitDataState {
  final String billDate;

  InitDataBillDate(this.billDate);
}

class InitDataBatteryChosen extends InitDataState {
  final Battery battery;

  InitDataBatteryChosen(this.battery);
}

class InitDataFrontBatteryImage extends InitDataState {
  final String imagePath;

  InitDataFrontBatteryImage(this.imagePath);
}
class InitDataFixedBatteryImage extends InitDataState {
  final String imagePath;

  InitDataFixedBatteryImage(this.imagePath);
}
class InitDataCarNumber extends InitDataState {
  final String imagePath;

  InitDataCarNumber(this.imagePath);
}
