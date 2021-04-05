import 'package:country_code_picker/country_code.dart';
import 'package:email_validator/email_validator.dart';
import 'package:ewarrenty/Blocs/AddMarket/add_market_cubit.dart';
import 'package:ewarrenty/Blocs/InitData/init_data_cubit.dart';
import 'package:ewarrenty/Models/market.dart';
import 'package:ewarrenty/Wrappers/ResponsiveSafeArea.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../app_localizations.dart';

class AddMarketBottomSheet extends StatefulWidget {
  @override
  _AddMarketBottomSheetState createState() => _AddMarketBottomSheetState();

  final CountryCode _countryCode;

  AddMarketBottomSheet({@required CountryCode countryCode})
      : this._countryCode = countryCode;
}

class _AddMarketBottomSheetState extends State<AddMarketBottomSheet> {
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(builder: (context, snapshot) {
      return Scaffold(
        body: BlocConsumer<AddMarketCubit, AddMarketState>(
          cubit: BlocProvider.of<AddMarketCubit>(context),
          listenWhen: (previous, current) {
            // print("AddMarketLoaded IS TRUE: ${current is AddMarketLoaded}");
            // print("AddMarketLoaded IS TRUE: ${current}");
            return current is AddMarketError || current is AddMarketLoaded;
          },
          listener: (context, state) {
            if (state is AddMarketError) {
              //TODO:
              var snackbar = SnackBar(
                content: Text(
                  AppLocalizations.of(context)
                          .locale
                          .languageCode
                          .contains("ar")
                      ? state.errorArabic
                      : state.errorEnglish,
                ),
              );
              Scaffold.of(context).showSnackBar(snackbar);
            }
            if (state is AddMarketLoaded) {
              // print("AddMarketBottomSheet ${state.market}");
              Navigator.of(context).pop<Market>(state.market);
            }
          },
          buildWhen: (previous, current) {
            return current is AddMarketInitial ||
                // current is AddMarketEmailReset ||
                // current is AddMarketEmailError ||
                // current is AddMarketPhoneNumberReset ||
                // current is AddMarketPhoneNumberError ||
                current is AddMarketLoading ||
                current is AddMarketError;
            // current is AddMarketLoaded;
            // current is AddMarketNameReset ||
            // current is AddMarketNameError ||
            // current is AddMarketAddressReset ||
            // current is AddMarketAddressError ;
          },
          builder: (context, state) {
            if (state is AddMarketInitial)
              return InitialAddMarketWidget(
                nameTextEditingController: nameTextEditingController,
                addressTextEditingController: addressTextEditingController,
                phoneNumberTextEditingController:
                    phoneNumberTextEditingController,
                emailTextEditingController: emailTextEditingController,
              );
            else if (state is AddMarketLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (state is AddMarketError)
              return InitialAddMarketWidget(
                nameTextEditingController: nameTextEditingController,
                addressTextEditingController: addressTextEditingController,
                phoneNumberTextEditingController:
                    phoneNumberTextEditingController,
                emailTextEditingController: emailTextEditingController,
              );
            else if (state is AddMarketLoaded)
              return InitialAddMarketWidget(
                nameTextEditingController: nameTextEditingController,
                addressTextEditingController: addressTextEditingController,
                phoneNumberTextEditingController:
                    phoneNumberTextEditingController,
                emailTextEditingController: emailTextEditingController,
              );
          },
        ),
      );
    });
  }
}

// class AddMarketBottomSheet extends StatelessWidget {
//   TextEditingController addressTextEditingController = TextEditingController();
//   TextEditingController nameTextEditingController = TextEditingController();
//   TextEditingController phoneNumberTextEditingController =
//       TextEditingController();
//   TextEditingController emailTextEditingController = TextEditingController();
//
//
//
//
// }

class InitialAddMarketWidget extends StatefulWidget {
  final TextEditingController nameTextEditingController;
  final TextEditingController addressTextEditingController;
  final TextEditingController phoneNumberTextEditingController;
  final TextEditingController emailTextEditingController;

  const InitialAddMarketWidget({
    Key key,
    @required this.nameTextEditingController,
    @required this.addressTextEditingController,
    @required this.phoneNumberTextEditingController,
    @required this.emailTextEditingController,
  }) : super(key: key);

  @override
  _InitialAddMarketWidgetState createState() => _InitialAddMarketWidgetState();
}

class _InitialAddMarketWidgetState extends State<InitialAddMarketWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 16),
            child: NameTextField(
                nameTextEditingController: widget.nameTextEditingController),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: AddressTextField(
                addressTextEditingController:
                    widget.addressTextEditingController),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: PhoneNumberTextField(
                phoneNumberTextEditingController:
                    widget.phoneNumberTextEditingController),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: EmailTextField(
                emailTextEditingController: widget.emailTextEditingController),
          ),
          RaisedButton(
            child: Text(AppLocalizations.of(context).translate("submit")),
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              AddMarketCubit mCubit = BlocProvider.of<AddMarketCubit>(context);
              if (mCubit.name == null) {
                mCubit.isNameError = true;
                mCubit.emit(AddMarketNameError());
              } else if (mCubit.name.isEmpty) {
                mCubit.isNameError = true;
                mCubit.emit(AddMarketNameError());
              }

              if (mCubit.address == null) {
                mCubit.emit(AddMarketAddressError());
                mCubit.isAddressError = true;
              } else if (mCubit.address.isEmpty) {
                mCubit.isAddressError = true;
                mCubit.emit(AddMarketAddressError());
              }

              if (mCubit.phoneNumber == null) {
                mCubit.emit(AddMarketPhoneNumberError());
                mCubit.isPhoneNumberError = true;
              } else if (mCubit.phoneNumber.isEmpty) {
                mCubit.isPhoneNumberError = true;
                mCubit.emit(AddMarketPhoneNumberError());
              }
              // if (mCubit.email == null) {
              //   mCubit.emit(AddMarketEmailError());
              // }
              if (mCubit.getValidation()) {
                BlocProvider.of<AddMarketCubit>(context).sendNewMarket(
                    // onDone: () {
                    //   var snackBar = SnackBar(
                    //     content: Text("jksdvbjkbkjbjkbsdvbkj"),
                    //     duration: Duration(milliseconds: 600),
                    //   );
                    //   Scaffold.of(context).showSnackBar(snackBar);
                    //   // Navigator.pop(
                    //   //     context, BlocProvider.of<AddMarketCubit>(context).market);
                    // },
                    );
              } else {
                var snackBar = SnackBar(
                  content: Text(AppLocalizations.of(context)
                      .translate("pleaseCheckYourInfomation")),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
            },
          ),
          // Expanded(
          //   child: Center(
          //     child: Image.asset(
          //       "assets/images/logo.png",
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// class InitialAddMarketWidget extends StatelessWidget {
//   const InitialAddMarketWidget({
//     Key key,
//     @required this.nameTextEditingController,
//     @required this.addressTextEditingController,
//     @required this.phoneNumberTextEditingController,
//     @required this.emailTextEditingController,
//   }) : super(key: key);
//
//   final TextEditingController nameTextEditingController;
//   final TextEditingController addressTextEditingController;
//   final TextEditingController phoneNumberTextEditingController;
//   final TextEditingController emailTextEditingController;
//
//
// }

class NameTextField extends StatelessWidget {
  const NameTextField({
    Key key,
    @required TextEditingController nameTextEditingController,
    // @required FocusNode addressFieldNode,
  })  : _nameTextEditingController = nameTextEditingController,
        // _addressFieldNode = addressFieldNode,
        super(key: key);

  final TextEditingController _nameTextEditingController;

  // final FocusNode _addressFieldNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMarketCubit, AddMarketState>(
      cubit: BlocProvider.of<AddMarketCubit>(context),
      buildWhen: (previous, current) {
        return current is AddMarketNameReset || current is AddMarketNameError;
      },
      builder: (context, state) => TextFormField(
        onTap: () {
          // BlocProvider.of<AddMarketCubit>(context).addressIsError = false;
          BlocProvider.of<AddMarketCubit>(context).emit(AddMarketNameReset());
          BlocProvider.of<AddMarketCubit>(context).isNameError = false;
        },
        controller: _nameTextEditingController,
        // focusNode: _addressFieldNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        inputFormatters: [
          AppLocalizations.of(context).locale.languageCode.contains("ar")
              ? FilteringTextInputFormatter.allow(
                  RegExp(r"[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FF ]"))
              : FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]')),
        ],
        decoration: InputDecoration(
          errorText: (state is AddMarketNameError ||
                  BlocProvider.of<AddMarketCubit>(context).isNameError)
              ? AppLocalizations.of(context).translate("addYourMarketName")
              : null,
          labelText:
              AppLocalizations.of(context).translate("addYourMarketNameError"),
          // labelStyle: TextStyle(
          //   color: _addressFieldNode.hasFocus
          //       ? Theme.of(context).accentColor
          //       : Colors.blue,
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
            ),
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius:
          //       BorderRadius.all(Radius.circular(4.0)),
          //   borderSide:
          //       BorderSide(color: Colors.black45),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius:
          //       BorderRadius.all(Radius.circular(4.0)),
          //   borderSide: BorderSide(
          //       color: Theme.of(context).primaryColor),
          // ),
        ),
        onChanged: (value) {
          BlocProvider.of<AddMarketCubit>(context).name = value;
        },
      ),
    );
  }
}

class AddressTextField extends StatelessWidget {
  const AddressTextField({
    Key key,
    @required TextEditingController addressTextEditingController,
    // @required FocusNode addressFieldNode,
  })  : _addressTextEditingController = addressTextEditingController,
        // _addressFieldNode = addressFieldNode,
        super(key: key);

  final TextEditingController _addressTextEditingController;

  // final FocusNode _addressFieldNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMarketCubit, AddMarketState>(
      cubit: BlocProvider.of<AddMarketCubit>(context),
      buildWhen: (previous, current) {
        return current is AddMarketAddressReset ||
            current is AddMarketAddressError;
      },
      builder: (context, state) => TextFormField(
        onTap: () {
          // BlocProvider.of<AddMarketCubit>(context).addressIsError = false;
          BlocProvider.of<AddMarketCubit>(context)
              .emit(AddMarketAddressReset());
          BlocProvider.of<AddMarketCubit>(context).isAddressError = false;
        },
        controller: _addressTextEditingController,
        // focusNode: _addressFieldNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        inputFormatters: [
          AppLocalizations.of(context).locale.languageCode.contains("ar")
              ? FilteringTextInputFormatter.allow(
                  RegExp(r"[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FF ]"))
              : FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]')),
        ],
        decoration: InputDecoration(
          errorText: (state is AddMarketAddressError ||
                  BlocProvider.of<AddMarketCubit>(context).isAddressError)
              ? AppLocalizations.of(context)
                  .translate("addYourMarketAddressError")
              : null,
          labelText:
              AppLocalizations.of(context).translate("addYourMarketAddress"),
          // labelStyle: TextStyle(
          //   color: _addressFieldNode.hasFocus
          //       ? Theme.of(context).accentColor
          //       : Colors.blue,
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
            ),
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius:
          //       BorderRadius.all(Radius.circular(4.0)),
          //   borderSide:
          //       BorderSide(color: Colors.black45),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius:
          //       BorderRadius.all(Radius.circular(4.0)),
          //   borderSide: BorderSide(
          //       color: Theme.of(context).primaryColor),
          // ),
        ),
        onChanged: (value) {
          BlocProvider.of<AddMarketCubit>(context).address = value;
        },
      ),
    );
  }
}

class PhoneNumberTextField extends StatelessWidget {
  const PhoneNumberTextField({
    Key key,
    @required TextEditingController phoneNumberTextEditingController,
  })  : _phoneNumberTextEditingController = phoneNumberTextEditingController,
        super(key: key);

  final TextEditingController _phoneNumberTextEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMarketCubit, AddMarketState>(
      cubit: BlocProvider.of<AddMarketCubit>(context),
      buildWhen: (previous, current) {
        return current is AddMarketPhoneNumberError ||
            current is AddMarketPhoneNumberReset;
        // ||
        // current is InitDataPhoneNumberCountryCode;
      },
      builder: (context, state) {
        if (state is AddMarketPhoneNumberError)
          return TextFormField(
            onTap: () {
              // BlocProvider.of<AddMarketCubit>(context).phoneNumberIsError =
              //     false;
              BlocProvider.of<AddMarketCubit>(context)
                  .emit(AddMarketPhoneNumberReset());
              BlocProvider.of<AddMarketCubit>(context).isPhoneNumberError =
                  false;
            },
            controller: _phoneNumberTextEditingController,
            // keyboardType: TextInputType.phone,
            // focusNode: _phoneNumberFieldNode,
            onFieldSubmitted: (value) {
              FocusScope.of(context).unfocus();
            },
            textDirection: TextDirection.ltr,
            inputFormatters: [
              new WhitelistingTextInputFormatter(RegExp("[0-9]"))
            ],
            decoration: InputDecoration(
              hintText:
                  AppLocalizations.of(context).translate("phoneNumberExample"),
              prefix: AppLocalizations.of(context)
                          .locale
                          .languageCode
                          .contains("en") &&
                      BlocProvider.of<AddMarketCubit>(context).countryCode !=
                          null
                  ? Text(
                      BlocProvider.of<AddMarketCubit>(context)
                          .countryCode
                          .dialCode,
                      textDirection: TextDirection.ltr)
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              suffix: AppLocalizations.of(context)
                          .locale
                          .languageCode
                          .contains("ar") &&
                      BlocProvider.of<AddMarketCubit>(context).countryCode !=
                          null
                  ? Text(
                      BlocProvider.of<AddMarketCubit>(context)
                          .countryCode
                          .dialCode,
                      textDirection: TextDirection.ltr)
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              errorText: (state is InitDataPhoneNumberError ||
                      BlocProvider.of<AddMarketCubit>(context)
                          .isPhoneNumberError)
                  ? AppLocalizations.of(context)
                      .translate("addYourMarketPhoneNumberError")
                  : null,
              labelText: AppLocalizations.of(context)
                  .translate("addYourMarketPhoneNumber"),
              // labelStyle: TextStyle(
              //   color: _phoneNumberFieldNode.hasFocus
              //       ? Theme.of(context).accentColor
              //       : Colors.blue,
              // ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
              ),
              // enabledBorder: OutlineInputBorder(
              //   borderRadius:
              //       BorderRadius.all(Radius.circular(4.0)),
              //   borderSide:
              //       BorderSide(color: Colors.black45),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   borderRadius:
              //       BorderRadius.all(Radius.circular(4.0)),
              //   borderSide: BorderSide(
              //       color: Theme.of(context).primaryColor),
              // ),
            ),
            onChanged: (value) {
              BlocProvider.of<AddMarketCubit>(context).phoneNumber = value;
            },
          );
        else if (state is AddMarketPhoneNumberReset)
          return TextFormField(
            onTap: () {
              // BlocProvider.of<AddMarketCubit>(context).phoneNumberIsError =
              //     false;
              BlocProvider.of<AddMarketCubit>(context)
                  .emit(AddMarketPhoneNumberReset());
              BlocProvider.of<AddMarketCubit>(context).isPhoneNumberError =
                  false;
            },
            controller: _phoneNumberTextEditingController,
            // keyboardType: TextInputType.phone,
            // focusNode: _phoneNumberFieldNode,
            onFieldSubmitted: (value) {
              FocusScope.of(context).unfocus();
            },
            textDirection: TextDirection.ltr,
            inputFormatters: [
              new WhitelistingTextInputFormatter(RegExp("[0-9]"))
            ],
            decoration: InputDecoration(
              hintText:
                  AppLocalizations.of(context).translate("phoneNumberExample"),
              prefix: AppLocalizations.of(context)
                          .locale
                          .languageCode
                          .contains("en") &&
                      BlocProvider.of<AddMarketCubit>(context).countryCode !=
                          null
                  ? Text(
                      BlocProvider.of<AddMarketCubit>(context)
                          .countryCode
                          .dialCode,
                      textDirection: TextDirection.ltr)
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              suffix: AppLocalizations.of(context)
                          .locale
                          .languageCode
                          .contains("ar") &&
                      BlocProvider.of<AddMarketCubit>(context).countryCode !=
                          null
                  ? Text(
                      BlocProvider.of<AddMarketCubit>(context)
                          .countryCode
                          .dialCode,
                      textDirection: TextDirection.ltr)
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              errorText: (state is AddMarketPhoneNumberError ||
                      BlocProvider.of<AddMarketCubit>(context)
                          .isPhoneNumberError)
                  ? AppLocalizations.of(context)
                      .translate("addYourMarketPhoneNumberError")
                  : null,
              labelText: AppLocalizations.of(context)
                  .translate("addYourMarketPhoneNumber"),
              // labelStyle: TextStyle(
              //   color: _phoneNumberFieldNode.hasFocus
              //       ? Theme.of(context).accentColor
              //       : Colors.blue,
              // ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
              ),
              // enabledBorder: OutlineInputBorder(
              //   borderRadius:
              //       BorderRadius.all(Radius.circular(4.0)),
              //   borderSide:
              //       BorderSide(color: Colors.black45),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   borderRadius:
              //       BorderRadius.all(Radius.circular(4.0)),
              //   borderSide: BorderSide(
              //       color: Theme.of(context).primaryColor),
              // ),
            ),
            onChanged: (value) {
              BlocProvider.of<AddMarketCubit>(context).phoneNumber = value;
            },
          );
        // else if (state is InitDataPhoneNumberCountryCode)
        //   return TextFormField(
        //     onTap: () {
        //       BlocProvider.of<AddMarketCubit>(context).phoneNumberIsError =
        //           false;
        //       BlocProvider.of<AddMarketCubit>(context)
        //           .emit(InitDataPhoneNumberReset());
        //     },
        //     controller: _phoneNumberTextEditingController,
        //     // keyboardType: TextInputType.phone,
        //     // focusNode: _phoneNumberFieldNode,
        //     onFieldSubmitted: (value) {
        //       FocusScope.of(context).unfocus();
        //     },
        //     textDirection: TextDirection.ltr,
        //     inputFormatters: [
        //       new WhitelistingTextInputFormatter(RegExp("[0-9]"))
        //     ],
        //     decoration: InputDecoration(
        //       hintText:
        //           AppLocalizations.of(context).translate("phoneNumberExample"),
        //       prefix: AppLocalizations.of(context)
        //               .locale
        //               .languageCode
        //               .contains("en")
        //           ? Text(state.countryCode, textDirection: TextDirection.ltr)
        //           : Container(
        //               height: 0,
        //               width: 0,
        //             ),
        //       suffix: AppLocalizations.of(context)
        //               .locale
        //               .languageCode
        //               .contains("ar")
        //           ? Text(state.countryCode, textDirection: TextDirection.ltr)
        //           : Container(
        //               height: 0,
        //               width: 0,
        //             ),
        //       errorText: ((state is InitDataPhoneNumberError) ||
        //               (BlocProvider.of<AddMarketCubit>(context)
        //                   .phoneNumberIsError))
        //           ? AppLocalizations.of(context)
        //               .translate("addYourMarketPhoneNumberError")
        //           : null,
        //       labelText: AppLocalizations.of(context)
        //           .translate("addYourMarketPhoneNumber"),
        //       // labelStyle: TextStyle(
        //       //   color: _phoneNumberFieldNode.hasFocus
        //       //       ? Theme.of(context).accentColor
        //       //       : Colors.blue,
        //       // ),
        //       enabledBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.all(Radius.circular(4.0)),
        //         borderSide: BorderSide(color: Colors.blue),
        //       ),
        //       focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.all(Radius.circular(4.0)),
        //         borderSide: BorderSide(
        //           color: Theme.of(context).accentColor,
        //         ),
        //       ),
        //       // enabledBorder: OutlineInputBorder(
        //       //   borderRadius:
        //       //       BorderRadius.all(Radius.circular(4.0)),
        //       //   borderSide:
        //       //       BorderSide(color: Colors.black45),
        //       // ),
        //       // focusedBorder: OutlineInputBorder(
        //       //   borderRadius:
        //       //       BorderRadius.all(Radius.circular(4.0)),
        //       //   borderSide: BorderSide(
        //       //       color: Theme.of(context).primaryColor),
        //       // ),
        //     ),
        //     onChanged: (value) {
        //       BlocProvider.of<AddMarketCubit>(context).phoneNumber = value;
        //     },
        //   );
        else
          return TextFormField(
            onTap: () {
              // BlocProvider.of<AddMarketCubit>(context).phoneNumberIsError =
              //     false;
              BlocProvider.of<AddMarketCubit>(context)
                  .emit(AddMarketPhoneNumberReset());
              BlocProvider.of<AddMarketCubit>(context).isPhoneNumberError =
                  false;
            },
            controller: _phoneNumberTextEditingController,
            // keyboardType: TextInputType.phone,
            textDirection: TextDirection.ltr,
            inputFormatters: [
              new WhitelistingTextInputFormatter(RegExp("[0-9]"))
            ],
            // focusNode: _phoneNumberFieldNode,
            onFieldSubmitted: (value) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              hintText:
                  AppLocalizations.of(context).translate("phoneNumberExample"),
              prefix: AppLocalizations.of(context)
                          .locale
                          .languageCode
                          .contains("en") &&
                      BlocProvider.of<AddMarketCubit>(context).countryCode !=
                          null
                  ? Text(
                      BlocProvider.of<AddMarketCubit>(context)
                          .countryCode
                          .dialCode,
                      textDirection: TextDirection.ltr)
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              suffix: AppLocalizations.of(context)
                          .locale
                          .languageCode
                          .contains("ar") &&
                      BlocProvider.of<AddMarketCubit>(context).countryCode !=
                          null
                  ? Text(
                      BlocProvider.of<AddMarketCubit>(context)
                          .countryCode
                          .dialCode,
                      textDirection: TextDirection.ltr)
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              errorText: (state is AddMarketPhoneNumberError ||
                      BlocProvider.of<AddMarketCubit>(context)
                          .isPhoneNumberError)
                  ? AppLocalizations.of(context)
                      .translate("addYourMarketPhoneNumberError")
                  : null,
              labelText: AppLocalizations.of(context)
                  .translate("addYourMarketPhoneNumber"),
              // labelStyle: TextStyle(
              //   color: _phoneNumberFieldNode.hasFocus
              //       ? Theme.of(context).accentColor
              //       : Colors.blue,
              // ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
              ),
              // enabledBorder: OutlineInputBorder(
              //   borderRadius:
              //       BorderRadius.all(Radius.circular(4.0)),
              //   borderSide:
              //       BorderSide(color: Colors.black45),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   borderRadius:
              //       BorderRadius.all(Radius.circular(4.0)),
              //   borderSide: BorderSide(
              //       color: Theme.of(context).primaryColor),
              // ),
            ),
            onChanged: (value) {
              BlocProvider.of<AddMarketCubit>(context).phoneNumber = value;
            },
          );
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key key,
    @required TextEditingController emailTextEditingController,
  })  : _emailTextEditingController = emailTextEditingController,
        super(key: key);

  final TextEditingController _emailTextEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMarketCubit, AddMarketState>(
      cubit: BlocProvider.of<AddMarketCubit>(context),
      buildWhen: (previous, current) {
        return current is AddMarketEmailError || current is AddMarketEmailReset;
      },
      builder: (context, state) => TextFormField(
        // focusNode: _emailFieldNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        onTap: () {
          BlocProvider.of<AddMarketCubit>(context).isEmailError = false;
          BlocProvider.of<AddMarketCubit>(context).emit(AddMarketEmailReset());
        },
        controller: _emailTextEditingController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate("emailExample"),
          errorText: state is AddMarketEmailError
              ? AppLocalizations.of(context)
                  .translate("addYourMarketEmailError")
              : null,
          labelText:
              AppLocalizations.of(context).translate("addYourMarketEmail"),
          // labelStyle: TextStyle(
          //   color: _emailFieldNode.hasFocus
          //       ? Theme.of(context).accentColor
          //       : Colors.blue,
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
            ),
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius:
          //       BorderRadius.all(Radius.circular(4.0)),
          //   borderSide:
          //       BorderSide(color: Colors.black45),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius:
          //       BorderRadius.all(Radius.circular(4.0)),
          //   borderSide: BorderSide(
          //       color: Theme.of(context).primaryColor),
          // ),
        ),
        onChanged: (value) {
          BlocProvider.of<AddMarketCubit>(context).email = value;
          // BlocProvider.of<AddMarketCubit>(context).eMailIsError =
          //     !EmailValidator.validate(value);
          if (!EmailValidator.validate(value) && value != null) {
            BlocProvider.of<AddMarketCubit>(context)
                .emit(AddMarketEmailError());
            BlocProvider.of<AddMarketCubit>(context).isEmailError = true;
          } else {
            BlocProvider.of<AddMarketCubit>(context)
                .emit(AddMarketEmailReset());
            BlocProvider.of<AddMarketCubit>(context).isEmailError = false;
          }
        },
      ),
    );
  }
}
