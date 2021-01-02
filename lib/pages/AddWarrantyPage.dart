import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:ewarrenty/Icons/warranty_icons_icons.dart';
import 'package:ewarrenty/Models/Battery.dart';
import 'package:ewarrenty/Wrappers/SuggestionsBoxWrapper.dart';
import 'package:ewarrenty/app_localizations.dart';
import 'package:ewarrenty/customPainters/CurvePainter.dart';
import 'package:ewarrenty/customPainters/ElectricPainter.dart';
import 'package:ewarrenty/pages/AddNewCustomer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';

class AddWarrantyPage extends StatefulWidget {
  @override
  _AddWarrantyPageState createState() => _AddWarrantyPageState();
}

class _AddWarrantyPageState extends State<AddWarrantyPage> {
  List<Battery> _battaryModels = [
    Battery(
        battreyNumber: "42B19L",
        capacity: 35,
        image: "assets/images/home/1.png",
        previewImage: "assets/images/home/1.png"),
    Battery(
        battreyNumber: "54459",
        capacity: 44,
        image: "assets/images/home/2.png",
        previewImage: "assets/images/home/2.png"),
    Battery(
        battreyNumber: "55B24L",
        capacity: 45,
        image: "assets/images/home/3.png",
        previewImage: "assets/images/home/3.png"),
    Battery(
        battreyNumber: "55B24LS",
        capacity: 45,
        image: "assets/images/home/4.png",
        previewImage: "assets/images/home/4.png"),
    Battery(
        battreyNumber: "50D20L",
        capacity: 50,
        image: "assets/images/home/1.png",
        previewImage: "assets/images/home/1.png"),
    Battery(
        battreyNumber: "55559",
        capacity: 55,
        image: "assets/images/home/2.png",
        previewImage: "assets/images/home/2.png"),
    Battery(
        battreyNumber: "55D26L",
        capacity: 60,
        image: "assets/images/home/3.png",
        previewImage: "assets/images/home/3.png"),
    Battery(
        battreyNumber: "56638",
        capacity: 35,
        image: "assets/images/home/4.png",
        previewImage: "assets/images/home/4.png"),
  ];
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
  String _battaryModelValue;
  String _carTypeValue;
  String _carPropertyValue;
  String _countryValue;

  String _fixImagePath = "assets/images/home/1.png";
  String _billImagePath = "assets/images/bill.jpg";
  String _carNumberImage = "assets/images/number.jpg";

  String billDate;

  var _typeAheadController = TextEditingController();

  String _selectedUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // DropdownButtonValue = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("addWarranty")),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: ListView(
          shrinkWrap: true,
          children: [
            // Text("add battary model"),
            // DropdownButton<String>(
            //   onChanged: (e) {
            //     setState(() {
            //       _battaryModelValue = e;
            //     });
            //   },
            //   isExpanded: true,
            //   hint: Text("BattaryModels"),
            //   value: _battaryModelValue,
            //   items: _battaryModels
            //       .map((e) => DropdownMenuItem<String>(
            //             value: e,
            //             child: ListTile(title: Text(e)),
            //           ))
            //       .toList(),
            // ),

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
                  _typeAheadController.clear();
                },
                keyboardType: TextInputType.number,
                controller: this._typeAheadController,
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
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
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

                _battaryModels.forEach((battreyModel) {
                  if (battreyModel.capacity == searchedCapacity)
                    results.add(battreyModel);
                });

                return results;
              },
              itemBuilder: (context, suggestion) {
                print(suggestion is Battery);
                Battery suggestedBattry = suggestion;
                if (_typeAheadController.text.isNotEmpty)
                  return Card(
                    child: ExpansionTile(
                      trailing: Icon(Icons.image),
                      children: [
                        Image.asset(
                          suggestedBattry.image,
                          fit: BoxFit.cover,
                        ),
                      ],
                      title: Text(suggestedBattry.battreyNumber),
                      subtitle: Text(AppLocalizations.of(context)
                          .translate("pressImageIconToPreviewImage")),
                    ),
                  );
                else
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
                Battery suggestedBattry = suggestion;
                this._typeAheadController.text = suggestedBattry.battreyNumber;
              },
              // validator: (value) {
              //   if (value.isEmpty) {
              //     return 'Please select a city';
              //   }
              // },
              onSaved: (value) => this._selectedUser = value,
            ),
            SizedBox(
              height: 8,
            ),
            FlatButton(
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              child: Text(billDate ??
                  AppLocalizations.of(context).translate("boughtDate")),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().add(Duration(days: -365 * 120)),
                  lastDate: DateTime.now().add(Duration(days: 1)),
                  // helpText: "Select Bill Date",
                ).then((value) {
                  setState(() {
                    billDate = "${value.year}/${value.month}/${value.day}";
                  });
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(WarrantyIcons.warrenty_comment),
                  onPressed: () {
                    //todo: display a dialog -or a tooltip- that explaine how to find the serial number with a image preview
                  },
                ),
                labelText:
                    AppLocalizations.of(context).translate("serialNumber"),
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
              onChanged: (value) {},
            ),
            SizedBox(
              height: 8,
            ),

            TextFormField(
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate("yourAddress"),
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
              height: 8,
            ),

            TextFormField(
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
              onChanged: (value) {},
            ),
            SizedBox(
              height: 8,
            ),

            TextFormField(
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
              onChanged: (value) {},
            ),

            SizedBox(
              height: 36,
            ),
            Row(
              children: [
                Expanded(
                  //todo: String Search like car model
                  child: DropdownButton<String>(
                    onChanged: (e) {
                      setState(() {
                        _carTypeValue = e;
                      });
                    },
                    isExpanded: true,
                    hint: Text(
                        AppLocalizations.of(context).translate("carModel")),
                    value: _carTypeValue,
                    items: _carType
                        .map((e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                  ),
                ),
                // Expanded(child: Text("car type")),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: DropdownButton<String>(
                    onChanged: (e) {
                      setState(() {
                        _carPropertyValue = e;
                      });
                    },
                    isExpanded: true,
                    hint: Text(
                        AppLocalizations.of(context).translate("carProperty")),
                    value: _carPropertyValue,
                    items: _carProperty
                        .map((e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                  ),
                ),
                // Expanded(child: Text("car porperty")),
              ],
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
                  Text(AppLocalizations.of(context).translate("country"),style: TextStyle(color: Colors.white),),
                  CountryCodePicker(
                    textStyle: TextStyle(color: Colors.white),
                    // showDropDownButton: true,
                    showFlag: true,
                    // countryFilter: ['IL'],
                    onChanged: (countryCode){
                      print(countryCode.name);
                    },
                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                    initialSelection: 'CA',
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
            FlatButton(
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              child: _fixImagePath == null
                  ? Text(AppLocalizations.of(context)
                      .translate("batteryFrontImage"))
                  : ImagePreview(
                      AppLocalizations.of(context)
                          .translate("batteryFrontImage"),
                      _fixImagePath.contains("assets")
                          ? AppLocalizations.of(context).translate("example")
                          : AppLocalizations.of(context)
                              .translate("tapAgainToChange"),
                      _fixImagePath),
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.getImage(source: ImageSource.camera);
                print(pickedFile.path);
                setState(() {
                  _fixImagePath = pickedFile.path;
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
            FlatButton(
              child: _billImagePath == null
                  ? Text(AppLocalizations.of(context)
                      .translate("fixedBatteryImage"))
                  : ImagePreview(
                      AppLocalizations.of(context)
                          .translate("fixedBatteryImage"),
                      _billImagePath.contains("assets")
                          ? AppLocalizations.of(context).translate("example")
                          : AppLocalizations.of(context)
                              .translate("tapAgainToChange"),
                      _billImagePath),
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.getImage(source: ImageSource.camera);
                print(pickedFile.path);
                setState(() {
                  _billImagePath = pickedFile.path;
                });
              },
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
            ),

            SizedBox(
              height: 8,
            ),
            FlatButton(
              child: _carNumberImage == null
                  ? Text(AppLocalizations.of(context)
                      .translate("carNumberIncludingItsColorImage"))
                  : ImagePreview(
                      AppLocalizations.of(context)
                          .translate("carNumberIncludingItsColorImage"),
                      _carNumberImage.contains("assets")
                          ? AppLocalizations.of(context).translate("example")
                          : AppLocalizations.of(context)
                              .translate("tapAgainToChange"),
                      _carNumberImage),
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.getImage(source: ImageSource.camera);
                print(pickedFile.path);
                setState(() {
                  _carNumberImage = pickedFile.path;
                });
              },
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePreview extends StatelessWidget {
  final String _title;
  final String _subtitle;
  final String _imagePath;

  ImagePreview(this._title, this._subtitle, this._imagePath);

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
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: _imagePath.contains("assets")
                  ? Image.asset(_imagePath)
                  : Image.file(
                      File(
                        _imagePath,
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
