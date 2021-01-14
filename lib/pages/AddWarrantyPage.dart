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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ewarrenty/dialogs/whereIsSerialNumberDialog.dart';

class AddWarrantyPage extends StatefulWidget {
  @override
  _AddWarrantyPageState createState() => _AddWarrantyPageState();
}

class _AddWarrantyPageState extends State<AddWarrantyPage> {
  // List<Battery> _battaryModels = [
  //   Battery(
  //       number: "42B19L",
  //       capacity: 35,
  //       image: "assets/images/home/1.png",
  //       previewImage: "assets/images/home/1.png"),
  //   Battery(
  //       number: "54459",
  //       capacity: 44,
  //       image: "assets/images/home/2.png",
  //       previewImage: "assets/images/home/2.png"),
  //   Battery(
  //       number: "55B24L",
  //       capacity: 45,
  //       image: "assets/images/home/3.png",
  //       previewImage: "assets/images/home/3.png"),
  //   Battery(
  //       number: "55B24LS",
  //       capacity: 45,
  //       image: "assets/images/home/4.png",
  //       previewImage: "assets/images/home/4.png"),
  //   Battery(
  //       number: "50D20L",
  //       capacity: 50,
  //       image: "assets/images/home/1.png",
  //       previewImage: "assets/images/home/1.png"),
  //   Battery(
  //       number: "55559",
  //       capacity: 55,
  //       image: "assets/images/home/2.png",
  //       previewImage: "assets/images/home/2.png"),
  //   Battery(
  //       number: "55D26L",
  //       capacity: 60,
  //       image: "assets/images/home/3.png",
  //       previewImage: "assets/images/home/3.png"),
  //   Battery(
  //       number: "56638",
  //       capacity: 35,
  //       image: "assets/images/home/4.png",
  //       previewImage: "assets/images/home/4.png"),
  // ];
  List<String> _users = [
    "mhd",
    "kalid Alajlony",
    "Ayham hamed",
    "safaa basha",
    "bayan abd al-rahman",
  ];
  List<String> _carType = [
    "BMW",
    "Mercedes",
    "Chevrolet",
    "Ferrari",
    "Lamborghini",
  ];
  List<String> _carProperty = [
    "Private",
    "Public",
  ];
  List<String> _countries = [
    "Syria",
    "Sudan",
  ];

  String _selectedUser;

  var _batteryController = TextEditingController();
  var _serialNumberController = TextEditingController();
  var _marketController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitDataCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("addWarranty")),
        ),
        bottomNavigationBar: FlatButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          //todo: translate submit
          child: Text("submit"),
          onPressed: () {
            //todo: submit button
            var mCubit = BlocProvider.of<InitDataCubit>(context);
            if (mCubit.battery == null) {
              //todo: translate "choose battery model"
              var snackBar = SnackBar(
                content: Text("please choose battery model"),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (mCubit.billDate == null) {
              //todo: translate "choose bill date"
              var snackBar = SnackBar(
                content: Text("choose bill date"),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (mCubit.serialNumber == null) {
              //todo: tanslate "add Serial Number"
              var snackBar = SnackBar(
                content: Text("Please Add Serial Number"),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (mCubit.fullName == null) {
              //todo: tanslate "Please Add Your Full Name In English"
              var snackBar = SnackBar(
                content: Text("Please Your Full Name In English"),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (mCubit.address == null) {
              //todo: tanslate "Please Add Your Address In English"
              var snackBar = SnackBar(
                content: Text("Please Add Your Address In English"),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (mCubit.eMail == null) {
              //todo: tanslate "Please Add Your E-mail"
              var snackBar = SnackBar(
                content: Text("Please Add Your E-mail"),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (mCubit.phoneNumber == null) {
              //todo: tanslate "Please Add Your phone number"
              var snackBar = SnackBar(
                content: Text("Please Add Your phone number"),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (mCubit.carPropertyId == null) {
              //todo: tanslate "Please Add Your Car Property Type"
              var snackBar = SnackBar(
                content: Text("Please Add Your Car Property Type"),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (mCubit.carTypeId == null) {
              //todo: tanslate "Please Add Your Car Type"
              var snackBar = SnackBar(
                content: Text("Please Add Your Car Type"),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (mCubit.country == null) {
              //todo: tanslate "Please Add Your Country"
              var snackBar = SnackBar(
                content: Text("Please Add Your Country"),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (mCubit.market == null) {
              //todo: tanslate "Please Add Your Market"
              var snackBar = SnackBar(
                content: Text("Please Add Your Market"),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (mCubit.frontBatteryPath == null) {
              //todo: tanslate "Please capture Your battery front"
              var snackBar = SnackBar(
                content: Text("Please capture Your battery front"),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (mCubit.fixedBatteryPath == null) {
              //todo: tanslate "Please capture Your fixed battery"
              var snackBar = SnackBar(
                content: Text("Please capture Your fixed battery"),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (mCubit.carNumberPath == null) {
              //todo: tanslate "Please capture Your car"
              var snackBar = SnackBar(
                content: Text("Please capture Your Car "),
                duration: Duration(milliseconds: 600),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            }
          },
        ),
        body: BlocBuilder<InitDataCubit, InitDataState>(
          // cubit:BlocProvider.of<InitDataCubit>(context),
          // ignore: missing_return
          buildWhen: (previous, current) {
            return !((current is InitDataBillDate) ||
                (current is InitDataBatteryChosen) ||
                (current is InitDataFixedBatteryImage) ||
                (current is InitDataFrontBatteryImage) ||
                (current is InitDataCarNumber));
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    // https://pub.dev/packages/flutter_typeahead
                    SizedBox(
                      height: 8,
                    ),
                    TypeAheadFormField(
                      // noItemsFoundBuilder: (context) {
                      //   return Padding(
                      //     padding: const EdgeInsets.all(4.0),
                      //     child: Center(
                      //       child: RaisedButton(
                      //         textColor: Colors.white,
                      //         color: Theme.of(context).primaryColor,
                      //         onPressed: () {
                      //           //todo: add new Customer
                      //           Navigator.of(context).push(MaterialPageRoute(
                      //               builder: (context) => AddNewCustomer()));
                      //         },
                      //         child: Padding(
                      //           padding:
                      //               EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Icon(
                      //                 FontAwesomeIcons.userEdit,
                      //                 size: 16,
                      //               ),
                      //               SizedBox(
                      //                 width: 16,
                      //               ),
                      //               Column(
                      //                 mainAxisSize: MainAxisSize.min,
                      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     "Customer not found!",
                      //                   ),
                      //                   Text("Press here to add")
                      //                 ],
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   );
                      // },
                      textFieldConfiguration: TextFieldConfiguration(
                        onTap: () {
                          _batteryController.clear();
                        },
                        keyboardType: TextInputType.number,
                        controller: this._batteryController,
                        decoration: InputDecoration(
                          // todo : fix amprage word
                          errorText: "slkdnv",
                          labelText: AppLocalizations.of(context)
                              .translate("enterBatteryAmperage"),
                          hintText: AppLocalizations.of(context).translate("ex40"),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide(color: Colors.black45),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
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
                                    imageUrl: "$baseUrl${suggestedBattry.image}",
                                    // imageUrl: "http://via.placeholder.com/350x150",
                                    // placeholder: (context,text)=>CircularProgressIndicator(),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) => Center(
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

                      transitionBuilder: (context, suggestionsBox, controller) {
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
                        BlocProvider.of<InitDataCubit>(context).battery = suggestedBattry;
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
                    SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<InitDataCubit, InitDataState>(
                        buildWhen: (previous, current) {
                          // print(current is InitDataBillDate);
                          return current is InitDataBillDate;
                        }, builder: (context, state) {
                      return FlatButton(
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        child: Text(BlocProvider.of<InitDataCubit>(context).billDate ??
                            AppLocalizations.of(context).translate("boughtDate")),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now().add(Duration(days: -365 * 120)),
                            lastDate: DateTime.now().add(Duration(days: 1)),
                            // helpText: "Select Bill Date",
                          ).then((value) {
                            BlocProvider.of<InitDataCubit>(context).billDate =
                            "${value.year}-${value.month}-${value.day}";
                            BlocProvider.of<InitDataCubit>(context).emit(InitDataBillDate(
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
                    TextFormField(
                      controller: _serialNumberController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(WarrantyIcons.warrenty_comment),
                          onPressed: () {
                            //todo: display a dialog -or a tooltip- that explaine how to find the serial number with a image preview
                            if (BlocProvider.of<InitDataCubit>(context).battery != null) {
                              var serialNumberImage =
                                  BlocProvider.of<InitDataCubit>(context)
                                      .battery
                                      .serialNumberImage;
                              var info = AppLocalizations.of(context)
                                  .locale
                                  .languageCode
                                  .contains("ar")
                                  ? BlocProvider.of<InitDataCubit>(context).battery.infoAr
                                  : BlocProvider.of<InitDataCubit>(context)
                                  .battery
                                  .infoEn;
                              showDialog(
                                context: context,
                                builder: (context) => whereIsSerialNumberDialog(
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
                        labelText: AppLocalizations.of(context).translate("serialNumber"),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Colors.black45),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate("yourName"),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Colors.black45),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onChanged: (value) {
                        //todo: make the user enter his name in english
                        BlocProvider.of<InitDataCubit>(context).fullName = value;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate("yourAddress"),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Colors.black45),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onChanged: (value) {
                        //todo: make the user enter his name in english
                        BlocProvider.of<InitDataCubit>(context).address = value;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate("yourEmail"),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Colors.black45),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onChanged: (value) {
                        BlocProvider.of<InitDataCubit>(context).eMail = value;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText:
                        AppLocalizations.of(context).translate("yourPhoneNumber"),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Colors.black45),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onChanged: (value) {
                        BlocProvider.of<InitDataCubit>(context).eMail = value;
                      },
                    ),

                    SizedBox(
                      height: 36,
                    ),
                    Row(
                      children: [
                        Expanded(
                          //todo: String Search like car model
                          child: StreamBuilder<int>(
                              stream:
                              BlocProvider.of<InitDataCubit>(context).carTypeIdStream,
                              initialData: null,
                              builder: (context, snapshot) {
                                return DropdownButton<int>(
                                  onChanged: (e) {
                                    //todo: save CarType "id" in form state managment
                                    // setState(() {
                                    //   _carTypeValue = e;
                                    // });
                                    BlocProvider.of<InitDataCubit>(context)
                                        .carTypeIdSelectedValue(e);
                                  },
                                  isExpanded: true,
                                  hint: Text(
                                      AppLocalizations.of(context).translate("carModel")),
                                  value: snapshot.data,
                                  items: carTypes
                                      .map((e) => DropdownMenuItem<int>(
                                    value: e.id,
                                    child: Text(AppLocalizations.of(context)
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
                                    child: Text(AppLocalizations.of(context)
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
                    TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                        onTap: () {
                          _marketController.clear();
                        },
                        // keyboardType: TextInputType.number,
                        controller: this._marketController,
                        decoration: InputDecoration(
                          // todo : fix amperage word
                          labelText: AppLocalizations.of(context).translate("marketName"),
                          // hintText: AppLocalizations.of(context).translate("ex40"),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide(color: Colors.black45),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
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
                                  .contains(pattern.toLowerCase())) results.add(market);
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
                      transitionBuilder: (context, suggestionsBox, controller) {
                        return SuggestionsBoxWrapper(
                            AppLocalizations.of(context).translate("selectYourMarket"),
                            suggestionsBox);
                      },
                      onSuggestionSelected: (suggestion) {
                        //todo:save Battery "id" in the form provider
                        Market suggestedMarket = suggestion;
                        this._marketController.text = AppLocalizations.of(context)
                            .locale
                            .languageCode
                            .contains("ar")
                            ? suggestedMarket.nameAr
                            : suggestedMarket.nameEn;
                        BlocProvider.of<InitDataCubit>(context).market = suggestedMarket;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).translate("country"),
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
                              BlocProvider.of<InitDataCubit>(context).country =
                                  countryCode.name;
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

                    // DropdownButton<String>(
                    //   onChanged: (e) {
                    //     setState(() {
                    //       _countryValue = e;
                    //     });
                    //   },
                    //   isExpanded: true,
                    //   hint: Text(AppLocalizations.of(context).translate("country")),
                    //   value: _countryValue,
                    //   items: _countries
                    //       .map((e) => DropdownMenuItem<String>(
                    //             value: e,
                    //             child: Text(e),
                    //           ))
                    //       .toList(),
                    // ),
                    // Text("country"),
                    // ),
                    SizedBox(
                      height: 36,
                    ),
                    BlocBuilder<InitDataCubit, InitDataState>(
                      buildWhen: (previous, current) {
                        return current is InitDataBatteryChosen ||
                            current is InitDataFrontBatteryImage;
                      },
                      builder: (context, state) {
                        if (state is InitDataBatteryChosen)
                          return FlatButton(
                            child: ImagePreview(
                              AppLocalizations.of(context).translate("batteryFrontImage"),
                              AppLocalizations.of(context).translate("example"),
                              CachedNetworkImage(
                                imageUrl: "$baseUrl/${state.battery.frontImage}",
                                fit: BoxFit.cover,
                              ),
                            ),
                            onPressed: () async {
                              final picker = ImagePicker();
                              final pickedFile =
                              await picker.getImage(source: ImageSource.camera);
                              print(pickedFile.path);
                              BlocProvider.of<InitDataCubit>(context)
                                  .emit(InitDataFrontBatteryImage(pickedFile.path));
                            },
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                          );
                        else if (state is InitDataFrontBatteryImage)
                          return FlatButton(
                            child: ImagePreview(
                                AppLocalizations.of(context)
                                    .translate("batteryFrontImage"),
                                AppLocalizations.of(context)
                                    .translate("tapAgainToChange"),
                                Image.file(File(state.imagePath))),
                            onPressed: () async {
                              final picker = ImagePicker();
                              final pickedFile =
                              await picker.getImage(source: ImageSource.camera);
                              print(pickedFile.path);
                              BlocProvider.of<InitDataCubit>(context)
                                  .emit(InitDataFrontBatteryImage(pickedFile.path));
                            },
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                          );
                        else
                          return FlatButton(
                            child: ImagePreview(
                                AppLocalizations.of(context)
                                    .translate("batteryFrontImage"),
                                //todo: translate "didn't select Battery to help you with instructions"
                                "didn't select Battery to help you with instructions",
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      WarrantyIcons.warrenty_clear,
                                      size: 108,
                                    ),
                                    Text("Please Choose A Battery")
                                  ],
                                )),
                            onPressed: () async {
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
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
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
                              AppLocalizations.of(context).translate("fixedBatteryImage"),
                              AppLocalizations.of(context).translate("tapAgainToChange"),
                              Image.file(
                                File(state.imagePath),
                                fit: BoxFit.cover,
                              )),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final pickedFile =
                            await picker.getImage(source: ImageSource.camera);
                            print(pickedFile.path);
                            BlocProvider.of<InitDataCubit>(context)
                                .emit(InitDataFixedBatteryImage(pickedFile.path));
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
                              AppLocalizations.of(context).translate("fixedBatteryImage"),
                              AppLocalizations.of(context).translate("example"),
                              Image.asset(
                                "assets/images/bill.jpg",
                                fit: BoxFit.cover,
                              )),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final pickedFile =
                            await picker.getImage(source: ImageSource.camera);
                            print(pickedFile.path);
                            BlocProvider.of<InitDataCubit>(context)
                                .emit(InitDataFixedBatteryImage(pickedFile.path));
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
                              AppLocalizations.of(context).translate("tapAgainToChange"),
                              Image.file(
                                File(state.imagePath),
                                fit: BoxFit.cover,
                              )),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final pickedFile =
                            await picker.getImage(source: ImageSource.camera);
                            print(pickedFile.path);
                            BlocProvider.of<InitDataCubit>(context)
                                .emit(InitDataCarNumber(pickedFile.path));
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
                            final pickedFile =
                            await picker.getImage(source: ImageSource.camera);
                            print(pickedFile.path);
                            BlocProvider.of<InitDataCubit>(context)
                                .emit(InitDataCarNumber(pickedFile.path));
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
                child: Text("error"),
              );
            }
          },
        ),
      ),
    );
  }
}

class WarrantyAddetionForm extends StatefulWidget {
  final List<Battery> _batteries;
  final List<Market> _markets;
  final List<CarType> _carTypes;
  final List<CarProperty> _carProperties;

  WarrantyAddetionForm(
      this._batteries, this._markets, this._carTypes, this._carProperties);

  @override
  _WarrantyAddetionFormState createState() => _WarrantyAddetionFormState();
}

class _WarrantyAddetionFormState extends State<WarrantyAddetionForm> {
  var _batteryController = TextEditingController();
  var _serialNumberController = TextEditingController();
  var _marketController = TextEditingController();

  String _fixImagePath = "assets/images/home/1.png";
  String _fixedBatteryImage = "assets/images/bill.jpg";
  String _carNumberImage = "assets/images/number.jpg";

  String _battaryModelValue;
  int _carTypeValue;
  int _carPropertyValue;
  int _countryValue;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: ListView(
        shrinkWrap: true,
        children: [
          // https://pub.dev/packages/flutter_typeahead
          SizedBox(
            height: 8,
          ),
          TypeAheadFormField(
            // noItemsFoundBuilder: (context) {
            //   return Padding(
            //     padding: const EdgeInsets.all(4.0),
            //     child: Center(
            //       child: RaisedButton(
            //         textColor: Colors.white,
            //         color: Theme.of(context).primaryColor,
            //         onPressed: () {
            //           //todo: add new Customer
            //           Navigator.of(context).push(MaterialPageRoute(
            //               builder: (context) => AddNewCustomer()));
            //         },
            //         child: Padding(
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: [
            //               Icon(
            //                 FontAwesomeIcons.userEdit,
            //                 size: 16,
            //               ),
            //               SizedBox(
            //                 width: 16,
            //               ),
            //               Column(
            //                 mainAxisSize: MainAxisSize.min,
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     "Customer not found!",
            //                   ),
            //                   Text("Press here to add")
            //                 ],
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   );
            // },
            textFieldConfiguration: TextFieldConfiguration(
              onTap: () {
                _batteryController.clear();
              },
              keyboardType: TextInputType.number,
              controller: this._batteryController,
              decoration: InputDecoration(
                // todo : fix amprage word
                labelText: AppLocalizations.of(context)
                    .translate("enterBatteryAmperage"),
                hintText: AppLocalizations.of(context).translate("ex40"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Colors.black45),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
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

              widget._batteries.forEach((battreyModel) {
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
                          imageUrl: "$baseUrl${suggestedBattry.image}",
                          // imageUrl: "http://via.placeholder.com/350x150",
                          // placeholder: (context,text)=>CircularProgressIndicator(),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
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

            transitionBuilder: (context, suggestionsBox, controller) {
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
              BlocProvider.of<InitDataCubit>(context).battery = suggestedBattry;
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
          SizedBox(
            height: 8,
          ),
          BlocBuilder<InitDataCubit, InitDataState>(
              buildWhen: (previous, current) {
            // print(current is InitDataBillDate);
            return current is InitDataBillDate;
          }, builder: (context, state) {
            return FlatButton(
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              child: Text(BlocProvider.of<InitDataCubit>(context).billDate ??
                  AppLocalizations.of(context).translate("boughtDate")),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().add(Duration(days: -365 * 120)),
                  lastDate: DateTime.now().add(Duration(days: 1)),
                  // helpText: "Select Bill Date",
                ).then((value) {
                  BlocProvider.of<InitDataCubit>(context).billDate =
                      "${value.year}-${value.month}-${value.day}";
                  BlocProvider.of<InitDataCubit>(context).emit(InitDataBillDate(
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
          TextFormField(
            controller: _serialNumberController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(WarrantyIcons.warrenty_comment),
                onPressed: () {
                  //todo: display a dialog -or a tooltip- that explaine how to find the serial number with a image preview
                  if (BlocProvider.of<InitDataCubit>(context).battery != null) {
                    var serialNumberImage =
                        BlocProvider.of<InitDataCubit>(context)
                            .battery
                            .serialNumberImage;
                    var info = AppLocalizations.of(context)
                            .locale
                            .languageCode
                            .contains("ar")
                        ? BlocProvider.of<InitDataCubit>(context).battery.infoAr
                        : BlocProvider.of<InitDataCubit>(context)
                            .battery
                            .infoEn;
                    showDialog(
                      context: context,
                      builder: (context) => whereIsSerialNumberDialog(
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
              labelText: AppLocalizations.of(context).translate("serialNumber"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Colors.black45),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            onChanged: (value) {},
          ),
          SizedBox(
            height: 36,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate("yourName"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Colors.black45),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            onChanged: (value) {
              //todo: make the user enter his name in english
              BlocProvider.of<InitDataCubit>(context).fullName = value;
            },
          ),
          SizedBox(
            height: 8,
          ),

          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate("yourAddress"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Colors.black45),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            onChanged: (value) {
              //todo: make the user enter his name in english
              BlocProvider.of<InitDataCubit>(context).address = value;
            },
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate("yourEmail"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Colors.black45),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            onChanged: (value) {
              BlocProvider.of<InitDataCubit>(context).eMail = value;
            },
          ),
          SizedBox(
            height: 8,
          ),

          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText:
                  AppLocalizations.of(context).translate("yourPhoneNumber"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Colors.black45),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            onChanged: (value) {
              BlocProvider.of<InitDataCubit>(context).eMail = value;
            },
          ),

          SizedBox(
            height: 36,
          ),
          Row(
            children: [
              Expanded(
                //todo: String Search like car model
                child: StreamBuilder<int>(
                    stream:
                        BlocProvider.of<InitDataCubit>(context).carTypeIdStream,
                    initialData: null,
                    builder: (context, snapshot) {
                      return DropdownButton<int>(
                        onChanged: (e) {
                          //todo: save CarType "id" in form state managment
                          // setState(() {
                          //   _carTypeValue = e;
                          // });
                          BlocProvider.of<InitDataCubit>(context)
                              .carTypeIdSelectedValue(e);
                        },
                        isExpanded: true,
                        hint: Text(
                            AppLocalizations.of(context).translate("carModel")),
                        value: snapshot.data,
                        items: widget._carTypes
                            .map((e) => DropdownMenuItem<int>(
                                  value: e.id,
                                  child: Text(AppLocalizations.of(context)
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
                        items: widget._carProperties
                            .map((e) => DropdownMenuItem<int>(
                                  value: e.id,
                                  child: Text(AppLocalizations.of(context)
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
          TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
              onTap: () {
                _marketController.clear();
              },
              // keyboardType: TextInputType.number,
              controller: this._marketController,
              decoration: InputDecoration(
                // todo : fix amperage word
                labelText: AppLocalizations.of(context).translate("marketName"),
                // hintText: AppLocalizations.of(context).translate("ex40"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Colors.black45),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
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
              widget._markets.forEach((market) {
                // if (battreyModel.capacity == searchedCapacity)
                //   results.add(battreyModel);
                if (market.nameAr.contains(pattern) ||
                    (market.nameEn.toLowerCase())
                        .contains(pattern.toLowerCase())) results.add(market);
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
            transitionBuilder: (context, suggestionsBox, controller) {
              return SuggestionsBoxWrapper(
                  AppLocalizations.of(context).translate("selectYourMarket"),
                  suggestionsBox);
            },
            onSuggestionSelected: (suggestion) {
              //todo:save Battery "id" in the form provider
              Market suggestedMarket = suggestion;
              this._marketController.text = AppLocalizations.of(context)
                      .locale
                      .languageCode
                      .contains("ar")
                  ? suggestedMarket.nameAr
                  : suggestedMarket.nameEn;
              BlocProvider.of<InitDataCubit>(context).market = suggestedMarket;
            },
          ),
          SizedBox(
            height: 8,
          ),
          Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            color: Theme.of(context).primaryColor,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).translate("country"),
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
                    BlocProvider.of<InitDataCubit>(context).country =
                        countryCode.name;
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

          // DropdownButton<String>(
          //   onChanged: (e) {
          //     setState(() {
          //       _countryValue = e;
          //     });
          //   },
          //   isExpanded: true,
          //   hint: Text(AppLocalizations.of(context).translate("country")),
          //   value: _countryValue,
          //   items: _countries
          //       .map((e) => DropdownMenuItem<String>(
          //             value: e,
          //             child: Text(e),
          //           ))
          //       .toList(),
          // ),
          // Text("country"),
          // ),
          SizedBox(
            height: 36,
          ),
          BlocBuilder<InitDataCubit, InitDataState>(
            buildWhen: (previous, current) {
              return current is InitDataBatteryChosen ||
                  current is InitDataFrontBatteryImage;
            },
            builder: (context, state) {
              if (state is InitDataBatteryChosen)
                return FlatButton(
                  child: ImagePreview(
                    AppLocalizations.of(context).translate("batteryFrontImage"),
                    AppLocalizations.of(context).translate("example"),
                    CachedNetworkImage(
                      imageUrl: "$baseUrl/${state.battery.frontImage}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  onPressed: () async {
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.getImage(source: ImageSource.camera);
                    print(pickedFile.path);
                    BlocProvider.of<InitDataCubit>(context)
                        .emit(InitDataFrontBatteryImage(pickedFile.path));
                  },
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                );
              else if (state is InitDataFrontBatteryImage)
                return FlatButton(
                  child: ImagePreview(
                      AppLocalizations.of(context)
                          .translate("batteryFrontImage"),
                      AppLocalizations.of(context)
                          .translate("tapAgainToChange"),
                      Image.file(File(state.imagePath))),
                  onPressed: () async {
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.getImage(source: ImageSource.camera);
                    print(pickedFile.path);
                    BlocProvider.of<InitDataCubit>(context)
                        .emit(InitDataFrontBatteryImage(pickedFile.path));
                  },
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                );
              else
                return FlatButton(
                  child: ImagePreview(
                      AppLocalizations.of(context)
                          .translate("batteryFrontImage"),
                      //todo: translate "didn't select Battery to help you with instructions"
                      "didn't select Battery to help you with instructions",
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            WarrantyIcons.warrenty_clear,
                            size: 108,
                          ),
                          Text("Please Choose A Battery")
                        ],
                      )),
                  onPressed: () async {
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
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
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
                    AppLocalizations.of(context).translate("fixedBatteryImage"),
                    AppLocalizations.of(context).translate("tapAgainToChange"),
                    Image.file(
                      File(state.imagePath),
                      fit: BoxFit.cover,
                    )),
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.getImage(source: ImageSource.camera);
                  print(pickedFile.path);
                  BlocProvider.of<InitDataCubit>(context)
                      .emit(InitDataFixedBatteryImage(pickedFile.path));
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
                    AppLocalizations.of(context).translate("fixedBatteryImage"),
                    AppLocalizations.of(context).translate("example"),
                    Image.asset(
                      "assets/images/bill.jpg",
                      fit: BoxFit.cover,
                    )),
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.getImage(source: ImageSource.camera);
                  print(pickedFile.path);
                  BlocProvider.of<InitDataCubit>(context)
                      .emit(InitDataFixedBatteryImage(pickedFile.path));
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
                    AppLocalizations.of(context).translate("tapAgainToChange"),
                    Image.file(
                      File(state.imagePath),
                      fit: BoxFit.cover,
                    )),
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.getImage(source: ImageSource.camera);
                  print(pickedFile.path);
                  BlocProvider.of<InitDataCubit>(context)
                      .emit(InitDataCarNumber(pickedFile.path));
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
                  final pickedFile =
                      await picker.getImage(source: ImageSource.camera);
                  print(pickedFile.path);
                  BlocProvider.of<InitDataCubit>(context)
                      .emit(InitDataCarNumber(pickedFile.path));
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
            height: 250,
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
