import 'dart:async';

import 'package:bloc/bloc.dart';
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
  String _country;
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

  bool _frontBatteryPathIsError = false;
  bool _fixedBatteryPathIsError = false;
  bool _carNumberPathIsError = false;

  InitDataCubit() : super(InitDataInitial()) {
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

  getFinalValidtion() {
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
        _carNumberPathIsError);
  }

  List<Battery> get batteries => _batteries;

  set batteries(List<Battery> value) {
    _batteries = value;
  }

  get carTypeIdStream => _carTypesStreamController.stream;

  carTypeIdSelectedValue(value) {
    _carTypeId = value;
    print(_carTypeId);
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
      print(value.body);
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

      for (var JSONItem in data['markets']) {
        _markets.add(Market.fromJson(JSONItem));
      }

      emit(InitDataLoaded(_batteries, _carTypes, _carProperties, _markets));
    }).catchError((e) {
      print('InitDataCubit $e');
      //TODO: taranslate "check your internet connection "
      emit(InitDataError("no network", "لا توجد شبكة"));
    });
  }

  submitWarrantyData() {
    emit(InitDataLoading());
    SendWarrantyService service = SendWarrantyService.create();
    service
        .sendWarrenty(
            battery_front_image: frontBatteryPath,
            battery_model_id: battery.id,
            battery_serial_number: serialNumber,
            bought_date: billDate,
            car_number: carNumber,
            car_number_image: carNumberPath,
            car_property_id: carPropertyId,
            car_type_id: carTypeId,
            customer_country: country,
            customer_email: eMail,
            customer_name: fullName,
            customer_phone_number: phoneNumber,
            fixed_battery_image: fixedBatteryPath,
            customer_address: address,
            market_id: market.id,
            notes: "")
        .then((value) {
      // print("AddWarrantybody:${value.body}");
      // print("AddWarrantyisSuccessful:${value.isSuccessful}");
      // print("AddWarrantyError:${value.error.toString()}");

      if (value.statusCode == 200) {
        var data = value.body['data'];
        emit(InitDataSubmitSent(Warranty.fromJson(data)));
      } else if (value.statusCode == 400) {
        var errorArabic = value.body['messageAr'];
        var errorEnglish = value.body['messageEn'];
        emit(InitDataSubmitError(errorArabic, errorEnglish));
      } else if (value.statusCode == 502) {
        var errorArabic = value.body['messageAr'];
        var errorEnglish = value.body['messageEn'];
        emit(InitDataSubmitError(errorArabic, errorEnglish));
      }
    })
          ..catchError((e) {
            print(e);
            //TODO: taranslate "check your internet connection "
            emit(InitDataSubmitError("check your internet connection",
                "check your internet connection "));
          });
  }

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

  String get country => _country;

  set country(String value) {
    _country = value;
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
}
