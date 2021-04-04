part of 'add_car_cubit.dart';

@immutable
abstract class AddCarState {}

class AddCarInitial extends AddCarState {
  AddCarInitial();
}

//state when the New Market E-mail Resets
class AddCarEmailReset extends AddCarState {
  AddCarEmailReset();
}

//state when the New Market E-mail has error
class AddCarEmailError extends AddCarState {
  AddCarEmailError();
}

//state when the New Market Phone Number Resets
class AddCarPhoneNumberReset extends AddCarState {
  AddCarPhoneNumberReset();
}

//state when the New Market Phone Number has error
class AddCarPhoneNumberError extends AddCarState {
  AddCarPhoneNumberError();
}

//state when the New Market bottom sheet Loading
class AddCarLoading extends AddCarState {
  AddCarLoading();
}

//state when the New Market bottom sheet Error
class AddCarError extends AddCarState {
  final String errorArabic;
  final String errorEnglish;

  AddCarError(this.errorArabic, this.errorEnglish);
}

class AddCarLoaded extends AddCarState {
  final CarType market;

  AddCarLoaded(this.market);
}

//state when the New Market Name Resets
class AddCarNameReset extends AddCarState {
  AddCarNameReset();
}

//state when the New Market Name has error
class AddCarNameError extends AddCarState {
  AddCarNameError();
}

//state when the New Market Address Resets
class AddCarAddressReset extends AddCarState {
  AddCarAddressReset();
}

//state when the New Market Address has error
class AddCarAddressError extends AddCarState {
  AddCarAddressError();
}
