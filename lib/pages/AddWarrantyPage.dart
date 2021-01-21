import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:ewarrenty/Blocs/InitData/init_data_cubit.dart';
import 'package:ewarrenty/Constants/Constants.dart';
import 'package:ewarrenty/Icons/warranty_icons_icons.dart';
import 'package:ewarrenty/Models/Battery.dart';
import 'package:ewarrenty/Models/car_property.dart';
import 'package:ewarrenty/Models/car_type.dart';
import 'package:ewarrenty/Models/market.dart';
import 'package:ewarrenty/Wrappers/SuggestionsBoxWrapper.dart';
import 'package:ewarrenty/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ewarrenty/dialogs/whereIsSerialNumberDialog.dart';
import 'package:ewarrenty/services/sendWarranty/SendWarrantyService.dart';

class AddWarrantyPage extends StatefulWidget {
  @override
  _AddWarrantyPageState createState() => _AddWarrantyPageState();
}

class _AddWarrantyPageState extends State<AddWarrantyPage> {
  var _batteryController = TextEditingController();
  var _serialNumberController = TextEditingController();
  var _marketController = TextEditingController();

  var _fullNameController = TextEditingController();
  var _addressController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneNumberController = TextEditingController();
  var _carNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InitDataCubit>(
      create: (context) => InitDataCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("addWarranty")),
        ),
        bottomNavigationBar: BlocBuilder<InitDataCubit, InitDataState>(
          builder: (context, state) => FlatButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            //todo: translate submit
            child: Text("submit"),
            onPressed: () {
              print("submit");
              //todo: submit button
              InitDataCubit mCubit = BlocProvider.of<InitDataCubit>(context);
              if (mCubit.battery == null) {
                //todo: translate "choose battery model"
                mCubit.batteryIsError = true;
                mCubit.emit(InitDataBatteryChoosenError());
                var snackBar = SnackBar(
                  content: Text("please choose battery model"),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              if (mCubit.billDate == null) {
                //todo: translate "choose bill date"
                mCubit.emit(InitDataBillDateError());
                mCubit.billDateIsError = true;
                var snackBar = SnackBar(
                  content: Text("choose bill date"),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              if (mCubit.serialNumber == null) {
                //todo: tanslate "add Serial Number"
                mCubit.emit(InitDataSerialNumberError());
                mCubit.serialNumberIsError = true;
                var snackBar = SnackBar(
                  content: Text("Please Add Serial Number"),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              if (mCubit.fullName == null) {
                //todo: tanslate "Please Add Your Full Name In English"
                mCubit.emit(InitDataFullNameError());
                mCubit.fullNameIsError = true;
                var snackBar = SnackBar(
                  content: Text("Please Your Full Name In English"),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              if (mCubit.address == null) {
                //todo: tanslate "Please Add Your Address In English"
                mCubit.emit(InitDataAddressError());
                mCubit.addressIsError = true;
                var snackBar = SnackBar(
                  content: Text("Please Add Your Address In English"),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              if (mCubit.eMail == null) {
                //todo: tanslate "Please Add Your E-mail"
                mCubit.emit(InitDataEmailError());
                mCubit.eMailIsError = true;
                var snackBar = SnackBar(
                  content: Text("Please Add Your E-mail"),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              if (mCubit.phoneNumber == null) {
                //todo: tanslate "Please Add Your phone number"
                mCubit.emit(InitDataPhoneNumberError());
                mCubit.phoneNumberIsError = true;
                var snackBar = SnackBar(
                  content: Text("Please Add Your phone number"),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              if (mCubit.carPropertyId == null) {
                //todo: tanslate "Please Add Your Car Property Type"
                // mCubit.emit(InitDataCarNumberError());
                mCubit.carNumberIsError = true;
                var snackBar = SnackBar(
                  content: Text("Please Add Your Car Property Type"),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              if (mCubit.carTypeId == null) {
                //todo: tanslate "Please Add Your Car Type"
                // mCubit.emit(InitDataCarTypeError());
                mCubit.phoneNumberIsError = true;
                var snackBar = SnackBar(
                  content: Text("Please Add Your Car Type"),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              if (mCubit.country == null) {
                //todo: tanslate "Please Add Your Country"
                mCubit.emit(InitDataCountryError());
                mCubit.countryIsError = true;
                var snackBar = SnackBar(
                  content: Text("Please Add Your Country"),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              if (mCubit.market == null) {
                //todo: tanslate "Please Add Your Market"
                mCubit.emit(InitDataMarketError());
                mCubit.marketIsError = true;
                var snackBar = SnackBar(
                  content: Text("Please Add Your Market"),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              if (mCubit.frontBatteryPath == null) {
                //todo: tanslate "Please capture Your battery front"
                var snackBar = SnackBar(
                  content: Text("Please capture Your battery front"),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              if (mCubit.fixedBatteryPath == null) {
                //todo: tanslate "Please capture Your fixed battery"
                var snackBar = SnackBar(
                  content: Text("Please capture Your fixed battery"),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              if (mCubit.carNumberPath == null) {
                //todo: tanslate "Please capture Your car"
                var snackBar = SnackBar(
                  content: Text("Please capture Your Car "),
                  duration: Duration(milliseconds: 600),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              // print(mCubit.toString());
              var finalValidation = mCubit.getFinalValidtion();
              print(finalValidation);
              if (finalValidation) {
                //until tomorrow
                print("tomorrowland");
                SendWarrantyService service = SendWarrantyService.create();
                Map<String, dynamic> map =Map<String, dynamic>();
                map["battery_serial_number"] =  mCubit.serialNumber;
                 map["bought_date"] =  mCubit.billDate;
                 map["car_number"] =  mCubit.carNumber;
                 map["battery_model_id"] =  mCubit.battery.id;
                 map["car_property_id"] =  mCubit.carPropertyId;
                 map["car_type_id"] =  mCubit.carTypeId;
                 map["market_id"] =  mCubit.market.id;
                 map["customer_name"] =  mCubit.fullName;
                 map["customer_email"] =  mCubit.eMail;
                 map["customer_address"] =  mCubit.address;
                 map["customer_country"] =  mCubit.country;
                 map["notes"] =  "";
                // {
                //   "battery_serial_number": mCubit.serialNumber,
                //   "bought_date": mCubit.billDate,
                //   "car_number": mCubit.carNumber,
                //   "battery_model_id": mCubit.battery.id,
                //   "car_property_id": mCubit.carPropertyId,
                //   "car_type_id": mCubit.carTypeId,
                //   "market_id": mCubit.market.id,
                //   "customer_name": mCubit.fullName,
                //   "customer_email": mCubit.eMail,
                //   "customer_address": mCubit.address,
                //   "customer_country": mCubit.country,
                //   "notes": ""
                // };

                // service.sendWarrenty(map,
                //     mCubit.carNumberPath,
                //         mCubit.frontBatteryPath,
                //     mCubit.fixedBatteryPath
                // )
                //     .then((value) {
                //   print("AddWarrantybody:${value.body}");
                //   print("AddWarrantyisSuccessful:${value.isSuccessful}");
                //   print("AddWarrantyError:${value.error.toString()}");
                // })..catchError((e){
                //   print (e);
                // });

                service.sendWarrenty(
                  battery_front_image: mCubit.frontBatteryPath,
                  battery_model_id:  mCubit.battery.id,
                  battery_serial_number:  mCubit.serialNumber,
                  bought_date:  mCubit.billDate,
                  car_number:  mCubit.carNumber,
                  car_number_image:   mCubit.carNumberPath,
                  car_property_id:   mCubit.carPropertyId,
                  car_type_id:   mCubit.carTypeId,
                  customer_country:  mCubit.country,
                  customer_email:  mCubit.eMail,
                  customer_name:  mCubit.fullName,
                  customer_phone_number:  mCubit.phoneNumber,
                  fixed_battery_image: mCubit.fixedBatteryPath,
                  customer_address: mCubit.address,
                  market_id: mCubit.market.id,
                  notes: ""
                )
                    .then((value) {
                  print("AddWarrantybody:${value.body}");
                  print("AddWarrantyisSuccessful:${value.isSuccessful}");
                  print("AddWarrantyError:${value.error.toString()}");
                })..catchError((e){
                  print (e);
                });
              }
            },
          ),
        ),
        body: BlocBuilder<InitDataCubit, InitDataState>(
          // cubit:BlocProvider.of<InitDataCubit>(context),
          // ignore: missing_return
          buildWhen: (previous, current) {
            return !((current is InitDataBillDate) ||
                (current is InitDataBatteryChosen) ||
                (current is InitDataFixedBatteryImage) ||
                (current is InitDataFrontBatteryImage) ||
                (current is InitDataCarNumber) ||
                (current is InitDataBatteryChoosenReset) ||
                (current is InitDataBatteryChoosenError) ||
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
                (current is InitDataMarketError));
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
                        return current is InitDataBatteryChoosenError ||
                            current is InitDataBatteryChoosenReset;
                      },
                      builder: (context, state) => TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          onTap: () {
                            BlocProvider.of<InitDataCubit>(context)
                                .batteryIsError = false;
                            BlocProvider.of<InitDataCubit>(context)
                                .emit(InitDataBatteryChoosenReset());
                            _batteryController.clear();
                          },
                          keyboardType: TextInputType.number,
                          controller: this._batteryController,
                          decoration: InputDecoration(
                            // TODO : fix amprage word
                            // TODO:  tarnslate error for battery
                            errorText:
                                ((state is InitDataBatteryChoosenError) ||
                                        (BlocProvider.of<InitDataCubit>(context)
                                            .batteryIsError))
                                    ? "please choose battery"
                                    : null,
                            labelText: AppLocalizations.of(context)
                                .translate("enterBatteryAmperage"),
                            hintText:
                                AppLocalizations.of(context).translate("ex40"),
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
                            //todo: handle Error
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
                          if (_batteryController.text.isNotEmpty) {
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
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ],
                                title: Text(suggestedBattry.number),
                                subtitle: Text(AppLocalizations.of(context)
                                    .translate("pressImageIconToPreviewImage")),
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
                          //todo:save Battery "id" in the form provider
                          Battery suggestedBattry = suggestion;
                          BlocProvider.of<InitDataCubit>(context)
                              .emit(InitDataBatteryChosen(suggestedBattry));
                          BlocProvider.of<InitDataCubit>(context).battery =
                              suggestedBattry;
                          // print(BlocProvider.of<InitDataCubit>(context).batteryId);
                          this._batteryController.text = suggestedBattry.number;
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
                        child: Text(
                            BlocProvider.of<InitDataCubit>(context).billDate ??
                                AppLocalizations.of(context)
                                    .translate("boughtDate")),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now().add(Duration(days: -365 * 120)),
                            lastDate: DateTime.now().add(Duration(days: 1)),
                            // helpText: "Select Bill Date",
                          ).then((value) {
                            BlocProvider.of<InitDataCubit>(context)
                                .billDateIsError = false;
                            BlocProvider.of<InitDataCubit>(context).billDate =
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
                        controller: _serialNumberController,
                        onTap: () {
                          BlocProvider.of<InitDataCubit>(context)
                              .serialNumberIsError = false;
                          BlocProvider.of<InitDataCubit>(context)
                              .emit(InitDataSerialNumberReset());
                        },
                        decoration: InputDecoration(
                          //TODO: translate "please enter Serial number"
                          errorText: ((state is InitDataSerialNumberError) ||
                                  (BlocProvider.of<InitDataCubit>(context)
                                      .serialNumberIsError))
                              ? "please enter serial number"
                              : null,
                          suffixIcon: IconButton(
                            icon: Icon(WarrantyIcons.warrenty_comment),
                            onPressed: () {
                              //todo: display a dialog -or a tooltip- that explaine how to find the serial number with a image preview
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
                                    ? BlocProvider.of<InitDataCubit>(context)
                                        .battery
                                        .infoAr
                                    : BlocProvider.of<InitDataCubit>(context)
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
                                //todo: translate "didn't select Battery to help you with instructions"
                                var snackbar = SnackBar(
                                  content: Text(
                                      "didn't select Battery to help you with instructions"),
                                );
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
                          BlocProvider.of<InitDataCubit>(context).serialNumber =
                              value;
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
                        controller: _fullNameController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-z A-Z]')),
                        ],
                        decoration: InputDecoration(
                          //TODO: translate "Add full name in english"
                          errorText: ((state is InitDataFullNameError) ||
                                  (BlocProvider.of<InitDataCubit>(context)
                                      .addressIsError))
                              ? "Add full name in english"
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
                          //todo: make the user enter his name in english
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
                        controller: _addressController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-z A-Z]')),
                        ],
                        decoration: InputDecoration(
                          //TODO: translate "Add address in english"
                          errorText: ((state is InitDataAddressError) ||
                                  (BlocProvider.of<InitDataCubit>(context)
                                      .addressIsError))
                              ? "Add address in english"
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
                          //todo: make the user enter his name in english
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
                          BlocProvider.of<InitDataCubit>(context).eMailIsError =
                              false;
                          BlocProvider.of<InitDataCubit>(context)
                              .emit(InitDataEmailReset());
                        },
                        controller: _emailController,
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
                          BlocProvider.of<InitDataCubit>(context).eMail = value;
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
                        controller: _phoneNumberController,
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
                          BlocProvider.of<InitDataCubit>(context).phoneNumber =
                              value;
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
                          //todo: String Search like car model
                          child: StreamBuilder<int>(
                              stream: BlocProvider.of<InitDataCubit>(context)
                                  .carTypeIdStream,
                              initialData: null,
                              builder: (context, snapshot) {
                                return DropdownButton<int>(
                                  onChanged: (e) {
                                    //todo: save CarType "id" in fo rm state managment
                                    // setState(() {
                                    //   _carTypeValue = e;
                                    // });
                                    BlocProvider.of<InitDataCubit>(context)
                                        .carTypeIdSelectedValue(e);
                                  },
                                  isExpanded: true,
                                  hint: Text(AppLocalizations.of(context)
                                      .translate("carModel")),
                                  value: snapshot.data,
                                  items: carTypes
                                      .map((e) => DropdownMenuItem<int>(
                                            value: e.id,
                                            child: Text(
                                                AppLocalizations.of(context)
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
                        // Expanded(child: Text("car type")),
                        SizedBox(
                          width: 8,
                        ),

                        Expanded(
                          child: StreamBuilder<int>(
                              stream: BlocProvider.of<InitDataCubit>(context)
                                  .carPropertyIdStream,
                              initialData: null,
                              builder: (context, snapshot) {
                                return DropdownButton<int>(
                                  onChanged: (e) {
                                    // setState(() {
                                    //   _carPropertyValue = e;
                                    // });
                                    BlocProvider.of<InitDataCubit>(context)
                                        .carPropertyIdSelectedValue(e);
                                  },
                                  isExpanded: true,
                                  hint: Text(AppLocalizations.of(context)
                                      .translate("carProperty")),
                                  value: snapshot.data,
                                  items: carProperties
                                      .map((e) => DropdownMenuItem<int>(
                                            value: e.id,
                                            child: Text(
                                                AppLocalizations.of(context)
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
                        // Expanded(child: Text("car porperty")),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<InitDataCubit, InitDataState>(
                      buildWhen: (previous, current) {
                        return current is InitDataMarketError ||
                            current is InitDataMarketReset;
                      },
                      builder: (context, state) => TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          onTap: () {
                            _marketController.clear();
                            BlocProvider.of<InitDataCubit>(context)
                                .marketIsError = false;
                            BlocProvider.of<InitDataCubit>(context)
                                .emit(InitDataMarketReset());
                          },
                          // keyboardType: TextInputType.number,
                          controller: this._marketController,
                          decoration: InputDecoration(
                            //TODO: please choose the market
                            errorText: ((state is InitDataMarketError) ||
                                    (BlocProvider.of<InitDataCubit>(context)
                                        .marketIsError))
                                ? "please add your market"
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
                          //   //todo: handle Error
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
                          if (_marketController.text.isNotEmpty) {
                            print("${_marketController.text}");
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
                          //todo:save Battery "id" in the form provider
                          Market suggestedMarket = suggestion;
                          this._marketController.text =
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
                        controller: _carNumberController,
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
                          BlocProvider.of<InitDataCubit>(context).carNumber =
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
                      builder: (context, state) => Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        // color: state is! InitDataCountryError
                        //     ? Theme.of(context).primaryColor
                        //     : Colors.redAccent[700],
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).primaryColor,
                                  // Theme.of(context).accentColor
                                  Colors.deepPurpleAccent
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate("country"),
                                style: TextStyle(color: Colors.white),
                              ),
                              CountryCodePicker(
                                showDropDownButton: true,
                                textStyle: TextStyle(color: Colors.white),
                                // showDropDownButton: true,
                                showFlag: true,
                                // countryFilter: ['IL'],
                                onChanged: (countryCode) {
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
                      height: 36,
                    ),
                    BlocBuilder<InitDataCubit, InitDataState>(

                      buildWhen: (previous, current) {
                        print(current is InitDataBatteryChosen ||
                            current is InitDataFrontBatteryImage);
                        return current is InitDataBatteryChosen ||
                            current is InitDataFrontBatteryImage;
                      },
                      builder: (context, state) {
                        print (state);
                        if (state is InitDataBatteryChosen)
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    // Theme.of(context).accentColor
                                    Colors.deepPurpleAccent
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: ImagePreview(
                                  AppLocalizations.of(context)
                                      .translate("batteryFrontImage"),
                                  AppLocalizations.of(context)
                                      .translate("example"),
                                  CachedNetworkImage(
                                    imageUrl:
                                        "$baseUrl/${BlocProvider.of<InitDataCubit>(context).battery.frontImage}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () async {
                                  final picker = ImagePicker();
                                  final pickedFile = await picker.getImage(
                                      source: ImageSource.camera);
                                  print(pickedFile.path);
                                  BlocProvider.of<InitDataCubit>(context).emit(
                                      InitDataFrontBatteryImage(
                                          pickedFile.path));
                                  BlocProvider.of<InitDataCubit>(context)
                                      .frontBatteryPath = pickedFile.path;
                                },
                              ),
                            ),

                            // textColor: Colors.white,
                            // color: Theme.of(context).primaryColor,
                          );
                        else if (state is InitDataFrontBatteryImage)
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    // Theme.of(context).accentColor
                                    Colors.deepPurpleAccent
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  final picker = ImagePicker();
                                  final pickedFile = await picker.getImage(
                                      source: ImageSource.camera);
                                  print(pickedFile.path);
                                  BlocProvider.of<InitDataCubit>(context).emit(
                                      InitDataFrontBatteryImage(
                                          pickedFile.path));
                                  BlocProvider.of<InitDataCubit>(context)
                                      .frontBatteryPath = pickedFile.path;
                                },
                                child: ImagePreview(
                                    AppLocalizations.of(context)
                                        .translate("batteryFrontImage"),
                                    AppLocalizations.of(context)
                                        .translate("tapAgainToChange"),
                                    Image.file(File(state.imagePath))),
                              ),
                            ),

                            // textColor: Colors.white,
                            // color: Theme.of(context).primaryColor,
                          );
                        else if(BlocProvider.of<InitDataCubit>(context).frontBatteryPath!=null)
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    // Theme.of(context).accentColor
                                    Colors.deepPurpleAccent
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  final picker = ImagePicker();
                                  final pickedFile = await picker.getImage(
                                      source: ImageSource.camera);
                                  print(pickedFile.path);
                                  BlocProvider.of<InitDataCubit>(context).emit(
                                      InitDataFrontBatteryImage(
                                          pickedFile.path));
                                  BlocProvider.of<InitDataCubit>(context)
                                      .frontBatteryPath = pickedFile.path;
                                },
                                child: ImagePreview(
                                    AppLocalizations.of(context)
                                        .translate("batteryFrontImage"),
                                    AppLocalizations.of(context)
                                        .translate("tapAgainToChange"),
                                    Image.file(File(BlocProvider.of<InitDataCubit>(context).frontBatteryPath),fit: BoxFit.cover,)),
                              ),
                            ),

                            // textColor: Colors.white,
                            // color: Theme.of(context).primaryColor,
                          );
                        else if(BlocProvider.of<InitDataCubit>(context).battery!=null)
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    // Theme.of(context).accentColor
                                    Colors.deepPurpleAccent
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: ImagePreview(
                                  AppLocalizations.of(context)
                                      .translate("batteryFrontImage"),
                                  AppLocalizations.of(context)
                                      .translate("example"),
                                  CachedNetworkImage(
                                    imageUrl:
                                    "$baseUrl/${BlocProvider.of<InitDataCubit>(context).battery.frontImage}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () async {
                                  final picker = ImagePicker();
                                  final pickedFile = await picker.getImage(
                                      source: ImageSource.camera);
                                  print(pickedFile.path);
                                  BlocProvider.of<InitDataCubit>(context).emit(
                                      InitDataFrontBatteryImage(
                                          pickedFile.path));
                                  BlocProvider.of<InitDataCubit>(context)
                                      .frontBatteryPath = pickedFile.path;
                                },
                              ),
                            ),

                            // textColor: Colors.white,
                            // color: Theme.of(context).primaryColor,
                          );
                        else
                          return Container(
                            // color:Colors.blue,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    // Theme.of(context).accentColor
                                    Colors.deepPurpleAccent
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  //todo: translate "didn't select Battery to help you with instructions"
                                  var snackbar = SnackBar(
                                    content: Text(
                                        "didn't select Battery to help you with instructions"),
                                  );
                                  Scaffold.of(context).showSnackBar(snackbar);
                                  // final picker = ImagePicker();
                                  // final pickedFile =
                                  //     await picker.getImage(source: ImageSource.camera);
                                  // print(pickedFile.path);
                                  // setState(() {
                                  //   _fixedBatteryImage = pickedFile.path;
                                  // });
                                },
                                child: ImagePreview(
                                    AppLocalizations.of(context)
                                        .translate("batteryFrontImage"),
                                    //todo: translate "didn't select Battery to help you with instructions"
                                    "didn't select Battery to help you with instructions",
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          WarrantyIcons.warrenty_clear,
                                          size: 108,
                                        ),
                                        Text("Please Choose A Battery")
                                      ],
                                    )),
                              ),
                            ),
                            // onPressed: () async {
                            //   //todo: translate "didn't select Battery to help you with instructions"
                            //   var snackbar = SnackBar(
                            //     content: Text(
                            //         "didn't select Battery to help you with instructions"),
                            //   );
                            //   Scaffold.of(context).showSnackBar(snackbar);
                            //   // final picker = ImagePicker();
                            //   // final pickedFile =
                            //   //     await picker.getImage(source: ImageSource.camera);
                            //   // print(pickedFile.path);
                            //   // setState(() {
                            //   //   _fixedBatteryImage = pickedFile.path;
                            //   // });
                            // },
                            // textColor: Colors.white,
                            // color: Theme.of(context).primaryColor,
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
                        return FlatButton(
                          child: ImagePreview(
                              AppLocalizations.of(context)
                                  .translate("fixedBatteryImage"),
                              AppLocalizations.of(context)
                                  .translate("tapAgainToChange"),
                              Image.file(
                                File(state.imagePath),
                                fit: BoxFit.cover,
                              )),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.getImage(
                                source: ImageSource.camera);
                            print(pickedFile.path);
                            BlocProvider.of<InitDataCubit>(context).emit(
                                InitDataFixedBatteryImage(pickedFile.path));
                            BlocProvider.of<InitDataCubit>(context)
                                .fixedBatteryPath = pickedFile.path;
                            // setState(() {
                            //   _fixedBatteryImage = pickedFile.path;
                            // });
                          },
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                        );
                      else
                        return FlatButton(
                          child: ImagePreview(
                              AppLocalizations.of(context)
                                  .translate("fixedBatteryImage"),
                              AppLocalizations.of(context).translate("example"),
                              Image.asset(
                                "assets/images/bill.jpg",
                                fit: BoxFit.cover,
                              )),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.getImage(
                                source: ImageSource.camera);
                            print(pickedFile.path);
                            BlocProvider.of<InitDataCubit>(context).emit(
                                InitDataFixedBatteryImage(pickedFile.path));
                            BlocProvider.of<InitDataCubit>(context)
                                .fixedBatteryPath = pickedFile.path;
                            // setState(() {
                            //   _fixedBatteryImage = pickedFile.path;
                            // });
                          },
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
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
                        return FlatButton(
                          child: ImagePreview(
                              AppLocalizations.of(context)
                                  .translate("carNumberIncludingItsColorImage"),
                              AppLocalizations.of(context)
                                  .translate("tapAgainToChange"),
                              Image.file(
                                File(state.imagePath),
                                fit: BoxFit.cover,
                              )),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.getImage(
                                source: ImageSource.camera);
                            print(pickedFile.path);
                            BlocProvider.of<InitDataCubit>(context)
                                .emit(InitDataCarNumber(pickedFile.path));
                            BlocProvider.of<InitDataCubit>(context)
                                .carNumberPath = pickedFile.path;
                            // setState(() {
                            //   _fixedBatteryImage = pickedFile.path;
                            // });
                          },
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                        );
                      else
                        return FlatButton(
                          child: ImagePreview(
                              AppLocalizations.of(context)
                                  .translate("carNumberIncludingItsColorImage"),
                              AppLocalizations.of(context).translate("example"),
                              Image.asset(
                                "assets/images/number.jpg",
                                fit: BoxFit.cover,
                              )),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.getImage(
                                source: ImageSource.camera);
                            print(pickedFile.path);
                            BlocProvider.of<InitDataCubit>(context)
                                .emit(InitDataCarNumber(pickedFile.path));
                            BlocProvider.of<InitDataCubit>(context)
                                .carNumberPath = pickedFile.path;
                            // setState(() {
                            //   _fixedBatteryImage = pickedFile.path;
                            // });
                          },
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
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
      ),
    );
  }
}

class ImagePreview extends StatelessWidget {
  final String _title;
  final String _subtitle;
  final Widget _widget;

  ImagePreview(this._title, this._subtitle, this._widget);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _title,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.button.fontSize,
                color: Colors.white),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            _subtitle,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.caption.fontSize,
                color: Colors.white),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 200,
            child: AspectRatio(aspectRatio: 4 / 3, child: _widget
                // _imagePath.contains("assets")
                //     ? Image.asset(_imagePath)
                //     : Image.file(
                //         File(
                //           _imagePath,
                //         ),
                //         fit: BoxFit.cover,
                //       ),
                ),
          ),
        ],
      ),
    );
  }
}
