import 'package:bloc/bloc.dart';
import 'package:ewarrenty/Function/FirebaseCrashlyticsLog.dart';
import 'package:ewarrenty/Models/car_type.dart';
import 'package:ewarrenty/services/sendMarket/SendMarketService.dart';
import 'package:meta/meta.dart';

part 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  AddCarCubit({String language})
      : this._language = language,
        super(AddCarInitial());

  final String _language;

  String _name;
  bool _isNameError = false;

  bool getValidation() {
    return isNameError;
  }

  String get language => _language;

  // set language(String value) {
  //   _language = value;
  // }

  sendNewMarket() {
    emit(AddCarLoading());
    // print("${_countryCode.dialCode}$_phoneNumber");
    Map<String, dynamic> map = {
      "name_ar": _language.contains("ar") ? _name : "",
      "name_en": _language.contains("en") ? _name : "",
    };
    SendMarketService.create()
        .sendMarket(
      body: map,
    )
        .then((value) {
      if (value.statusCode >= 200 && value.statusCode <= 299) {
        if (value.body.containsKey("error")) {
          Map<String, dynamic> errorMap = value.body;
          print("AddWarrantyErrorMap:${value.body}");
          emit(AddCarError(errorMap['error'], errorMap['error']));
          // if (errorMap['error'].contains('this serial number')) {
          //   var errorArabic = "إن هذا الرقم التسلسلي غير موجود" ;
          //   var errorEnglish = "This Serial Number Do NOT Exist" ;
          //   emit(InitDataSubmitError(errorArabic, errorEnglish));
          // }

        } else {
          var data = value.body;
          var carType = CarType.fromJson(data);
          // onDone.call();
          emit(
            AddCarLoaded(
              carType,
            ),
          );
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
        emit(
          AddCarError("خطأ بالاتصال: ${value.statusCode}",
              "Connection Error: ${value.statusCode}"),
        );
      }
    })
          ..catchError((e) {
            print(e);
            firebaseCrashLog(
              tag: "InitDataCubit.sendNewMarket",
              message: e.toString(),
            );
            emit(
              AddCarError(
                "تأكد من اتصالك بالانترنيت",
                "check your internet connection",
              ),
            );
          });
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool get isNameError => _isNameError;

  set isNameError(bool value) {
    _isNameError = value;
  }
}
