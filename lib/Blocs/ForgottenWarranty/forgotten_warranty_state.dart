part of 'forgotten_warranty_cubit.dart';

@immutable
abstract class ForgottenWarrantyState {}

class ForgottenWarrantyInitial extends ForgottenWarrantyState {}

class ForgottenWarrantyLoading extends ForgottenWarrantyState {
  ForgottenWarrantyLoading();
}

class ForgottenWarrantyLoaded extends ForgottenWarrantyState {
  final List<Warranty> warranties;

  ForgottenWarrantyLoaded(this.warranties);
}

class ForgottenWarrantyError extends ForgottenWarrantyState {
  final String errorArabic;
  final String errorEnglish;

  ForgottenWarrantyError(this.errorArabic, this.errorEnglish);
}

class ForgottenWarrantyEmailReset extends ForgottenWarrantyState {
  ForgottenWarrantyEmailReset();
}

class ForgottenWarrantyEmailError extends ForgottenWarrantyState {
  ForgottenWarrantyEmailError();
}

class ForgottenWarrantyPhoneNumberReset extends ForgottenWarrantyState {
  ForgottenWarrantyPhoneNumberReset();
}

class ForgottenWarrantyPhoneNumberError extends ForgottenWarrantyState {
  ForgottenWarrantyPhoneNumberError();
}
