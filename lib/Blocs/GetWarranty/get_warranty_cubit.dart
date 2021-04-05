import 'package:bloc/bloc.dart';
import 'package:ewarrenty/Function/FirebaseCrashlyticsLog.dart';
import 'package:ewarrenty/Models/warranty.dart';
import 'package:ewarrenty/services/getWarranty/GetWarrantyService.dart';
import 'package:meta/meta.dart';

part 'get_warranty_state.dart';

class GetWarrantyCubit extends Cubit<GetWarrantyState> {
  Warranty _warranty;
  GetWarrantyService _getWarrantyService = GetWarrantyService.create();

  GetWarrantyCubit() : super(GetWarrantyInitial());

  getWarrantyDetail({@required String code, @required Function onDone}) {
    // Map<String, dynamic> map = Map<String, dynamic>();
    // if (code != null) {
    //   map['code'] = code;
    // }

    emit(GetWarrantyLoading());
    _getWarrantyService.getWarrenty(code).then((value) {
      if (value.statusCode >= 200 && value.statusCode <= 299) {
        var data = value.body['data'];
        // print(data);
        _warranty = Warranty.fromJson(data);
        emit(GetWarrantyLoaded(Warranty.fromJson(data)));
        onDone.call();
      }
      // else if (value.statusCode == 400) {
      //   print("error :400 ,${value.error} ");
      //   var error = getJSONMap(value.error);
      //   var errorArabic = error['messageAr'];
      //   var errorEnglish = error['messageEn'];
      //   emit(GetWarrantyError(errorArabic, errorEnglish));
      // } else if (value.statusCode == 404) {
      //   var error = getJSONMap(value.error);
      //   var errorArabic = error['messageAr'];
      //   var errorEnglish = error['messageEn'];
      //   emit(GetWarrantyError(errorArabic, errorEnglish));
      // }
      else {
        firebaseCrashLog(
          code: value.statusCode.toString(),
          tag: "GetWarrantyCubit.getWarrantyDetail",
          message: value.error.toString(),
        );
        emit(
          GetWarrantyError("خطأ بالاتصال: ${value.statusCode}",
              "Connection Error: ${value.statusCode}"),
        );
      }
    })
      ..catchError((e) {
        // print(e);
        firebaseCrashLog(
          tag: "GetWarrantyCubit.getWarrantyDetail",
          message: e.toString(),
        );
        emit(GetWarrantyError(
          "تأكد من اتصالك بالانترنيت",
          "check your internet connection",
        ));
        // emit(GetWarrantyError("check your internet connection",
        //     "check your internet connection "));
      });
  }

  Warranty get warranty => _warranty;

  set warranty(Warranty value) {
    _warranty = value;
  }
}
