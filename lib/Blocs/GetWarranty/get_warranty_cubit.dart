import 'package:bloc/bloc.dart';
import 'package:ewarrenty/Blocs/InitData/init_data_cubit.dart';
import 'package:ewarrenty/Function/getJSONMap.dart';
import 'package:ewarrenty/Models/battery.dart';
import 'package:ewarrenty/Models/car_property.dart';
import 'package:ewarrenty/Models/car_type.dart';
import 'package:ewarrenty/Models/market.dart';
import 'package:ewarrenty/Models/warranty.dart';
import 'package:ewarrenty/services/getWarranty/GetWarrantyService.dart';
import 'package:ewarrenty/services/initData/InitDataService.dart';
import 'package:meta/meta.dart';

part 'get_warranty_state.dart';

class GetWarrantyCubit extends Cubit<GetWarrantyState> {
  Warranty _warranty;
  GetWarrantyService _getWarrantyService = GetWarrantyService.create();

  GetWarrantyCubit() : super(GetWarrantyInitial());

  getWarrantyDetail({@required String code,
    @required Function onDone
  }) {
    Map<String, dynamic> map = Map<String, dynamic>();
    if (code != null) {
      map['code'] = code;
    }

    emit(GetWarrantyLoading());
    _getWarrantyService.getWarrenty(map).then(
            (value) {
          if (value.statusCode == 200) {
            var data = value.body['data'];
            print(data);
            _warranty = Warranty.fromJson(data);
            emit(GetWarrantyLoaded(Warranty.fromJson(data)));
            onDone.call();
          } else if (value.statusCode == 400) {
            print("error :400 ,${value.error} ");
            var error = getJSONMap(value.error);
            var errorArabic = error['messageAr'];
            var errorEnglish = error['messageEn'];
            emit(GetWarrantyError(errorArabic, errorEnglish));
          } else if (value.statusCode == 404) {
            var error = getJSONMap(value.error);
            var errorArabic = error['messageAr'];
            var errorEnglish = error['messageEn'];
            emit(GetWarrantyError(errorArabic, errorEnglish));
          }
        }
    )..catchError((e) {
      print(e);
      //TODO: taranslate "check your internet connection "
      emit(GetWarrantyError("check your internet connection",
          "check your internet connection "));
    });
  }

  Warranty get warranty => _warranty;

  set warranty(Warranty value) {
    _warranty = value;
  }
}
