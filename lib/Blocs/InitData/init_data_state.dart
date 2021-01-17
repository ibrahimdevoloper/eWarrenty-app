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

// when a date is choosen
class InitDataBillDate extends InitDataState {
  final String billDate;

  InitDataBillDate(this.billDate);
}

// when a battery is choosen
class InitDataBatteryChosen extends InitDataState {
  final Battery battery;

  InitDataBatteryChosen(this.battery);
}

// when a front date battery is choosen
class InitDataFrontBatteryImage extends InitDataState {
  final String imagePath;

  InitDataFrontBatteryImage(this.imagePath);
}

// when a fixed battery image is choosen
class InitDataFixedBatteryImage extends InitDataState {
  final String imagePath;

  InitDataFixedBatteryImage(this.imagePath);
}

// when a car number Image  is choosen
class InitDataCarNumber extends InitDataState {
  final String imagePath;

  InitDataCarNumber(this.imagePath);
}

// to battery choosen field reset
class InitDataBatteryChoosenReset extends InitDataState {
  InitDataBatteryChoosenReset();
}

// to battery choosen field error
class InitDataBatteryChoosenError extends InitDataState {
  InitDataBatteryChoosenError();
}

// reset bill button
class InitDataBillDateReset extends InitDataState {
  InitDataBillDateReset();
}

// reset bill button
class InitDataBillDateError extends InitDataState {
  InitDataBillDateError();
}

// to Serial number field reset
class InitDataSerialNumberReset extends InitDataState {
  InitDataSerialNumberReset();
}

// to Serial number field error
class InitDataSerialNumberError extends InitDataState {
  InitDataSerialNumberError();
}

// to full name field reset
class InitDataFullNameReset extends InitDataState {
  InitDataFullNameReset();
}

// to full name field error
class InitDataFullNameError extends InitDataState {
  InitDataFullNameError();
}

// to Address field reset
class InitDataAddressReset extends InitDataState {
  InitDataAddressReset();
}

// to Address field error
class InitDataAddressError extends InitDataState {
  InitDataAddressError();
}

// to Email field reset
class InitDataEmailReset extends InitDataState {
  InitDataEmailReset();
}

// to Email field error
class InitDataEmailError extends InitDataState {
  InitDataEmailError();
}

// to Phone Number field reset
class InitDataPhoneNumberReset extends InitDataState {
  InitDataPhoneNumberReset();
}

// to Phone Number field error
class InitDataPhoneNumberError extends InitDataState {
  InitDataPhoneNumberError();
}
