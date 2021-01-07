import 'package:bloc/bloc.dart';
import 'package:ewarrenty/Models/battery.dart';
import 'package:ewarrenty/Models/car_property.dart';
import 'package:ewarrenty/Models/car_type.dart';
import 'package:ewarrenty/Models/market.dart';
import 'package:meta/meta.dart';

part 'init_data_state.dart';

class InitDataCubit extends Cubit<InitDataState> {
  InitDataCubit() : super(InitDataInitial());
}
