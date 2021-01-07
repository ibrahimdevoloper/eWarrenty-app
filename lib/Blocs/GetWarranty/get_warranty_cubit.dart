import 'package:bloc/bloc.dart';
import 'package:ewarrenty/Models/battery.dart';
import 'package:ewarrenty/Models/car_property.dart';
import 'package:ewarrenty/Models/car_type.dart';
import 'package:ewarrenty/Models/market.dart';
import 'package:ewarrenty/Models/warranty.dart';
import 'package:meta/meta.dart';

part 'get_warranty_state.dart';

class GetWarrantyCubit extends Cubit<GetWarrantyState> {
  GetWarrantyCubit() : super(GetWarrantyInitial());
}
