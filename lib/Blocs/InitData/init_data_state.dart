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

// when a battery is choosen for image
class InitDataBatteryChosenForImage extends InitDataState {
  final Battery battery;

  InitDataBatteryChosenForImage(this.battery);
}

// when a battery is choosen for image has an Error like battery not choosen
class InitDataBatteryChosenForImageError extends InitDataState {
  final Battery battery;

  InitDataBatteryChosenForImageError(this.battery);
}

// when a front date battery is choosen
class InitDataFrontBatteryImage extends InitDataState {
  final String imagePath;

  InitDataFrontBatteryImage(this.imagePath);
} // when a front date battery is choosen but the user didn't capture the image

class InitDataFrontBatteryImageErrorWhileBatteyIsNotChoosen
    extends InitDataState {
  InitDataFrontBatteryImageErrorWhileBatteyIsNotChoosen();
}

class InitDataFrontBatteryImageErrorWhileBatteyIsChoosen extends InitDataState {
  InitDataFrontBatteryImageErrorWhileBatteyIsChoosen();
}

// user didn't capture the fixed battery image is choosen
class InitDataFixedBatteryImage extends InitDataState {
  final String imagePath;

  InitDataFixedBatteryImage(this.imagePath);
}

class InitDataFixedBatteryImageError extends InitDataState {
  InitDataFixedBatteryImageError();
}

// user didn't capture the car number Image  is choosen
class InitDataCarNumberImage extends InitDataState {
  final String imagePath;

  InitDataCarNumberImage(this.imagePath);
}

class InitDataCarNumberImageError extends InitDataState {
  InitDataCarNumberImageError();
}

// to battery choosen field reset
class InitDataBatteryChoosenTextFieldReset extends InitDataState {
  InitDataBatteryChoosenTextFieldReset();
}

// to battery choosen field error
class InitDataBatteryChoosenTextFieldError extends InitDataState {
  InitDataBatteryChoosenTextFieldError();
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

// to Car Number field reset
class InitDataCarNumberReset extends InitDataState {
  InitDataCarNumberReset();
}

// to Car Number field error
class InitDataCarNumberError extends InitDataState {
  InitDataCarNumberError();
}

// to Car Number field reset
class InitDataCarTypeReset extends InitDataState {
  InitDataCarTypeReset();
}

// to Car Number field error
class InitDataCarTypeError extends InitDataState {
  InitDataCarTypeError();
}

// to Car Number field reset
class InitDataCarPropertyReset extends InitDataState {
  InitDataCarPropertyReset();
}

// to Car Number field error
class InitDataCarPropertyError extends InitDataState {
  InitDataCarPropertyError();
}

// to Car Number field reset
class InitDataMarketReset extends InitDataState {
  InitDataMarketReset();
}

// to Car Number field error
class InitDataMarketError extends InitDataState {
  InitDataMarketError();
}

// to Car Number field reset
class InitDataCountryReset extends InitDataState {
  InitDataCountryReset();
}

// to Car Number field error
class InitDataCountryError extends InitDataState {
  InitDataCountryError();
}

//state when the submit is successful
class InitDataSubmitSent extends InitDataState {
  final Warranty warranty;

  InitDataSubmitSent(this.warranty);
}

//state when the submit is loading
class InitDataSubmitLoading extends InitDataState {
  InitDataSubmitLoading();
}

//state when the submit has an error
class InitDataSubmitError extends InitDataState {
  final String errorArabic;
  final String errorEnglish;

  InitDataSubmitError(this.errorArabic, this.errorEnglish);
}
