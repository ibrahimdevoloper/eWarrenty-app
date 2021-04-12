import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:ewarrenty/Function/FirebaseCrashlyticsLog.dart';
import 'package:ewarrenty/Models/Battery.dart';
import 'package:ewarrenty/Models/car_property.dart';
import 'package:ewarrenty/Models/car_type.dart';
import 'package:ewarrenty/Models/market.dart';
import 'package:ewarrenty/Models/warranty.dart';
import 'package:ewarrenty/services/initData/InitDataService.dart';
import 'package:ewarrenty/services/sendWarranty/SendWarrantyService.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'init_data_state.dart';

class InitDataCubit extends Cubit<InitDataState> {
  List<Battery> _batteries;
  List<CarType> _carTypes;
  List<CarProperty> _carProperties;
  List<Market> _markets;

  StreamController<int> _carTypesStreamController;
  StreamController<int> _carPropertiesStreamController;
  StreamController<Market> _marketStreamController;

  int _carTypeId;
  int _carPropertyId;
  Market _market;

  bool _carTypeIdIsError = false;
  bool _carPropertyIdIsError = false;
  bool _marketIsError = false;

  Battery _battery;
  CountryCode _countryCode;

  CountryCode get countryCode => _countryCode;

  set countryCode(CountryCode value) {
    _countryCode = value;
  }

  String _countryName;
  String _billDate;
  String _serialNumber;

  bool _batteryIsError = false;
  bool _countryIsError = false;
  bool _billDateIsError = false;
  bool _serialNumberIsError = false;

  String _fullName;
  String _address;
  String _eMail;
  String _phoneNumber;
  String _carNumber;

  bool _fullNameIsError = false;
  bool _addressIsError = false;
  bool _eMailIsError = false;
  bool _phoneNumberIsError = false;
  bool _carNumberIsError = false;

  String _frontBatteryPath;
  String _fixedBatteryPath;
  String _carNumberPath;
  String _billImagePath;

  bool _frontBatteryPathIsError = false;
  bool _fixedBatteryPathIsError = false;
  bool _carNumberPathIsError = false;
  bool _billImagePathIsError = false;

  String _notes;

  String _newCarName;

  String get notes => _notes;

  set notes(String value) {
    _notes = value;
  }

  InitDataCubit() : super(InitDataInitial()) {
    // service = SendWarrantyService.create();

    // todo: replace with BehaviorSubject from rxdart package
    // it destroy the lisener  when the widget rebuilds

    _carTypesStreamController = BehaviorSubject<int>();
    _carPropertiesStreamController = BehaviorSubject<int>();
    _marketStreamController = BehaviorSubject<Market>();

    // _carTypesStreamController.add(null);
    // _carPropertiesStreamController.add(null);
    // _marketStreamController.add(null);

    _batteries = [];
    _carTypes = [];
    _carProperties = [];
    _markets = [];

    _getInitData();
  }

  // return true If data is correct
  // bool checkCarValidation() {
  //   return _carTypeId != null || _newCarName != null;
  // }

  // void getNote() {
  //   if (_newCarName != null) {
  //     this._notes = "${this._notes ?? ''}\nCar Name: ${this._newCarName}\n";
  //   }
  //   if (_newMarketName != null && _newMarketAddress != null) {
  //     this._notes =
  //     "${this._notes ?? ''}\nMarket Name: ${this._newMarketName}\n";
  //     this._notes =
  //     "${this._notes ?? ''}\nMarket Address: ${this._newMarketAddress}\n";
  //   }
  // }

  // return true If data is correct
  // bool checkMarketValidation() {
  //   return _market != null ||
  //       (_newMarketName != null && _newMarketAddress != null);
  // }

  bool getFinalValidtion() {
    return !(_carTypeIdIsError ||
        _carPropertyIdIsError ||
        _marketIsError ||
        _batteryIsError ||
        _countryIsError ||
        _billDateIsError ||
        _serialNumberIsError ||
        _fullNameIsError ||
        _addressIsError ||
        _eMailIsError ||
        _phoneNumberIsError ||
        _carNumberIsError ||
        _frontBatteryPathIsError ||
        _fixedBatteryPathIsError ||
        _carNumberPathIsError ||
        _billImagePathIsError);
  }

  List<Battery> get batteries => _batteries;

  set batteries(List<Battery> value) {
    _batteries = value;
  }

  get carTypeIdStream => _carTypesStreamController.stream;

  carTypeIdSelectedValue(value) {
    _carTypeId = value;
    // print(_carTypeId);
    _carTypesStreamController.sink.add(value);
  }

  get carPropertyIdStream => _carPropertiesStreamController.stream;

  carPropertyIdSelectedValue(value) {
    _carPropertyId = value;
    _carPropertiesStreamController.sink.add(value);
  }

  get marketIdStream => _marketStreamController.stream;

  marketSelectedValue(value) {
    _market = value;
    _marketStreamController.sink.add(value);
  }

  _getInitData() {
    emit(InitDataLoading());
    InitDataService initDataService = InitDataService.create();
    initDataService.getData().then((value) {
      //TODO: handle statues Codes
      // print(value.body);
      var data = value.body;
      for (var JSONItem in data['batteries']) {
        _batteries.add(Battery.fromJson(JSONItem));
      }

      for (var JSONItem in data['carProperties']) {
        _carProperties.add(CarProperty.fromJson(JSONItem));
      }

      for (var JSONItem in data['carTypes']) {
        _carTypes.add(CarType.fromJson(JSONItem));
      }
      _carTypes.add(
        // TODO: Create a Constant for car notes
        CarType(
          id: 0,
          nameAr: "أخرى",
          nameEn: "Other",
        ),
      );

      for (var JSONItem in data['markets']) {
        _markets.add(Market.fromJson(JSONItem));
      }

      emit(InitDataLoaded(_batteries, _carTypes, _carProperties, _markets));
    }).catchError((e) {
      // print('InitDataCubit $e');
      //TODO: taranslate "check your internet connection "
      emit(InitDataError("no network", "لا توجد شبكة"));
    });
  }

  submitWarrantyData() {
    // emit(InitDataLoading());
    emit(InitDataSubmitLoading());
    SendWarrantyService.create()
        .sendWarrenty(
      battery_front_image: frontBatteryPath,
      battery_model_id: battery.id,
      battery_serial_number: serialNumber,
      bought_date: billDate,
      car_number: carNumber,
      car_number_image: carNumberPath,
      car_property_id: carPropertyId,
      car_type_id: carTypeId,
      customer_country: countryName,
      customer_email: eMail,
      customer_name: fullName,
      customer_phone_number: "${countryCode.dialCode}$phoneNumber",
      fixed_battery_image: fixedBatteryPath,
      customer_address: address,
      market_id: market.id,
      bill_image: billImagePath,
      notes: "clear",
    )
        .then((value) {
      // print("billImagePath: $billImagePath");
      // print("AddWarrantybody:${value.body}");
      // print("AddWarrantyisSuccessful:${value.isSuccessful}");
      // print("AddWarrantyError:${value.error.toString()}");
      print("battery Id:${battery.id}");
      if (value.error.toString() != null) {
        var errorString = value.error.toString();
        // print("AddWarrantyError:${value.error.toString()}");
      }

      // print("AddWarrantyError:${getJSONMap(
      //     value.body
      // )}");

      if (value.statusCode >= 200 && value.statusCode <= 299) {
        if (value.body.containsKey("error")) {
          Map<String, dynamic> errorMap = value.body;
          print("AddWarrantyErrorMap:${value.body}");
          if (errorMap['error'].contains('this serial number')) {
            var errorArabic = "إن الرقم التسلسلي المستخدم غير موجود";
            var errorEnglish = "This Serial Number Do NOT Exist";
            emit(InitDataSubmitError(errorArabic, errorEnglish));
          } else if (errorMap['error']
              .contains('this car number already exists')) {
            var errorArabic = "إن رقم السيارة المدخل مرتبط ببطارية مكفولة";
            var errorEnglish = "This Car Number is Already Entered for a Warranted Battery";
            emit(InitDataSubmitError(errorArabic, errorEnglish));
          } else {
            Map<String, dynamic> errorMap = value.body;
            // print("AddWarrantyErrorMap:${value.body}");
            emit(InitDataSubmitError(errorMap['error'], errorMap['error']));
            // if (errorMap['error'].contains('this serial number')) {
            //   var errorArabic = "إن هذا الرقم التسلسلي غير موجود" ;
            //   var errorEnglish = "This Serial Number Do NOT Exist" ;
            //   emit(InitDataSubmitError(errorArabic, errorEnglish));
            // }
          }
        } else if (value.body.containsKey("data")) {
          var data = value.body['data'];
          // print(data);
          emit(InitDataSubmitSent(Warranty.fromJson(data)));
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
          tag: "InitDataCubit.submitWarrantyData",
          message: value.error.toString(),
        );
        emit(
          InitDataSubmitError("خطأ بالاتصال: ${value.statusCode}",
              "Connection Error: ${value.statusCode}"),
        );
      }
    })
          ..catchError((e) {
            // print(e);
            firebaseCrashLog(
              tag: "InitDataCubit.submitWarrantyData",
              message: e.toString(),
            );
            emit(
              InitDataSubmitError(
                "تأكد من اتصالك بالانترنيت",
                "check your internet connection",
              ),
            );
          });
  }

  sendNewCar(String lang) {}

  String get carNumberPath => _carNumberPath;

  set carNumberPath(String value) {
    _carNumberPath = value;
  }

  String get fixedBatteryPath => _fixedBatteryPath;

  set fixedBatteryPath(String value) {
    _fixedBatteryPath = value;
  }

  String get frontBatteryPath => _frontBatteryPath;

  set frontBatteryPath(String value) {
    _frontBatteryPath = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get eMail => _eMail;

  set eMail(String value) {
    _eMail = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get fullName => _fullName;

  set fullName(String value) {
    // print(value);
    _fullName = value;
  }

  String get serialNumber => _serialNumber;

  set serialNumber(String value) {
    _serialNumber = value;
  }

  String get billDate => _billDate;

  set billDate(String value) {
    _billDate = value;
  }

  String get countryName => _countryName;

  set countryName(String value) {
    _countryName = value;
  }

  Battery get battery => _battery;

  set battery(Battery value) {
    _battery = value;
  }

  Market get market => _market;

  set market(Market value) {
    _market = value;
  }

  int get carPropertyId => _carPropertyId;

  set carPropertyId(int value) {
    _carPropertyId = value;
  }

  int get carTypeId => _carTypeId;

  set carTypeId(int value) {
    _carTypeId = value;
  }

  List<Market> get markets => _markets;

  set markets(List<Market> value) {
    _markets = value;
  }

  List<CarProperty> get carProperties => _carProperties;

  set carProperties(List<CarProperty> value) {
    _carProperties = value;
  }

  List<CarType> get carTypes => _carTypes;

  set carTypes(List<CarType> value) {
    _carTypes = value;
  }

  String get carNumber => _carNumber;

  set carNumber(String value) {
    _carNumber = value;
  }

  StreamController<Market> get marketStreamController =>
      _marketStreamController;

  set marketStreamController(StreamController<Market> value) {
    _marketStreamController = value;
  }

  StreamController<int> get carPropertiesStreamController =>
      _carPropertiesStreamController;

  set carPropertiesStreamController(StreamController<int> value) {
    _carPropertiesStreamController = value;
  }

  StreamController<int> get carTypesStreamController =>
      _carTypesStreamController;

  set carTypesStreamController(StreamController<int> value) {
    _carTypesStreamController = value;
  }

  bool get carNumberPathIsError => _carNumberPathIsError;

  set carNumberPathIsError(bool value) {
    _carNumberPathIsError = value;
  }

  bool get fixedBatteryPathIsError => _fixedBatteryPathIsError;

  set fixedBatteryPathIsError(bool value) {
    _fixedBatteryPathIsError = value;
  }

  bool get frontBatteryPathIsError => _frontBatteryPathIsError;

  set frontBatteryPathIsError(bool value) {
    _frontBatteryPathIsError = value;
  }

  bool get carNumberIsError => _carNumberIsError;

  set carNumberIsError(bool value) {
    _carNumberIsError = value;
  }

  bool get phoneNumberIsError => _phoneNumberIsError;

  set phoneNumberIsError(bool value) {
    _phoneNumberIsError = value;
  }

  bool get eMailIsError => _eMailIsError;

  set eMailIsError(bool value) {
    _eMailIsError = value;
  }

  bool get addressIsError => _addressIsError;

  set addressIsError(bool value) {
    _addressIsError = value;
  }

  bool get fullNameIsError => _fullNameIsError;

  set fullNameIsError(bool value) {
    _fullNameIsError = value;
  }

  bool get serialNumberIsError => _serialNumberIsError;

  set serialNumberIsError(bool value) {
    _serialNumberIsError = value;
  }

  bool get billDateIsError => _billDateIsError;

  set billDateIsError(bool value) {
    _billDateIsError = value;
  }

  bool get countryIsError => _countryIsError;

  set countryIsError(bool value) {
    _countryIsError = value;
  }

  bool get batteryIsError => _batteryIsError;

  set batteryIsError(bool value) {
    _batteryIsError = value;
  }

  bool get marketIsError => _marketIsError;

  set marketIsError(bool value) {
    _marketIsError = value;
  }

  bool get carPropertyIdIsError => _carPropertyIdIsError;

  set carPropertyIdIsError(bool value) {
    _carPropertyIdIsError = value;
  }

  bool get carTypeIdIsError => _carTypeIdIsError;

  set carTypeIdIsError(bool value) {
    _carTypeIdIsError = value;
  }

  bool get billImagePathIsError => _billImagePathIsError;

  set billImagePathIsError(bool value) {
    _billImagePathIsError = value;
  }

  String get billImagePath => _billImagePath;

  set billImagePath(String value) {
    _billImagePath = value;
  }

  String get newCarName => _newCarName;

  set newCarName(String value) {
    _newCarName = value;
  }
}
