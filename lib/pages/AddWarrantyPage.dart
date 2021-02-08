import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:ewarrenty/Blocs/InitData/init_data_cubit.dart';
import 'package:ewarrenty/Constants/Constants.dart';
import 'package:ewarrenty/Function/myImagePicker.dart';
import 'package:ewarrenty/Icons/warranty_icons_icons.dart';
import 'package:ewarrenty/Models/Battery.dart';
import 'package:ewarrenty/Models/market.dart';
import 'package:ewarrenty/Wrappers/SuggestionsBoxWrapper.dart';
import 'package:ewarrenty/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ewarrenty/dialogs/whereIsSerialNumberDialog.dart';
import 'package:ewarrenty/Wrappers/DropdownBoxWrapper.dart';
import 'package:ewarrenty/dialogs/showSummeryDialog.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ewarrenty/CustomWidget/ImagePreviewButton.dart';


class AddWarrantyPage extends StatefulWidget {
  @override
  _AddWarrantyPageState createState() => _AddWarrantyPageState();
}

class _AddWarrantyPageState extends State<AddWarrantyPage> {
  var _batteryTextEditingController = TextEditingController();
  var _serialTextEditingNumberController = TextEditingController();
  var _marketTextEditingController = TextEditingController();

  var _fullNameTextEditingController = TextEditingController();
  var _addressTextEditingController = TextEditingController();
  var _emailTextEditingController = TextEditingController();
  var _phoneNumberTextEditingController = TextEditingController();
  var _carNumberTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InitDataCubit>(
      create: (context) => InitDataCubit(),
      child: BlocBuilder<InitDataCubit, InitDataState>(
        buildWhen: (previous, current) {
          print("ModalProgressHUD: $current");
          return true;
        },
        builder: (context, state) => ModalProgressHUD(
          inAsyncCall: state is InitDataSubmitLoading,
          child: Scaffold(
            appBar: AppBar(
              title:
                  Text(AppLocalizations.of(context).translate("addWarranty"),style:GoogleFonts.cairo() ,),
            ),
            bottomNavigationBar: BlocBuilder<InitDataCubit, InitDataState>(
              builder: (context, state) => FlatButton(height: 56,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(AppLocalizations.of(context).translate("submit"),
                style: GoogleFonts.cairo(
                  fontSize: Theme.of(context).textTheme.headline6.fontSize
                ),),
                onPressed: () {
                  print("submit");
                  //TODO: submit button
                  InitDataCubit mCubit =
                      BlocProvider.of<InitDataCubit>(context);
                  if (mCubit.battery == null) {
                    mCubit.batteryIsError = true;
                    mCubit.emit(InitDataBatteryChoosenTextFieldError());
                    var snackBar = SnackBar(
                      content: Text(AppLocalizations.of(context).translate("pleaseChooseBatteryModel")),
                      duration: Duration(milliseconds: 600),
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.billDate == null) {
                    mCubit.emit(InitDataBillDateError());
                    mCubit.billDateIsError = true;
                    var snackBar = SnackBar(
                      content: Text(AppLocalizations.of(context).translate("chooseBillDate")),
                      duration: Duration(milliseconds: 600),
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.serialNumber == null) {
                    //TODO: tanslate "add Serial Number"
                    mCubit.emit(InitDataSerialNumberError());
                    mCubit.serialNumberIsError = true;
                    // var snackBar = SnackBar(
                    //   content: Text("Please Add Serial Number"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.fullName == null) {
                    //TODO: tanslate "Please Add Your Full Name In English"
                    mCubit.emit(InitDataFullNameError());
                    mCubit.fullNameIsError = true;
                    // var snackBar = SnackBar(
                    //   content: Text("Please Your Full Name In English"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.address == null) {
                    //TODO: tanslate "Please Add Your Address In English"
                    mCubit.emit(InitDataAddressError());
                    mCubit.addressIsError = true;
                    // var snackBar = SnackBar(
                    //   content: Text("Please Add Your Address In English"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.eMail == null) {
                    //TODO: tanslate "Please Add Your E-mail"
                    mCubit.emit(InitDataEmailError());
                    mCubit.eMailIsError = true;
                    // var snackBar = SnackBar(
                    //   content: Text("Please Add Your E-mail"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.phoneNumber == null) {
                    //TODO: tanslate "Please Add Your phone number"
                    mCubit.emit(InitDataPhoneNumberError());
                    mCubit.phoneNumberIsError = true;
                    // var snackBar = SnackBar(
                    //   content: Text("Please Add Your phone number"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.carPropertyId == null) {
                    //TODO: tanslate "Please Add Your Car Property Type"
                    // mCubit.emit(InitDataCarNumberError());
                    mCubit.carPropertyIdIsError = true;
                    // var snackBar = SnackBar(
                    //   content: Text("Please Add Your Car Property Type"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.carTypeId == null) {
                    //TODO: tanslate "Please Add Your Car Type"
                    // mCubit.emit(InitDataCarTypeError());
                    mCubit.carTypeIdIsError = true;
                    // var snackBar = SnackBar(
                    //   content: Text("Please Add Your Car Type"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.carNumber == null) {
                    //TODO: tanslate "Please Add Your Car Type"
                    // mCubit.emit(InitDataCarTypeError());
                    mCubit.carNumberIsError = true;
                    // var snackBar = SnackBar(
                    //   content: Text("Please Add Your Car Type"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.country == null) {
                    //TODO: tanslate "Please Add Your Country"
                    mCubit.emit(InitDataCountryError());
                    mCubit.countryIsError = true;
                    // var snackBar = SnackBar(
                    //   content: Text("Please Add Your Country"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.market == null) {
                    //TODO: tanslate "Please Add Your Market"
                    mCubit.emit(InitDataMarketError());
                    mCubit.marketIsError = true;
                    // var snackBar = SnackBar(
                    //   content: Text("Please Add Your Market"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.frontBatteryPath == null) {
                    //TODO: tanslate "Please capture Your battery front"
                    // var snackBar = SnackBar(
                    //   content: Text("Please capture Your battery front"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.fixedBatteryPath == null) {
                    //TODO: tanslate "Please capture Your fixed battery"
                    // var snackBar = SnackBar(
                    //   content: Text("Please capture Your fixed battery"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.carNumberPath == null) {
                    //TODO: tanslate "Please capture Your car"
                    // var snackBar = SnackBar(
                    //   content: Text("Please capture Your Car "),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.carTypeId == null) {
                    //TODO: tanslate "Please capture Your car"
                    mCubit.emit(InitDataCarTypeError());
                    mCubit.carTypeIdIsError = true;

                    // var snackBar = SnackBar(
                    //   content: Text("Please capture Your Car "),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.carPropertyId == null) {
                    //TODO: tanslate "Please capture Your car"
                    mCubit.emit(InitDataCarPropertyError());
                    mCubit.carPropertyIdIsError = true;
                    // var snackBar = SnackBar(
                    //   content: Text("Please capture Your Car "),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  // print(mCubit.toString());
                  var finalValidation = mCubit.getFinalValidtion();
                  print(finalValidation);
                  if (finalValidation) {
                    // ProgressHUD.of(context).show();
                    // var snackBar = SnackBar(
                    //   content: Text(AppLocalizations.of(context).translate("pleaseCheckYourInfomation")),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                    mCubit.submitWarrantyData();
                  }
                },
              ),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/whiteback.png',
                  fit: BoxFit.cover,
                ),
                BlocConsumer<InitDataCubit, InitDataState>(
                  // cubit:BlocProvider.of<InitDataCubit>(context),
                  // ignore: missing_return
                  listenWhen: (previous, current) {
                    // print(current);
                    // print(
                    //     '''listen: ${current is InitDataSubmitSent || current is InitDataSubmitLoading || current is InitDataSubmitError}''');
                    return current is InitDataSubmitSent ||
                        current is InitDataSubmitLoading ||
                        current is InitDataSubmitError;
                  },
                  listener: (context, state) {
                    print("listener: $state");
                    // final progress = ProgressHUD.of(context);
                    if (state is InitDataSubmitLoading) {
                      // var warranty = state.warranty;
                      //TODO: show the warrenty detail.
                      // progress.show();
                    }
                    if (state is InitDataSubmitSent) {
                      // var warranty = state.warranty;
                      //TODO: show the warrenty detail.
                      // progress.dismiss();
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          // false = user must tap button, true = tap outside dialog
                          builder: (BuildContext dialogContext) =>
                              showSummeryDialog(context, state.warranty));
                    }
                    if (state is InitDataSubmitError) {
                      // progress.dismiss();
                      var snackbar = SnackBar(
                        content: Text(AppLocalizations.of(context)
                                .locale
                                .languageCode
                                .contains("ar")
                            ? state.errorArabic
                            : state.errorEnglish),
                        duration: Duration(seconds: 3),
                      );
                      Scaffold.of(context).showSnackBar(snackbar);
                    }
                  },
                  buildWhen: (previous, current) {
                    return !((current is InitDataBillDate) ||
                        (current is InitDataBatteryChosenForImage) ||
                        (current is InitDataFixedBatteryImage) ||
                        (current is InitDataFrontBatteryImage) ||
                        (current is InitDataCarNumber) ||
                        (current is InitDataBatteryChoosenTextFieldReset) ||
                        (current is InitDataBatteryChoosenTextFieldError) ||
                        (current is InitDataBillDateReset) ||
                        (current is InitDataBillDateError) ||
                        (current is InitDataSerialNumberReset) ||
                        (current is InitDataSerialNumberError) ||
                        (current is InitDataFullNameReset) ||
                        (current is InitDataFullNameError) ||
                        (current is InitDataAddressReset) ||
                        (current is InitDataAddressError) ||
                        (current is InitDataEmailReset) ||
                        (current is InitDataEmailError) ||
                        (current is InitDataPhoneNumberReset) ||
                        (current is InitDataPhoneNumberError) ||
                        (current is InitDataCarNumberReset) ||
                        (current is InitDataCarNumberError) ||
                        (current is InitDataCountryReset) ||
                        (current is InitDataCountryError) ||
                        (current is InitDataMarketReset) ||
                        (current is InitDataMarketError) ||
                        (current is InitDataSubmitError) ||
                        (current is InitDataSubmitLoading) ||
                        (current is InitDataSubmitSent) ||
                        (current is InitDataCarTypeError) ||
                        (current is InitDataCarTypeReset) ||
                        (current is InitDataCarPropertyError) ||
                        (current is InitDataCarPropertyReset));
                  },
                  builder: (context, state) {
                    if (state is InitDataInitial) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is InitDataLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is InitDataLoaded) {
                      List batteries = state.batteries;
                      List markets = state.markets;
                      List carTypes = state.carTypes;
                      List carProperties = state.carProperties;

                      // return WarrantyAddetionForm(
                      //     batteries, markets, carTypes, carProperties);
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        child: ListView(
                          shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          children: [
                            // https://pub.dev/packages/flutter_typeahead
                            SizedBox(
                              height: 8,
                            ),
                            BlocBuilder<InitDataCubit, InitDataState>(
                              buildWhen: (previous, current) {
                                // print(current is InitDataBillDate);
                                return current
                                        is InitDataBatteryChoosenTextFieldError ||
                                    current is InitDataBatteryChoosenTextFieldReset;
                              },
                              builder: (context, state) => TypeAheadFormField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  onTap: () {
                                    BlocProvider.of<InitDataCubit>(context)
                                        .batteryIsError = false;
                                    BlocProvider.of<InitDataCubit>(context).emit(
                                        InitDataBatteryChoosenTextFieldReset());
                                    _batteryTextEditingController.clear();
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: _batteryTextEditingController,
                                  decoration: InputDecoration(
                                    // TODO : fix amprage word
                                    errorText: ((state
                                                is InitDataBatteryChoosenTextFieldError) ||
                                            (BlocProvider.of<InitDataCubit>(context)
                                                .batteryIsError))
                                        ? AppLocalizations.of(context).translate("pleaseChooseBatteryModel")
                                        : null,
                                    labelText: AppLocalizations.of(context)
                                        .translate("enterBatteryAmperage"),
                                    hintText: AppLocalizations.of(context)
                                        .translate("ex40"),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4.0)),
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4.0)),
                                      borderSide:
                                          BorderSide(color: Colors.deepPurple[700]),
                                    ),
                                  ),
                                ),
                                suggestionsCallback: (pattern) {
                                  List<Battery> results = [];
                                  int searchedCapacity = 0;
                                  try {
                                    searchedCapacity = int.parse(pattern);
                                    print(searchedCapacity);
                                  } catch (e) {
                                    //TODO: handle Error
                                    print(e);
                                  }

                                  batteries.forEach((battreyModel) {
                                    if (battreyModel.capacity == searchedCapacity)
                                      results.add(battreyModel);
                                  });

                                  return results;
                                },
                                itemBuilder: (context, suggestion) {
                                  // print(suggestion is Battery);
                                  Battery suggestedBattry = suggestion;
                                  if (_batteryTextEditingController
                                      .text.isNotEmpty) {
                                    // print("$baseUrl${suggestedBattry.frontImage}");
                                    return Card(
                                      child: ExpansionTile(
                                        trailing: Icon(Icons.image),
                                        children: [
                                          // Image.network(
                                          //   suggestedBattry.image,
                                          //   fit: BoxFit.cover,
                                          // ),
                                          Container(
                                            child: CachedNetworkImage(
                                              height: 125,
                                              imageUrl:
                                                  "$baseUrl${suggestedBattry.image}",
                                              // imageUrl: "http://via.placeholder.com/350x150",
                                              // placeholder: (context,text)=>CircularProgressIndicator(),
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  Center(
                                                child: CircularProgressIndicator(
                                                    value:
                                                        downloadProgress.progress),
                                              ),
                                              errorWidget: (context, url, error) =>
                                                  Icon(Icons.error),
                                            ),
                                          ),
                                        ],
                                        title: Text(suggestedBattry.number),
                                        subtitle: Text(AppLocalizations.of(context)
                                            .translate(
                                                "pressImageIconToPreviewImage")),
                                      ),
                                    );
                                  } else
                                    return Container(
                                      width: 0,
                                      height: 0,
                                    );
                                },

                                transitionBuilder:
                                    (context, suggestionsBox, controller) {
                                  return SuggestionsBoxWrapper(
                                      AppLocalizations.of(context)
                                          .translate("PleaseChooseYourBattery"),
                                      suggestionsBox);
                                },
                                onSuggestionSelected: (suggestion) {
                                  Battery suggestedBattry = suggestion;
                                  BlocProvider.of<InitDataCubit>(context).emit(
                                      InitDataBatteryChosenForImage(
                                          suggestedBattry));
                                  BlocProvider.of<InitDataCubit>(context).battery =
                                      suggestedBattry;
                                  // print(BlocProvider.of<InitDataCubit>(context).batteryId);
                                  _batteryTextEditingController.text =
                                      suggestedBattry.number;
                                },
                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return 'Please select a city';
                                //   }
                                // },
                                // onSaved: (value) => this._selectedUser = value,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            BlocBuilder<InitDataCubit, InitDataState>(
                                buildWhen: (previous, current) {
                              // print(current is InitDataBillDate);
                              return current is InitDataBillDate ||
                                  current is InitDataBillDateError;
                            }, builder: (context, state) {
                              return FlatButton(
                                textColor: Colors.white,
                                color: ((state is InitDataBillDateError) ||
                                        (BlocProvider.of<InitDataCubit>(context)
                                            .billDateIsError))
                                    ? Colors.redAccent[700]
                                    : Theme.of(context).primaryColor,
                                child: Text(BlocProvider.of<InitDataCubit>(context)
                                        .billDate ??
                                    AppLocalizations.of(context)
                                        .translate("boughtDate")),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now()
                                        .add(Duration(days: -365 * 120)),
                                    lastDate: DateTime.now().add(Duration(days: 1)),
                                    // helpText: "Select Bill Date",
                                  ).then((value) {
                                    BlocProvider.of<InitDataCubit>(context)
                                        .billDateIsError = false;
                                    BlocProvider.of<InitDataCubit>(context)
                                            .billDate =
                                        "${value.year}-${value.month}-${value.day}";
                                    BlocProvider.of<InitDataCubit>(context).emit(
                                        InitDataBillDate(
                                            "${value.year}-${value.month}-${value.day}"));
                                    // setState(() {
                                    //   // billDate = "${value.year}-${value.month}-${value.day}";
                                    //
                                    // });
                                  })
                                    ..catchError((e) {
                                      print(e);
                                    });
                                },
                              );
                            }),
                            SizedBox(
                              height: 8,
                            ),
                            BlocBuilder<InitDataCubit, InitDataState>(
                              buildWhen: (previous, current) {
                                return current is InitDataSerialNumberError ||
                                    current is InitDataSerialNumberReset;
                              },
                              builder: (context, state) => TextFormField(
                                controller: _serialTextEditingNumberController,
                                onTap: () {
                                  BlocProvider.of<InitDataCubit>(context)
                                      .serialNumberIsError = false;
                                  BlocProvider.of<InitDataCubit>(context)
                                      .emit(InitDataSerialNumberReset());
                                },
                                decoration: InputDecoration(
                                  errorText: ((state
                                              is InitDataSerialNumberError) ||
                                          (BlocProvider.of<InitDataCubit>(context)
                                              .serialNumberIsError))
                                      ? AppLocalizations.of(context).translate("pleaseEnterSerialNumber")
                                      : null,
                                  suffixIcon: IconButton(
                                    icon: Icon(WarrantyIcons.warrenty_comment),
                                    onPressed: () {
                                      if (BlocProvider.of<InitDataCubit>(context)
                                              .battery !=
                                          null) {
                                        var serialNumberImage =
                                            BlocProvider.of<InitDataCubit>(context)
                                                .battery
                                                .serialNumberImage;
                                        var info = AppLocalizations.of(context)
                                                .locale
                                                .languageCode
                                                .contains("ar")
                                            ? BlocProvider.of<InitDataCubit>(
                                                    context)
                                                .battery
                                                .infoAr
                                            : BlocProvider.of<InitDataCubit>(
                                                    context)
                                                .battery
                                                .infoEn;
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              whereIsSerialNumberDialog(
                                            context,
                                            imageUrl: serialNumberImage,
                                            text: info,
                                          ),
                                        );
                                      } else {
                                        var snackbar = SnackBar(
                                          content: Text(
                                            AppLocalizations.of(context)
                                                .translate("SelectBatteryToHelpYouWithInstructions"),
                                        ));
                                        Scaffold.of(context).showSnackBar(snackbar);
                                      }
                                    },
                                  ),
                                  labelText: AppLocalizations.of(context)
                                      .translate("serialNumber"),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    borderSide: BorderSide(color: Colors.black45),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                onChanged: (value) {
                                  BlocProvider.of<InitDataCubit>(context)
                                      .serialNumber = value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            BlocBuilder<InitDataCubit, InitDataState>(
                              buildWhen: (previous, current) {
                                return current is InitDataFullNameError ||
                                    current is InitDataFullNameReset;
                              },
                              builder: (context, state) => TextFormField(
                                onTap: () {
                                  BlocProvider.of<InitDataCubit>(context)
                                      .fullNameIsError = false;
                                  BlocProvider.of<InitDataCubit>(context)
                                      .emit(InitDataFullNameReset());
                                },
                                controller: _fullNameTextEditingController,
                                inputFormatters: [

                                  AppLocalizations.of(context).locale.languageCode.contains("ar")? FilteringTextInputFormatter.allow(
                                      RegExp('[\p{Arabic}\s\p{N}]')):FilteringTextInputFormatter.allow(
                                      RegExp('[a-z\sA-Z]')),
                                ],
                                decoration: InputDecoration(
                                  errorText: ((state is InitDataFullNameError) ||
                                          (BlocProvider.of<InitDataCubit>(context)
                                              .addressIsError))
                                      ? AppLocalizations.of(context)
                                      .translate("addFullName")
                                      : null,
                                  labelText: AppLocalizations.of(context)
                                      .translate("yourName"),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    borderSide: BorderSide(color: Colors.black45),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                onChanged: (value) {
                                  //TODO: make the user enter his name in english
                                  BlocProvider.of<InitDataCubit>(context)
                                      .fullNameIsError = false;
                                  BlocProvider.of<InitDataCubit>(context).fullName =
                                      value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            BlocBuilder<InitDataCubit, InitDataState>(
                              buildWhen: (previous, current) {
                                return current is InitDataCountryError ||
                                    current is InitDataCountryReset;
                              },
                              builder: (context, state) => Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor,
                                        // Theme.of(context).accentColor
                                        Colors.indigo[600]
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate("country"),
                                        style: TextStyle(color: Colors.white,fontSize: 20),
                                      ),
                                      CountryCodePicker(

                                        showDropDownButton: true,
                                        textStyle: TextStyle(color: Colors.white),
                                        // showDropDownButton: true,
                                        showFlag: true,
                                        // countryFilter: ['IL'],
                                        onChanged: (countryCode) {
                                          BlocProvider.of<InitDataCubit>(context)
                                              .countryIsError = false;
                                          print(countryCode.name);
                                          BlocProvider.of<InitDataCubit>(context)
                                              .country = countryCode.name;
                                        },
                                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                        // initialSelection: 'CA',
                                        // favorite: ['+39','FR'],
                                        // optional. Shows only country name and flag
                                        showCountryOnly: true,
                                        // optional. Shows only country name and flag when popup is closed.
                                        showOnlyCountryWhenClosed: true,

                                        // optional. aligns the flag and the Text left
                                        // alignLeft: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            BlocBuilder<InitDataCubit, InitDataState>(
                              buildWhen: (previous, current) {
                                return current is InitDataAddressError ||
                                    current is InitDataAddressReset;
                              },
                              builder: (context, state) => TextFormField(
                                onTap: () {
                                  BlocProvider.of<InitDataCubit>(context)
                                      .addressIsError = false;
                                  BlocProvider.of<InitDataCubit>(context)
                                      .emit(InitDataAddressReset());
                                },
                                controller: _addressTextEditingController,
                                inputFormatters: [
                                  AppLocalizations.of(context).locale.languageCode.contains("ar")? FilteringTextInputFormatter.allow(
                                      RegExp('[\p{Arabic}\s\p{N}]')):FilteringTextInputFormatter.allow(
                                      RegExp('[a-z\sA-Z]')),
                                ],
                                decoration: InputDecoration(
                                  errorText: ((state is InitDataAddressError) ||
                                          (BlocProvider.of<InitDataCubit>(context)
                                              .addressIsError))
                                      ? AppLocalizations.of(context)
                                      .translate("addAddress")
                                      : null,
                                  labelText: AppLocalizations.of(context)
                                      .translate("yourAddress"),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    borderSide: BorderSide(color: Colors.black45),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                onChanged: (value) {
                                  //TODO: make the user enter his name in english
                                  BlocProvider.of<InitDataCubit>(context).address =
                                      value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            BlocBuilder<InitDataCubit, InitDataState>(
                              buildWhen: (previous, current) {
                                return current is InitDataEmailError ||
                                    current is InitDataEmailReset;
                              },
                              builder: (context, state) => TextFormField(
                                onTap: () {
                                  BlocProvider.of<InitDataCubit>(context)
                                      .eMailIsError = false;
                                  BlocProvider.of<InitDataCubit>(context)
                                      .emit(InitDataEmailReset());
                                },
                                controller: _emailTextEditingController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  errorText: ((state is InitDataEmailError) ||
                                          (BlocProvider.of<InitDataCubit>(context)
                                              .eMailIsError))
                                      ? "please enter email"
                                      : null,
                                  labelText: AppLocalizations.of(context)
                                      .translate("yourEmail"),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    borderSide: BorderSide(color: Colors.black45),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                onChanged: (value) {
                                  BlocProvider.of<InitDataCubit>(context).eMail =
                                      value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),

                            BlocBuilder<InitDataCubit, InitDataState>(
                              buildWhen: (previous, current) {
                                return current is InitDataPhoneNumberError ||
                                    current is InitDataPhoneNumberReset;
                              },
                              builder: (context, state) => TextFormField(
                                onTap: () {
                                  BlocProvider.of<InitDataCubit>(context)
                                      .phoneNumberIsError = false;
                                  BlocProvider.of<InitDataCubit>(context)
                                      .emit(InitDataPhoneNumberReset());
                                },
                                controller: _phoneNumberTextEditingController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  errorText: ((state is InitDataPhoneNumberError) ||
                                          (BlocProvider.of<InitDataCubit>(context)
                                              .phoneNumberIsError))
                                      ? "please enter phone number"
                                      : null,
                                  labelText: AppLocalizations.of(context)
                                      .translate("yourPhoneNumber"),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    borderSide: BorderSide(color: Colors.black45),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                onChanged: (value) {
                                  BlocProvider.of<InitDataCubit>(context)
                                      .phoneNumber = value;
                                },
                              ),
                            ),

                            SizedBox(
                              height: 36,
                            ),
                            Row(
                              //TODO: check design when error is null
                              children: [
                                Expanded(
                                  //TODO: String Search like car model
                                  child: BlocBuilder<InitDataCubit, InitDataState>(
                                    buildWhen: (previous, current) {
                                      return current is InitDataCarTypeError ||
                                          current is InitDataCarTypeReset;
                                    },
                                    builder: (context, state) => DropdownBoxWrapper(
                                      color: state is InitDataCarTypeError ||
                                              BlocProvider.of<InitDataCubit>(
                                                      context)
                                                  .carTypeIdIsError
                                          ? Colors.redAccent[700]
                                          : Theme.of(context).primaryColor,
                                      title: AppLocalizations.of(context)
                                          .translate("carModel"),
                                      child: StreamBuilder<int>(
                                          stream: BlocProvider.of<InitDataCubit>(
                                                  context)
                                              .carTypeIdStream,
                                          initialData: null,
                                          builder: (context, snapshot) {
                                            return DropdownButton<int>(
                                              onTap: () {
                                                BlocProvider.of<InitDataCubit>(
                                                        context)
                                                    .carTypeIdIsError = false;
                                                BlocProvider.of<InitDataCubit>(
                                                        context)
                                                    .emit(InitDataCarTypeReset());
                                              },
                                              onChanged: (e) {
                                                //TODO: save CarType "id" in fo rm state managment
                                                BlocProvider.of<InitDataCubit>(
                                                        context)
                                                    .carTypeIdSelectedValue(e);
                                              },
                                              isExpanded: true,
                                              hint: Text(
                                                  AppLocalizations.of(context)
                                                      .translate("carModel")),
                                              value: snapshot.data,
                                              items: carTypes
                                                  .map((e) => DropdownMenuItem<int>(
                                                        value: e.id,
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                        context)
                                                                    .locale
                                                                    .languageCode
                                                                    .contains("ar")
                                                                ? e.nameAr
                                                                : e.nameEn),
                                                      ))
                                                  .toList(),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                                // Expanded(child: Text("car type")),
                                SizedBox(
                                  width: 8,
                                ),

                                Expanded(
                                  child: BlocBuilder<InitDataCubit, InitDataState>(
                                    buildWhen: (previous, current) {
                                      return current is InitDataCarPropertyError ||
                                          current is InitDataCarPropertyReset;
                                    },
                                    builder: (context, state) => DropdownBoxWrapper(
                                        color: state is InitDataCarPropertyError ||
                                                BlocProvider.of<InitDataCubit>(
                                                        context)
                                                    .carPropertyIdIsError
                                            ? Colors.redAccent[700]
                                            : Theme.of(context).primaryColor,
                                        title: AppLocalizations.of(context)
                                            .translate("carProperty"),
                                        child: StreamBuilder<int>(
                                            stream: BlocProvider.of<InitDataCubit>(
                                                    context)
                                                .carPropertyIdStream,
                                            initialData: null,
                                            builder: (context, snapshot) {
                                              return DropdownButton<int>(
                                                onTap: () {
                                                  BlocProvider.of<InitDataCubit>(
                                                          context)
                                                      .carPropertyIdIsError = false;
                                                  BlocProvider.of<InitDataCubit>(
                                                          context)
                                                      .emit(
                                                          InitDataCarPropertyReset());
                                                },
                                                onChanged: (e) {
                                                  // setState(() {
                                                  //   _carPropertyValue = e;
                                                  // });
                                                  BlocProvider.of<InitDataCubit>(
                                                          context)
                                                      .carPropertyIdSelectedValue(
                                                          e);
                                                },
                                                isExpanded: true,
                                                hint: Text(
                                                    AppLocalizations.of(context)
                                                        .translate("carProperty")),
                                                value: snapshot.data,
                                                items: carProperties
                                                    .map((e) =>
                                                        DropdownMenuItem<int>(
                                                          value: e.id,
                                                          child: Text(
                                                              AppLocalizations.of(
                                                                          context)
                                                                      .locale
                                                                      .languageCode
                                                                      .contains(
                                                                          "ar")
                                                                  ? e.nameAr
                                                                  : e.nameEn),
                                                        ))
                                                    .toList(),
                                              );
                                            })),
                                  ),
                                ),
                                // Expanded(child: Text("car porperty")),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            //chose Country
                            BlocBuilder<InitDataCubit, InitDataState>(
                              buildWhen: (previous, current) {
                                return current is InitDataMarketError ||
                                    current is InitDataMarketReset;
                              },
                              builder: (context, state) => TypeAheadFormField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  onTap: () {
                                    _marketTextEditingController.clear();
                                    BlocProvider.of<InitDataCubit>(context)
                                        .marketIsError = false;
                                    BlocProvider.of<InitDataCubit>(context)
                                        .emit(InitDataMarketReset());
                                  },
                                  // keyboardType: TextInputType.number,
                                  controller: _marketTextEditingController,
                                  decoration: InputDecoration(
                                    errorText: ((state is InitDataMarketError) ||
                                            (BlocProvider.of<InitDataCubit>(context)
                                                .marketIsError))
                                        ? AppLocalizations.of(context)
                                        .translate("addMarket")
                                        : null,
                                    // todo : fix amperage word
                                    labelText: AppLocalizations.of(context)
                                        .translate("marketName"),
                                    // hintText: AppLocalizations.of(context).translate("ex40"),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4.0)),
                                      borderSide: BorderSide(color: Colors.black45),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4.0)),
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                                suggestionsCallback: (pattern) {
                                  List<Market> results = [];
                                  // int searchedCapacity = 0;
                                  // try {
                                  //   searchedCapacity = int.parse(pattern);
                                  //   print(searchedCapacity);
                                  // } catch (e) {
                                  //   //TODO: handle Error
                                  //   print(e);
                                  // }
                                  markets.forEach((market) {
                                    // if (battreyModel.capacity == searchedCapacity)
                                    //   results.add(battreyModel);
                                    if (market.nameAr.contains(pattern) ||
                                        (market.nameEn.toLowerCase())
                                            .contains(pattern.toLowerCase()))
                                      results.add(market);
                                  });

                                  return results;
                                },
                                itemBuilder: (context, suggestion) {
                                  // print(suggestion is Battery);
                                  Market suggestedMarket = suggestion;
                                  if (_marketTextEditingController
                                      .text.isNotEmpty) {
                                    print("${_marketTextEditingController.text}");
                                    return Card(
                                      child: ListTile(
                                        title: Text(AppLocalizations.of(context)
                                                .locale
                                                .languageCode
                                                .contains("ar")
                                            ? suggestedMarket.nameAr
                                            : suggestedMarket.nameEn),
                                        subtitle: Text(AppLocalizations.of(context)
                                                .locale
                                                .languageCode
                                                .contains("ar")
                                            ? suggestedMarket.addressAr
                                            : suggestedMarket.addressEn),
                                      ),
                                    );
                                  } else
                                    return Container(
                                      width: 0,
                                      height: 0,
                                    );
                                },
                                transitionBuilder:
                                    (context, suggestionsBox, controller) {
                                  return SuggestionsBoxWrapper(
                                      AppLocalizations.of(context)
                                          .translate("selectYourMarket"),
                                      suggestionsBox);
                                },
                                onSuggestionSelected: (suggestion) {
                                  //TODO:save Battery "id" in the form provider
                                  Market suggestedMarket = suggestion;
                                  _marketTextEditingController.text =
                                      AppLocalizations.of(context)
                                              .locale
                                              .languageCode
                                              .contains("ar")
                                          ? suggestedMarket.nameAr
                                          : suggestedMarket.nameEn;
                                  BlocProvider.of<InitDataCubit>(context).market =
                                      suggestedMarket;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            BlocBuilder<InitDataCubit, InitDataState>(
                              buildWhen: (previous, current) {
                                return current is InitDataCarNumberError ||
                                    current is InitDataCarNumberReset;
                              },
                              builder: (context, state) => TextFormField(
                                onTap: () {
                                  BlocProvider.of<InitDataCubit>(context)
                                      .carNumberIsError = false;
                                  BlocProvider.of<InitDataCubit>(context)
                                      .emit(InitDataCarNumberReset());
                                },
                                controller: _carNumberTextEditingController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  errorText: (state is InitDataCarNumberError) ||
                                          (BlocProvider.of<InitDataCubit>(context)
                                              .carNumberIsError)
                                      ? "please add your car number"
                                      : null,
                                  labelText: "car number",
                                  // AppLocalizations.of(context)
                                  //     .translate("yourPhoneNumber"),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    borderSide: BorderSide(color: Colors.black45),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                onChanged: (value) {
                                  BlocProvider.of<InitDataCubit>(context)
                                      .carNumber = value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),


                            SizedBox(
                              height: 36,
                            ),
                            // battery front Image
                            BlocBuilder<InitDataCubit, InitDataState>(
                              buildWhen: (previous, current) {
                                // print(current is InitDataBatteryChosen ||
                                //     current is InitDataFrontBatteryImage);
                                return current is InitDataBatteryChosenForImage ||
                                    current is InitDataFrontBatteryImage;
                              },
                              builder: (context, state) {
                                print(state);
                                if (state is InitDataBatteryChosenForImage) {
                                  return CustomButtonForImagePreview(
                                    isError: false,
                                    title: AppLocalizations.of(context)
                                        .translate("addBatteryFrontImage"),
                                    subtitle: AppLocalizations.of(context)
                                        .translate("example"),
                                    child: Material(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          side: BorderSide(color: Colors.blue, width: 4)),
                                      clipBehavior: Clip.antiAlias,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "$baseUrl/${BlocProvider.of<InitDataCubit>(context).battery.frontImage}",
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          height: 100,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(WarrantyIcons.warrenty_clear),
                                                Text(
                                                    AppLocalizations.of(context)
                                                        .translate("errorLoadingImage")
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      // final picker = ImagePicker();
                                      // final pickedFile = await picker.getImage(
                                      //     source: ImageSource.camera);
                                      // print(pickedFile.path);
                                      var mPath = await myImagePicker();
                                      BlocProvider.of<InitDataCubit>(context)
                                          .emit(InitDataFrontBatteryImage(mPath));
                                      BlocProvider.of<InitDataCubit>(context)
                                          .frontBatteryPath = mPath;
                                    },
                                  );
                                } else if (state is InitDataFrontBatteryImage) {
                                  return CustomButtonForImagePreview(
                                    isError: false,
                                    title: AppLocalizations.of(context)
                                        .translate("addBatteryFrontImage"),
                                    subtitle: AppLocalizations.of(context)
                                        .translate("tapAgainToChange"),
                                    child: Material( shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: BorderSide(color: Colors.blue, width: 4)),
                                        clipBehavior: Clip.antiAlias,child: Image.file(File(state.imagePath,),fit: BoxFit.cover,),),
                                    onTap: () async {
                                      // final picker = ImagePicker();
                                      // final pickedFile = await picker.getImage(
                                      //     source: ImageSource.camera);
                                      // print(pickedFile.path);
                                      var mPath = await myImagePicker();
                                      BlocProvider.of<InitDataCubit>(context)
                                          .emit(InitDataFrontBatteryImage(mPath));
                                      BlocProvider.of<InitDataCubit>(context)
                                          .frontBatteryPath = mPath;
                                    },
                                  );
                                } else if (BlocProvider.of<InitDataCubit>(context)
                                        .frontBatteryPath !=
                                    null)
                                  return CustomButtonForImagePreview(
                                    isError: false,
                                    title: AppLocalizations.of(context)
                                        .translate("addBatteryFrontImage"),
                                    subtitle: AppLocalizations.of(context)
                                        .translate("example"),
                                    child: Material(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          side: BorderSide(color: Colors.blue, width: 4)),
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.file(
                                        File(BlocProvider.of<InitDataCubit>(context)
                                            .frontBatteryPath),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    onTap: () async {
                                      // final picker = ImagePicker();
                                      // final pickedFile = await picker.getImage(
                                      //     source: ImageSource.camera);
                                      // print(pickedFile.path);
                                      var mPath = await myImagePicker();
                                      BlocProvider.of<InitDataCubit>(context)
                                          .emit(InitDataFrontBatteryImage(mPath));
                                      BlocProvider.of<InitDataCubit>(context)
                                          .frontBatteryPath = mPath;
                                    },
                                  );
                                else if (BlocProvider.of<InitDataCubit>(context)
                                        .battery !=
                                    null)
                                  return CustomButtonForImagePreview(
                                    isError: false,
                                    title: AppLocalizations.of(context)
                                        .translate("addBatteryFrontImage"),
                                    subtitle: AppLocalizations.of(context)
                                        .translate("example"),
                                    child: Material(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          side: BorderSide(color: Colors.blue, width: 4)),
                                      clipBehavior: Clip.antiAlias,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "$baseUrl/${BlocProvider.of<InitDataCubit>(context).battery.frontImage}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    onTap: () async {
                                      // final picker = ImagePicker();
                                      // final pickedFile = await picker.getImage(
                                      //     source: ImageSource.camera);
                                      // print(pickedFile.path);
                                      var mPath = await myImagePicker();
                                      BlocProvider.of<InitDataCubit>(context)
                                          .emit(InitDataFrontBatteryImage(mPath));
                                      BlocProvider.of<InitDataCubit>(context)
                                          .frontBatteryPath = mPath;
                                    },
                                  );
                                else
                                  return CustomButtonForImagePreview(
                                    isError: false,
                                    title: AppLocalizations.of(context)
                                        .translate("addBatteryFrontImage"),
                                    subtitle:
                                    AppLocalizations.of(context)
                                        .translate("SelectBatteryToHelpYouWithInstructions"),
                                    child: Material(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          side:BorderSide(
                                              color: Colors.blue,
                                              width: 4
                                          )
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            WarrantyIcons.warrenty_clear,
                                            size: 108,
                                            color: Colors.blueAccent,
                                          ),
                                          Text(
                                            "Please Choose A Battery",
                                            style: TextStyle(color: Colors.blueAccent),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () async {
                                      var snackbar = SnackBar(
                                        content: Text(
                                            AppLocalizations.of(context)
                                                .translate("SelectBatteryToHelpYouWithInstructions")),
                                      );
                                      Scaffold.of(context).showSnackBar(snackbar);
                                    },
                                  );
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            BlocBuilder<InitDataCubit, InitDataState>(
                                buildWhen: (previous, current) {
                              return current is InitDataFixedBatteryImage;
                            }, builder: (context, state) {
                              if (state is InitDataFixedBatteryImage)
                                return CustomButtonForImagePreview(
                                  isError: false,
                                  title: AppLocalizations.of(context)
                                      .translate("addFixedBatteryImage"),
                                  subtitle: AppLocalizations.of(context)
                                      .translate("tapAgainToChange"),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: BorderSide(color: Colors.blue, width: 4)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.file(
                                      File(state.imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  onTap: () async {
                                    // final picker = ImagePicker();
                                    // final pickedFile = await picker.getImage(
                                    //     source: ImageSource.camera);
                                    // print(pickedFile.path);
                                    var mPath = await myImagePicker();
                                    BlocProvider.of<InitDataCubit>(context)
                                        .emit(InitDataFixedBatteryImage(mPath));
                                    BlocProvider.of<InitDataCubit>(context)
                                        .fixedBatteryPath = mPath;
                                    // setState(() {
                                    //   _fixedBatteryImage = pickedFile.path;
                                    // });
                                  },
                                );
                              else if (BlocProvider.of<InitDataCubit>(context)
                                      .fixedBatteryPath !=
                                  null)
                                return CustomButtonForImagePreview(
                                  isError: false,
                                  title: AppLocalizations.of(context)
                                      .translate("addFixedBatteryImage"),
                                  subtitle: AppLocalizations.of(context)
                                      .translate("tapAgainToChange"),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: BorderSide(color: Colors.blue, width: 4)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.file(
                                      File(BlocProvider.of<InitDataCubit>(context)
                                          .fixedBatteryPath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  onTap: () async {
                                    // final picker = ImagePicker();
                                    // final pickedFile = await picker.getImage(
                                    //     source: ImageSource.camera);
                                    // print(pickedFile.path);
                                    var mPath = await myImagePicker();
                                    BlocProvider.of<InitDataCubit>(context)
                                        .emit(InitDataFixedBatteryImage(mPath));
                                    BlocProvider.of<InitDataCubit>(context)
                                        .fixedBatteryPath = mPath;
                                    // setState(() {
                                    //   _fixedBatteryImage = pickedFile.path;
                                    // });
                                  },
                                );
                              else
                                return CustomButtonForImagePreview(
                                  isError: false,
                                  title: AppLocalizations.of(context)
                                      .translate("addFixedBatteryImage"),
                                  subtitle: AppLocalizations.of(context)
                                      .translate("example"),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: BorderSide(color: Colors.blue, width: 4)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.asset(
                                      "assets/images/FixedBatteryImage.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  onTap: () async {
                                    // final picker = ImagePicker();
                                    // final pickedFile = await picker.getImage(
                                    //     source: ImageSource.camera);
                                    // print(pickedFile.path);
                                    var mPath = await myImagePicker();
                                    BlocProvider.of<InitDataCubit>(context)
                                        .emit(InitDataFixedBatteryImage(mPath));
                                    BlocProvider.of<InitDataCubit>(context)
                                        .fixedBatteryPath = mPath;
                                    // setState(() {
                                    //   _fixedBatteryImage = pickedFile.path;
                                    // });
                                  },
                                );
                            }),
                            SizedBox(
                              height: 8,
                            ),
                            BlocBuilder<InitDataCubit, InitDataState>(
                                buildWhen: (previous, current) {
                              return current is InitDataCarNumber;
                            }, builder: (context, state) {
                              if (state is InitDataCarNumber)
                                return CustomButtonForImagePreview(
                                  isError: false,
                                  title: AppLocalizations.of(context)
                                      .translate("carNumberIncludingItsColorImage"),
                                  subtitle: AppLocalizations.of(context)
                                      .translate("tapAgainToChange"),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: BorderSide(color: Colors.blue, width: 4)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.file(
                                      File(state.imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  onTap: () async {
                                    // final picker = ImagePicker();
                                    // final pickedFile = await picker.getImage(
                                    //     source: ImageSource.camera);
                                    // print(pickedFile.path);
                                    var mPath = await myImagePicker();
                                    BlocProvider.of<InitDataCubit>(context)
                                        .emit(InitDataCarNumber(mPath));
                                    BlocProvider.of<InitDataCubit>(context)
                                        .carNumberPath = mPath;
                                    // setState(() {
                                    //   _fixedBatteryImage = pickedFile.path;
                                    // });
                                  },
                                );
                              else if (BlocProvider.of<InitDataCubit>(context)
                                      .carNumberPath !=
                                  null)
                                return CustomButtonForImagePreview(
                                  isError: false,
                                  title: AppLocalizations.of(context)
                                      .translate("carNumberIncludingItsColorImage"),
                                  subtitle: AppLocalizations.of(context)
                                      .translate("tapAgainToChange"),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: BorderSide(color: Colors.blue, width: 4)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.file(
                                      File(BlocProvider.of<InitDataCubit>(context)
                                          .carNumberPath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  onTap: () async {
                                    // final picker = ImagePicker();
                                    // final pickedFile = await picker.getImage(
                                    //     source: ImageSource.camera);
                                    // print(pickedFile.path);
                                    var mPath = await myImagePicker();
                                    BlocProvider.of<InitDataCubit>(context)
                                        .emit(InitDataCarNumber(mPath));
                                    BlocProvider.of<InitDataCubit>(context)
                                        .carNumberPath = mPath;
                                  },
                                );
                              else
                                return CustomButtonForImagePreview(
                                  isError: false,
                                  title: AppLocalizations.of(context)
                                      .translate("carNumberIncludingItsColorImage"),
                                  subtitle: AppLocalizations.of(context)
                                      .translate("example"),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: BorderSide(color: Colors.blue, width: 4)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.asset(
                                      "assets/images/carFront.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  onTap: () async {
                                    // final picker = ImagePicker();
                                    // final pickedFile = await picker.getImage(
                                    //     source: ImageSource.camera);
                                    // print(pickedFile.path);
                                    var mPath = await myImagePicker();
                                    BlocProvider.of<InitDataCubit>(context)
                                        .emit(InitDataCarNumber(mPath));
                                    BlocProvider.of<InitDataCubit>(context)
                                        .carNumberPath = mPath;
                                    // setState(() {
                                    //   _fixedBatteryImage = pickedFile.path;
                                    // });
                                  },
                                );
                            }),
                            SizedBox(
                              height: 8,
                            ),
                            // SizedBox(
                            //   height: 16,
                            // ),
                          ],
                        ),
                      );
                    } else if (state is InitDataError) {
                      return Center(
                        child: Text(AppLocalizations.of(context)
                                .locale
                                .languageCode
                                .contains("ar")
                            ? state.messageAr
                            : state.messageEn),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}

class CustomButtonForConteryDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

