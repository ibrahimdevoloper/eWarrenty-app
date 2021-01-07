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
