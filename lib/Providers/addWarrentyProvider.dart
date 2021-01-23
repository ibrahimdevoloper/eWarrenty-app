import 'package:ewarrenty/Models/Battery.dart';
import 'package:ewarrenty/Models/car_property.dart';
import 'package:ewarrenty/Models/car_type.dart';
import 'package:ewarrenty/Models/market.dart';
import 'package:ewarrenty/services/initData/InitDataService.dart';
import 'package:flutter/material.dart';

class AddWarrentyProvider extends ChangeNotifier {
  bool _isAPILoading = true;
  bool _isSubmitLoading = false;

  bool _isError = false;
  String errorMessageEN = "";
  String errorMessageAR = "";

  List<Battery> _batteries;
  List<CarType> _carTypes;
  List<CarProperty> _carProperties;
  List<Market> _markets;

  // StreamController<int> _carTypesStreamController;
  // StreamController<int> _carPropertiesStreamController;
  // StreamController<Market> _marketStreamController;

  int _carTypeId;
  int _carPropertyId;
  Market _market;

  Battery _battery;
  String _country;
  String _billDate;
  String _serialNumber;

  String _fullName;
  String _address;
  String _eMail;
  String _phoneNumber;

  String _frontBatteryPath;
  String _fixedBatteryPath;
  String _carNumberPath;

  AddWarrentyProvider() {}

  _getInitData() {
    // emit(InitDataLoading());
    bool _isAPILoading = true;
    notifyListeners();
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

      bool _isAPILoading = false;

      notifyListeners();

      // emit(InitDataLoaded(_batteries,_carTypes,_carProperties,_markets));
    }).catchError((e) {
      print('InitDataCubit $e');
      // emit(InitDataError("no network", "لا توجد شبكة"));
      _isError = true;
      errorMessageAR = "لا توجد شبكة";
      errorMessageEN = "no network";
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

  List<Battery> get batteries => _batteries;

  set batteries(List<Battery> value) {
    _batteries = value;
  }

  bool get isError => _isError;

  set isError(bool value) {
    _isError = value;
  }

  bool get isSubmitLoading => _isSubmitLoading;

  set isSubmitLoading(bool value) {
    _isSubmitLoading = value;
  }

  bool get isAPILoading => _isAPILoading;

  set isAPILoading(bool value) {
    _isAPILoading = value;
  }
}
