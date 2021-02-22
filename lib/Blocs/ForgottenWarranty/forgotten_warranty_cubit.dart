import 'package:bloc/bloc.dart';
import 'package:ewarrenty/Models/warranty.dart';
import 'package:ewarrenty/services/getForgottenWarrantyByEmail/GetForgottenWarrantyByEmailService.dart';
import 'package:ewarrenty/services/getForgottenWarrantyByPhoneNumber/GetForgottenWarrantyByPhoneNumberService.dart';
import 'package:meta/meta.dart';

part 'forgotten_warranty_state.dart';

class ForgottenWarrantyCubit extends Cubit<ForgottenWarrantyState> {
  String _eMail;
  bool _emailIsError = false;
  String _phoneNumber;
  bool _phoneNumberIsError = false;
  List<Warranty> _warranties = List<Warranty>();

  GetForgottenWarrantyByEmailService _emailService;
  GetForgottenWarrantyByPhoneNumberService _phoneNumberService;

  ForgottenWarrantyCubit() : super(ForgottenWarrantyInitial()) {
    _emailService = GetForgottenWarrantyByEmailService.create();
    _phoneNumberService = GetForgottenWarrantyByPhoneNumberService.create();
  }

  getWarrantyByEmail(String email) {
    // emit(ForgottenWarrantyLoading());
    // _emailService.getWarrenties(email)
    emit(ForgottenWarrantyLoading());
    print("getWarrantyByEmail");
    _emailService.getWarrenties(email).then((value) {
      if (value.statusCode >= 200 && value.statusCode <= 299) {
        var data = value.body['data'];
        print(data);
        if (_warranties.isNotEmpty) _warranties.clear();
        data.forEach(
          (element) {
            _warranties.add(Warranty.fromJson(element));
          },
        );
        // _warranty = Warranty.fromJson(data);
        // print(_warranties );
        if (_warranties.isEmpty)
          emit(
            ForgottenWarrantyError("no warranties are linked with this email",
                "no warranties are linked with this email"),
          );
        emit(ForgottenWarrantyLoaded(_warranties));
      } else {
        emit(
          ForgottenWarrantyError(
              "Error${value.statusCode}: please check with customer service",
              "Error${value.statusCode}: please check with customer service"),
        );
      }
    })
      ..catchError((e) {
        print(e);
        //TODO: taranslate "check your internet connection "
        emit(ForgottenWarrantyError("check your internet connection",
            "check your internet connection "));
      });
  }

  getWarrantyByPhoneNumber(String phoneNumber) {
    // emit(ForgottenWarrantyLoading());
    // _emailService.getWarrenties(email)
    emit(ForgottenWarrantyLoading());
    print("getWarrantyByEmail");
    _phoneNumberService.getWarrenties(phoneNumber).then((value) {
      if (value.statusCode >= 200 && value.statusCode <= 299) {
        var data = value.body['data'];
        print(data);
        if (_warranties.isNotEmpty) _warranties.clear();
        data.forEach(
          (element) {
            _warranties.add(Warranty.fromJson(element));
          },
        );
        // _warranty = Warranty.fromJson(data);
        // print(_warranties );
        if (_warranties.isEmpty)
          emit(
            ForgottenWarrantyError(
                "no warranties are linked with this phone number",
                "no warranties are linked with this phone number"),
          );
        emit(ForgottenWarrantyLoaded(_warranties));
      } else {
        emit(
          ForgottenWarrantyError(
              "Error${value.statusCode}: please check with customer service",
              "Error${value.statusCode}: please check with customer service"),
        );
      }
    })
      ..catchError((e) {
        print(e);
        //TODO: taranslate "check your internet connection "
        emit(ForgottenWarrantyError("check your internet connection",
            "check your internet connection "));
      });
  }

  bool get phoneNumberIsError => _phoneNumberIsError;

  set phoneNumberIsError(bool value) {
    _phoneNumberIsError = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  bool get emailIsError => _emailIsError;

  set emailIsError(bool value) {
    _emailIsError = value;
  }

  String get eMail => _eMail;

  set eMail(String value) {
    _eMail = value;
  }
}
