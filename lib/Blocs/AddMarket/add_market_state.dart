part of 'add_market_cubit.dart';

@immutable
abstract class AddMarketState {
  const AddMarketState();
}

class AddMarketInitial extends AddMarketState {
  AddMarketInitial();
}

//state when the New Market E-mail Resets
class AddMarketEmailReset extends AddMarketState {
  AddMarketEmailReset();
}

//state when the New Market E-mail has error
class AddMarketEmailError extends AddMarketState {
  AddMarketEmailError();
}

//state when the New Market Phone Number Resets
class AddMarketPhoneNumberReset extends AddMarketState {
  AddMarketPhoneNumberReset();
}

//state when the New Market Phone Number has error
class AddMarketPhoneNumberError extends AddMarketState {
  AddMarketPhoneNumberError();
}

//state when the New Market bottom sheet Loading
class AddMarketLoading extends AddMarketState {
  AddMarketLoading();
}

//state when the New Market bottom sheet Error
class AddMarketError extends AddMarketState {
  final String errorArabic;
  final String errorEnglish;

  AddMarketError(this.errorArabic, this.errorEnglish);
}

class AddMarketLoaded extends AddMarketState {
  final Market market;

  AddMarketLoaded(this.market);
}

class AddMarketMapLoaded extends AddMarketState {
  final Map<String, dynamic> map;
  AddMarketMapLoaded(this.map);
}

//state when the New Market Name Resets
class AddMarketNameReset extends AddMarketState {
  AddMarketNameReset();
}

//state when the New Market Name has error
class AddMarketNameError extends AddMarketState {
  AddMarketNameError();
}

//state when the New Market Address Resets
class AddMarketAddressReset extends AddMarketState {
  AddMarketAddressReset();
}

//state when the New Market Address has error
class AddMarketAddressError extends AddMarketState {
  AddMarketAddressError();
}
