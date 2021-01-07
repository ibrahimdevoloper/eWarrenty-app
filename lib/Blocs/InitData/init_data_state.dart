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
  final List<CarProperty> CarProperties;
  final List<Market> markets;

  InitDataLoaded(
      this.batteries, this.carTypes, this.CarProperties, this.markets);
}

class InitDataError extends InitDataState {
  InitDataError();
}
