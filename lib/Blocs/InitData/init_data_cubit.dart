import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ewarrenty/Models/Battery.dart';
import 'package:ewarrenty/Models/car_property.dart';
import 'package:ewarrenty/Models/car_type.dart';
import 'package:ewarrenty/Models/market.dart';
import 'package:ewarrenty/services/initData/InitDataService.dart';
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

  InitDataCubit() : super(InitDataInitial()){

    // todo: replace with BehaviorSubject from rxdart package
    // it destroy the lisener  when the widget rebuilds

    _carTypesStreamController = BehaviorSubject<int>();
    _carPropertiesStreamController = BehaviorSubject<int>();
    _marketStreamController = BehaviorSubject<Market>();

    // _carTypesStreamController.add(null);
    // _carPropertiesStreamController.add(null);
    // _marketStreamController.add(null);

    _batteries=[];
    _carTypes=[];
    _carProperties=[];
    _markets=[];

    _getInitData();

  }


  List<Battery> get batteries => _batteries;

  set batteries(List<Battery> value) {
    _batteries = value;
  }

  get carTypeIdStream =>_carTypesStreamController.stream;
  carTypeIdSelectedValue(value) {
    _carTypeId=value;
    print(_carTypeId);
    _carTypesStreamController.sink.add(value);
  }

  get carPropertyIdStream =>_carPropertiesStreamController.stream;
  carPropertyIdSelectedValue(value) {
    _carPropertyId=value;
    _carPropertiesStreamController.sink.add(value);
  }

  get marketIdStream =>_marketStreamController.stream;
  marketSelectedValue(value) {
    _market=value;
    _marketStreamController.sink.add(value);
  }

  _getInitData(){
    emit(InitDataLoading());
    InitDataService initDataService = InitDataService.create();
    initDataService.getData().then((value){
      //todo: handle statues Codes
      print (value.body);
      var data =value.body;
      for(var JSONItem in data['batteries']){
        _batteries.add(Battery.fromJson(JSONItem));
      }

      for(var JSONItem in data['carProperties']){
        _carProperties.add(CarProperty.fromJson(JSONItem));
      }
      for(var JSONItem in data['carTypes']){
        _carTypes.add(CarType.fromJson(JSONItem));
      }

      for(var JSONItem in data['markets']){
        _markets.add(Market.fromJson(JSONItem));
      }

      emit(InitDataLoaded(_batteries,_carTypes,_carProperties,_markets));

    }).catchError((e){

      print('InitDataCubit $e');
      emit(InitDataError("no network", "لا توجد شبكة"));

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
}
