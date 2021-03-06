import 'package:chopper/chopper.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:ewarrenty/Function/FirebaseCrashlyticsLog.dart';
import 'package:ewarrenty/Models/market.dart';
import 'package:ewarrenty/services/sendMarket/SendMarketService.dart';
import 'package:flutter/material.dart';

class AddMarketProvider extends ChangeNotifier {
  // String _languageCode = "";
  // SharedPreferences _prefs;

  final CountryCode _countryCode;
  final String _language;

  String _name;
  String _address;
  String _phoneNumber;
  String _email;

  Market _market;

  bool _isNameError = false;
  bool _isAddressError = false;
  bool _isPhoneNumberError = false;
  bool _isEmailError = false;

  bool _isLoading = false;

  bool getValidation() {
    return !(isNameError ||
        isAddressError ||
        isPhoneNumberError ||
        isEmailError);
  }

  AddMarketProvider(this._countryCode, this._language) {}

  sendNewMarket({Function onDone}) async {
    // emit(AddMarketLoading());
    // print("${_countryCode.dialCode}$_phoneNumber");
    Map<String, dynamic> map = {
      "name_ar": _language.contains("ar") ? _name : "",
      "name_en": _language.contains("en") ? _name : "",
      "address_ar": _language.contains("ar") ? _address : "",
      "address_en": _language.contains("en") ? _address : "",
      "country": (_countryCode.name) ?? "",
      "email": _email ?? "",
      "phone_number": "${_countryCode.dialCode}$_phoneNumber",
    };
    SendMarketService service = SendMarketService.create();
    try {
      // print("delay");
      // await Future<void>.delayed(
      //   const Duration(
      //     seconds: 5,
      //   ),
      // ).then((value) {
      //   print("delayed");
      // });
      Response value = await service.sendMarket(
        body: map,
      );

      if (value.statusCode >= 200 && value.statusCode <= 299) {
        if (value.body.containsKey("error")) {
          // print("error Checked");
          Map<String, dynamic> errorMap = value.body;
          // print("AddWarrantyErrorMap:${value.body}");
          // emit(AddMarketError(errorMap['error'], errorMap['error']));
          // if (errorMap['error'].contains('this serial number')) {
          //   var errorArabic = "إن هذا الرقم التسلسلي غير موجود" ;
          //   var errorEnglish = "This Serial Number Do NOT Exist" ;
          //   emit(InitDataSubmitError(errorArabic, errorEnglish));
          // }

        } else {
          var data = value.body;
          _market = Market.fromJson(data);
          // print("before emitting");
          // onDone.call();
          // emit(
          //   AddMarketLoaded(
          //     _market,
          //   ),
          // );
        }
      }
      // else if (value.statusCode == 400) {
      //   print("error :400 ,${value.error} ");
      //   var error = getJSONMap(value.error);
      //   var errorArabic = error['messageAr'];
      //   var errorEnglish = error['messageEn'];
      //
      //   emit(InitDataSubmitError(errorArabic, errorEnglish));
      // } else if (value.statusCode == 502) {
      //   var error = getJSONMap(value.error);
      //   var errorArabic = error['messageAr'];
      //   var errorEnglish = error['messageEn'];
      //   emit(InitDataSubmitError(errorArabic, errorEnglish));
      // }
      else {
        firebaseCrashLog(
          code: value.statusCode.toString(),
          tag: "InitDataCubit.sendNewMarket",
          message: value.error.toString(),
        );
        // emit(
        //   AddMarketError("خطأ بالاتصال: ${value.statusCode}",
        //       "Connection Error: ${value.statusCode}"),
        // );
      }
    } catch (e) {
      // print(e);
      firebaseCrashLog(
        tag: "InitDataCubit.sendNewMarket",
        message: e.toString(),
      );
      // emit(
      //   AddMarketError(
      //     "تأكد من اتصالك بالانترنيت",
      //     "check your internet connection",
      //   ),
      // );
    }
    // service
    //     .sendMarket(
    //   body: map,
    // )
    //     .then((value) {
    //
    // }).catchError((e) {
    //
    // });
  }

  bool get isEmailError => _isEmailError;

  set isEmailError(bool value) {
    _isEmailError = value;
    notifyListeners();
  }

  bool get isPhoneNumberError => _isPhoneNumberError;

  set isPhoneNumberError(bool value) {
    _isPhoneNumberError = value;
    notifyListeners();
  }

  bool get isAddressError => _isAddressError;

  set isAddressError(bool value) {
    _isAddressError = value;
    notifyListeners();
  }

  bool get isNameError => _isNameError;

  set isNameError(bool value) {
    _isNameError = value;
    notifyListeners();
  }

  Market get market => _market;

  set market(Market value) {
    _market = value;
    notifyListeners();
  }

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  String get address => _address;

  set address(String value) {
    _address = value;
    notifyListeners();
  }

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get language => _language;

  // set language(String value) {
  //   _language = value;
  // }

  CountryCode get countryCode => _countryCode;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

// set countryCode(CountryCode value) {
  //   _countryCode = value;
  // }

}
