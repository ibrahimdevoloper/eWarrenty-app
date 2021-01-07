import 'package:bloc/bloc.dart';
import 'package:ewarrenty/Models/battery.dart';
import 'package:ewarrenty/Models/car_property.dart';
import 'package:ewarrenty/Models/car_type.dart';
import 'package:ewarrenty/Models/market.dart';
import 'package:ewarrenty/services/initData/InitDataService.dart';
import 'package:meta/meta.dart';

part 'init_data_state.dart';

class InitDataCubit extends Cubit<InitDataState> {
  InitDataCubit() : super(InitDataInitial()){
    _getInitData();
  }

  _getInitData(){
    emit(InitDataLoading());
    InitDataService initDataService = InitDataService.create();
    initDataService.getData().then((value){
      print (value);
      var data =value.body;
      List<Battery> batteries=[];
      for(var JSONItem in data['batteries']){
        batteries.add(Battery.fromJson(JSONItem));
      }
      List<CarProperty> carProperties=[];
      for(var JSONItem in data['carProperties']){
        carProperties.add(CarProperty.fromJson(JSONItem));
      }
      List<CarType> carTypes=[];
      for(var JSONItem in data['carTypes']){
        carTypes.add(CarType.fromJson(JSONItem));
      }
      List<Market> markets=[];
      for(var JSONItem in data['markets']){
        markets.add(Market.fromJson(JSONItem));
      }
      emit(InitDataLoaded(batteries,carTypes,carProperties,markets));
    }).catchError((e){
      print('InitDataCubit $e');
    });
  }
}
