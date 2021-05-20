import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:ewarrenty/Function/FirebaseCrashlyticsLog.dart';
import 'package:ewarrenty/Models/market.dart';
import 'package:ewarrenty/services/sendMarket/SendMarketService.dart';
import 'package:meta/meta.dart';

part 'add_market_state.dart';

class AddMarketCubit extends Cubit<AddMarketState> {
  final CountryCode _countryCode;
  final String _language;

  String _name;
  String _address;
  String _phoneNumber;
  String _email;

  Market _market;

  Market get market => _market;

  set market(Market value) {
    _market = value;
  }

  bool _isNameError = false;
  bool _isAddressError = false;
  bool _isPhoneNumberError = false;
  bool _isEmailError = false;

  AddMarketCubit({@required String language, @required CountryCode countryCode})
      : this._language = language,
        this._countryCode = countryCode,
        super(AddMarketInitial());

  bool getValidation() {
    return !(isNameError ||
        isAddressError ||
        isPhoneNumberError ||
        isEmailError);
  }

  returnNewMarketMap() {
    Map<String, dynamic> map = {
      "name_ar": _language.contains("ar") ? _name : "",
      "name_en": _language.contains("en") ? _name : "",
      "address_ar": _language.contains("ar") ? _address : "",
      "address_en": _language.contains("en") ? _address : "",
      "country": (_countryCode.name) ?? "",
      "email": _email ?? "",
      "phone_number": "${_countryCode.dialCode}$_phoneNumber",
    };
    emit(
      AddMarketMapLoaded(
        map,
      ),
    );
  }

  sendNewMarket() {
    emit(AddMarketLoading());
    Map<String, dynamic> map = {
      "name_ar": _language.contains("ar") ? _name : "",
      "name_en": _language.contains("en") ? _name : "",
      "address_ar": _language.contains("ar") ? _address : "",
      "address_en": _language.contains("en") ? _address : "",
      "country": (_countryCode.name) ?? "",
      "email": _email ?? "",
      "phone_number": "${_countryCode.dialCode}$_phoneNumber",
    };
    SendMarketService.create()
        .sendMarket(
      body: map,
    )
        .then((value) {
      if (value.statusCode >= 200 && value.statusCode <= 299) {
        if (value.body.containsKey("error")) {
          Map<String, dynamic> errorMap = value.body;
          emit(AddMarketError(errorMap['error'], errorMap['error']));
        } else {
          var data = value.body;
          var market = Market.fromJson(data);
          // onDone.call();
          emit(
            AddMarketLoaded(
              market,
            ),
          );
        }
      } else {
        firebaseCrashLog(
          code: value.statusCode.toString(),
          tag: "AddMarketCubit.sendNewMarket",
          message: value.error.toString(),
        );
        emit(
          AddMarketError("خطأ بالاتصال: ${value.statusCode}",
              "Connection Error: ${value.statusCode}"),
        );
      }
    })
          ..catchError((e) {
            // print(e);
            firebaseCrashLog(
              tag: "AddMarketCubit.sendNewMarket",
              message: e.toString(),
            );
            emit(
              AddMarketError(
                "تأكد من اتصالك بالانترنيت",
                "check your internet connection",
              ),
            );
          });
  }

  bool get isEmailError => _isEmailError;

  set isEmailError(bool value) {
    _isEmailError = value;
  }

  bool get isPhoneNumberError => _isPhoneNumberError;

  set isPhoneNumberError(bool value) {
    _isPhoneNumberError = value;
  }

  bool get isAddressError => _isAddressError;

  set isAddressError(bool value) {
    _isAddressError = value;
  }

  bool get isNameError => _isNameError;

  set isNameError(bool value) {
    _isNameError = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get language => _language;

  // set language(String value) {
  //   _language = value;
  // }

  CountryCode get countryCode => _countryCode;

  // set countryCode(CountryCode value) {
  //   _countryCode = value;
  // }
}
