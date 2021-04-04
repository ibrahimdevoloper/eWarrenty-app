import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:ewarrenty/Blocs/AddCar/add_car_cubit.dart';
import 'package:ewarrenty/Blocs/AddMarket/add_market_cubit.dart';
import 'package:ewarrenty/Blocs/InitData/init_data_cubit.dart';
import 'package:ewarrenty/Constants/Constants.dart';
import 'package:ewarrenty/CustomWidget/ImagePreviewButton.dart';
import 'package:ewarrenty/Function/dateFormatter.dart';
import 'package:ewarrenty/Function/myImagePicker.dart';
import 'package:ewarrenty/Icons/warranty_icons_icons.dart';
import 'package:ewarrenty/Models/Battery.dart';
import 'package:ewarrenty/Models/car_type.dart';
import 'package:ewarrenty/Models/market.dart';
import 'package:ewarrenty/Wrappers/DropdownBoxWrapper.dart';
import 'package:ewarrenty/Wrappers/SuggestionsBoxWrapper.dart';
import 'package:ewarrenty/app_localizations.dart';
import 'package:ewarrenty/dialogs/showSummeryDialog.dart';
import 'package:ewarrenty/dialogs/whereIsSerialNumberDialog.dart';
// import 'package:ewarrenty/BottomSheets/AddMarketBottomSheet.dart';
import 'package:ewarrenty/pages/AddMarketPage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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

  FocusNode _batteryFieldNode = FocusNode();
  FocusNode _serialNumberFieldNode = FocusNode();
  FocusNode _marketFieldNode = FocusNode();

  FocusNode _fullNameFieldNode = FocusNode();
  FocusNode _addressFieldNode = FocusNode();
  FocusNode _emailFieldNode = FocusNode();
  FocusNode _phoneNumberFieldNode = FocusNode();
  FocusNode _carNumberFieldNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics().setCurrentScreen(
        screenName: "AddWarrantyPage", screenClassOverride: "AddWarrantyPage");
  }

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
              title: Text(
                AppLocalizations.of(context).translate("addWarranty"),
                style: GoogleFonts.cairo(),
              ),
            ),
            bottomNavigationBar: BlocBuilder<InitDataCubit, InitDataState>(
              builder: (context, state) => FlatButton(
                height: 56,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(
                  AppLocalizations.of(context).translate("submit"),
                  style: GoogleFonts.cairo(
                      fontSize: Theme.of(context).textTheme.headline6.fontSize),
                ),
                onPressed: () async {
                  // print("submit");
                  InitDataCubit mCubit =
                      BlocProvider.of<InitDataCubit>(context);
                  if (mCubit.battery == null) {
                    mCubit.batteryIsError = true;
                    mCubit.emit(InitDataBatteryChoosenTextFieldError());
                    // var snackBar = SnackBar(
                    //   content: Text(AppLocalizations.of(context)
                    //       .translate("pleaseChooseBatteryModel")),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.billDate == null) {
                    mCubit.emit(InitDataBillDateError());
                    mCubit.billDateIsError = true;
                    // var snackBar = SnackBar(
                    //   content: Text(AppLocalizations.of(context)
                    //       .translate("chooseBillDate")),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
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
                  // if (mCubit.eMail == null) {
                  //   //TODO: tanslate "Please Add Your E-mail"
                  //   mCubit.emit(InitDataEmailError());
                  //   mCubit.eMailIsError = true;
                  //   // var snackBar = SnackBar(
                  //   //   content: Text("Please Add Your E-mail"),
                  //   //   duration: Duration(milliseconds: 600),
                  //   // );
                  //   // Scaffold.of(context).showSnackBar(snackBar);
                  // }
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
                  if (mCubit.countryName == null) {
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
                    mCubit.frontBatteryPathIsError = true;
                    mCubit.battery == null
                        ? mCubit.emit(InitDataFrontBatteryImageError())
                        : mCubit.emit(InitDataFrontBatteryImageError());
                    // var snackBar = SnackBar(
                    //   content: Text("Please capture Your battery front"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.fixedBatteryPath == null) {
                    //TODO: tanslate "Please capture Your fixed battery"
                    mCubit.fixedBatteryPathIsError = true;
                    mCubit.emit(InitDataFixedBatteryImageError());
                    // var snackBar = SnackBar(
                    //   content: Text("Please capture Your fixed battery"),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.carNumberPath == null) {
                    //TODO: tanslate "Please capture Your car"
                    mCubit.carNumberPathIsError = true;
                    mCubit.emit(InitDataCarNumberImageError());
                    // var snackBar = SnackBar(
                    //   content: Text("Please capture Your Car "),
                    //   duration: Duration(milliseconds: 600),
                    // );
                    // Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (mCubit.billImagePath == null) {
                    //TODO: tanslate "Please capture Your car"
                    mCubit.billImagePathIsError = true;
                    mCubit.emit(InitDataBillImageImageError());
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
                    //TODO: test the connection to the api
                    // if (mCubit.carTypeId != null && mCubit.market != null)
                    await mCubit.submitWarrantyData();
                    // else if (mCubit.carTypeId == null && mCubit.market != null)
                    //   await mCubit.submitWarrantyDataWithoutCar();
                    // else if (mCubit.carTypeId != null && mCubit.market == null)
                    //   await mCubit.submitWarrantyDataWithoutMarket();
                    // else if (mCubit.carTypeId == null && mCubit.market == null)
                    //   await mCubit.submitWarrantyDataWithoutMarketAndCar();
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
                      // progress.show();
                    }
                    if (state is InitDataSubmitSent) {
                      // var warranty = state.warranty;
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
                            (current is InitDataCarNumberImage) ||
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
                            (current is InitDataCarPropertyReset) ||
                            (current is InitDataFrontBatteryImageError) ||
                            // (current
                            //     is InitDataFrontBatteryImageErrorWhileBatteyIsChoosen) ||
                            (current is InitDataFixedBatteryImage) ||
                            (current is InitDataFixedBatteryImageError) ||
                            (current is InitDataCarNumberImage) ||
                            (current is InitDataCarNumberImageError) ||
                            (current is InitDataBillImageImage) ||
                            (current is InitDataBillImageImageError) ||
                            (current is InitDataPhoneNumberCountryCode)
                        // ||
                        // (current is InitDataNewMarketNameError) ||
                        // (current is InitDataNewMarketAddressError) ||
                        // (current is InitDataNewMarketNameReset) ||
                        // (current is InitDataNewMarketAddressReset)
                        );
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        child: ListView(
                          shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          children: [
                            // https://pub.dev/packages/flutter_typeahead
                            SizedBox(
                              height: 8,
                            ),
                            BatteryTextField(
                              batteryFieldNode: _batteryFieldNode,
                              batteryTextEditingController:
                                  _batteryTextEditingController,
                              batteries: batteries,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            BillFlatButton(),
                            SizedBox(
                              height: 8,
                            ),
                            SerialNumberTextField(
                              serialTextEditingNumberController:
                                  _serialTextEditingNumberController,
                              serialNumberFieldNode: _serialNumberFieldNode,
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            FullnameTextField(
                              fullNameFieldNode: _fullNameFieldNode,
                              fullNameTextEditingController:
                                  _fullNameTextEditingController,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            CountryPickerButton(),
                            SizedBox(
                              height: 8,
                            ),
                            AddressTextField(
                              addressTextEditingController:
                                  _addressTextEditingController,
                              addressFieldNode: _addressFieldNode,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            EmailTextField(
                              emailFieldNode: _emailFieldNode,
                              emailTextEditingController:
                                  _emailTextEditingController,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            PhoneNumberTextField(
                              phoneNumberTextEditingController:
                                  _phoneNumberTextEditingController,
                              phoneNumberFieldNode: _phoneNumberFieldNode,
                            ),

                            SizedBox(
                              height: 36,
                            ),
                            Row(
                              //TODO: check design when error is null
                              children: [
                                Expanded(
                                  //TODO: String Search like car model
                                  child: CarTypeDropdown(carTypes: carTypes),
                                ),
                                // Expanded(child: Text("car type")),
                                SizedBox(
                                  width: 8,
                                ),

                                Expanded(
                                  child: CarPropertyDropdown(
                                      carProperties: carProperties),
                                ),
                                // Expanded(child: Text("car porperty")),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            MarketDropdown(
                                marketFieldNode: _marketFieldNode,
                                marketTextEditingController:
                                    _marketTextEditingController,
                                markets: markets),
                            SizedBox(
                              height: 8,
                            ),
                            CarNumberTextField(
                                carNumberTextEditingController:
                                    _carNumberTextEditingController,
                                carNumberFieldNode: _carNumberFieldNode),
                            SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            BillImageButton(),
                            SizedBox(
                              height: 8,
                            ),
                            // battery front Image
                            AddBatteryFrontImageButton(),
                            SizedBox(
                              height: 8,
                            ),
                            //fixed battery image
                            AddFixedBatteryImageButton(),
                            SizedBox(
                              height: 8,
                            ),
                            CarNumberIncludingItsColorImageButton(),
                            SizedBox(
                              height: 16,
                            ),
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

class BillImageButton extends StatelessWidget {
  const BillImageButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
        buildWhen: (previous, current) {
      return current is InitDataBillImageImage ||
          current is InitDataBillImageImageError;
    }, builder: (context, state) {
      if (state is InitDataBillImageImageError)
        return CustomButtonForImagePreview(
          isError: true,
          title: AppLocalizations.of(context).translate("billImage"),
          subtitle: AppLocalizations.of(context).translate("example"),
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.blue, width: 4)),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              //TODO: Change to bill example
              AppLocalizations.of(context).locale.languageCode.contains("ar")
                  ? "assets/images/billImageArabic.png"
                  : "assets/images/billImage.png",
              fit: BoxFit.cover,
            ),
          ),
          onTap: () async {
            // final picker = ImagePicker();
            // final pickedFile = await picker.getImage(
            //     source: ImageSource.camera);
            // print(pickedFile.path);
            var mPath = await myImagePicker();
            BlocProvider.of<InitDataCubit>(context).billImagePathIsError =
                false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataBillImageImage(mPath));
            BlocProvider.of<InitDataCubit>(context).billImagePath = mPath;
            // setState(() {
            //   _fixedBatteryImage = pickedFile.path;
            // });
          },
        );
      else if (BlocProvider.of<InitDataCubit>(context).billImagePathIsError)
        return CustomButtonForImagePreview(
          isError: true,
          title: AppLocalizations.of(context).translate("billImage"),
          subtitle: AppLocalizations.of(context).translate("example"),
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.blue, width: 4)),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              AppLocalizations.of(context).locale.languageCode.contains("ar")
                  ? "assets/images/billImageArabic.png"
                  : "assets/images/billImage.png",
              fit: BoxFit.cover,
            ),
          ),
          onTap: () async {
            // final picker = ImagePicker();
            // final pickedFile = await picker.getImage(
            //     source: ImageSource.camera);
            // print(pickedFile.path);
            var mPath = await myImagePicker();
            BlocProvider.of<InitDataCubit>(context).billImagePathIsError =
                false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataBillImageImage(mPath));
            BlocProvider.of<InitDataCubit>(context).billImagePath = mPath;
            // setState(() {
            //   _fixedBatteryImage = pickedFile.path;
            // });
          },
        );
      else if (state is InitDataBillImageImage)
        return CustomButtonForImagePreview(
          isError: false,
          title: AppLocalizations.of(context).translate("billImage"),
          subtitle: AppLocalizations.of(context).translate("tapAgainToChange"),
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
            BlocProvider.of<InitDataCubit>(context).billImagePathIsError =
                false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataBillImageImage(mPath));
            BlocProvider.of<InitDataCubit>(context).billImagePath = mPath;
            // setState(() {
            //   _fixedBatteryImage = pickedFile.path;
            // });
          },
        );
      else if (BlocProvider.of<InitDataCubit>(context).billImagePath != null)
        return CustomButtonForImagePreview(
          isError: false,
          title: AppLocalizations.of(context).translate("billImage"),
          subtitle: AppLocalizations.of(context).translate("tapAgainToChange"),
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.blue, width: 4)),
            clipBehavior: Clip.antiAlias,
            child: Image.file(
              File(BlocProvider.of<InitDataCubit>(context).billImagePath),
              fit: BoxFit.cover,
            ),
          ),
          onTap: () async {
            // final picker = ImagePicker();
            // final pickedFile = await picker.getImage(
            //     source: ImageSource.camera);
            // print(pickedFile.path);
            var mPath = await myImagePicker();
            BlocProvider.of<InitDataCubit>(context).billImagePathIsError =
                false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataBillImageImage(mPath));
            BlocProvider.of<InitDataCubit>(context).billImagePath = mPath;
          },
        );
      else
        return CustomButtonForImagePreview(
          isError: false,
          title: AppLocalizations.of(context).translate("billImage"),
          subtitle: AppLocalizations.of(context).translate("example"),
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.blue, width: 4)),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              AppLocalizations.of(context).locale.languageCode.contains("ar")
                  ? "assets/images/billImageArabic.png"
                  : "assets/images/billImage.png",
              fit: BoxFit.cover,
            ),
          ),
          onTap: () async {
            // final picker = ImagePicker();
            // final pickedFile = await picker.getImage(
            //     source: ImageSource.camera);
            // print(pickedFile.path);
            var mPath = await myImagePicker();
            BlocProvider.of<InitDataCubit>(context).billImagePathIsError =
                false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataBillImageImage(mPath));
            BlocProvider.of<InitDataCubit>(context).billImagePath = mPath;
            // setState(() {
            //   _fixedBatteryImage = pickedFile.path;
            // });
          },
        );
    });
  }
}

class CarNumberIncludingItsColorImageButton extends StatelessWidget {
  const CarNumberIncludingItsColorImageButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
        buildWhen: (previous, current) {
      return current is InitDataCarNumberImage ||
          current is InitDataCarNumberImageError;
    }, builder: (context, state) {
      if (state is InitDataCarNumberImageError)
        return CustomButtonForImagePreview(
          isError: true,
          title: AppLocalizations.of(context)
              .translate("carNumberIncludingItsColorImage"),
          subtitle: AppLocalizations.of(context).translate("example"),
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
            BlocProvider.of<InitDataCubit>(context).carNumberPathIsError =
                false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataCarNumberImage(mPath));
            BlocProvider.of<InitDataCubit>(context).carNumberPath = mPath;
            // setState(() {
            //   _fixedBatteryImage = pickedFile.path;
            // });
          },
        );
      else if (BlocProvider.of<InitDataCubit>(context).carNumberPathIsError)
        return CustomButtonForImagePreview(
          isError: true,
          title: AppLocalizations.of(context)
              .translate("carNumberIncludingItsColorImage"),
          subtitle: AppLocalizations.of(context).translate("example"),
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
            BlocProvider.of<InitDataCubit>(context).carNumberPathIsError =
                false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataCarNumberImage(mPath));
            BlocProvider.of<InitDataCubit>(context).carNumberPath = mPath;
            // setState(() {
            //   _fixedBatteryImage = pickedFile.path;
            // });
          },
        );
      else if (state is InitDataCarNumberImage)
        return CustomButtonForImagePreview(
          isError: false,
          title: AppLocalizations.of(context)
              .translate("carNumberIncludingItsColorImage"),
          subtitle: AppLocalizations.of(context).translate("tapAgainToChange"),
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
            BlocProvider.of<InitDataCubit>(context).carNumberIsError = false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataCarNumberImage(mPath));
            BlocProvider.of<InitDataCubit>(context).carNumberPath = mPath;
            // setState(() {
            //   _fixedBatteryImage = pickedFile.path;
            // });
          },
        );
      else if (BlocProvider.of<InitDataCubit>(context).carNumberPath != null)
        return CustomButtonForImagePreview(
          isError: false,
          title: AppLocalizations.of(context)
              .translate("carNumberIncludingItsColorImage"),
          subtitle: AppLocalizations.of(context).translate("tapAgainToChange"),
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.blue, width: 4)),
            clipBehavior: Clip.antiAlias,
            child: Image.file(
              File(BlocProvider.of<InitDataCubit>(context).carNumberPath),
              fit: BoxFit.cover,
            ),
          ),
          onTap: () async {
            // final picker = ImagePicker();
            // final pickedFile = await picker.getImage(
            //     source: ImageSource.camera);
            // print(pickedFile.path);
            var mPath = await myImagePicker();
            BlocProvider.of<InitDataCubit>(context).carNumberIsError = false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataCarNumberImage(mPath));
            BlocProvider.of<InitDataCubit>(context).carNumberPath = mPath;
          },
        );
      else
        return CustomButtonForImagePreview(
          isError: false,
          title: AppLocalizations.of(context)
              .translate("carNumberIncludingItsColorImage"),
          subtitle: AppLocalizations.of(context).translate("example"),
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
            BlocProvider.of<InitDataCubit>(context).carNumberIsError = false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataCarNumberImage(mPath));
            BlocProvider.of<InitDataCubit>(context).carNumberPath = mPath;
            // setState(() {
            //   _fixedBatteryImage = pickedFile.path;
            // });
          },
        );
    });
  }
}

class AddFixedBatteryImageButton extends StatelessWidget {
  const AddFixedBatteryImageButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
        buildWhen: (previous, current) {
      return current is InitDataFixedBatteryImage ||
          current is InitDataFixedBatteryImageError;
    }, builder: (context, state) {
      if (state is InitDataFixedBatteryImageError)
        return CustomButtonForImagePreview(
          isError: true,
          title: AppLocalizations.of(context).translate("addFixedBatteryImage"),
          subtitle: AppLocalizations.of(context).translate("example"),
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
            BlocProvider.of<InitDataCubit>(context).fixedBatteryPathIsError =
                false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataFixedBatteryImage(mPath));
            BlocProvider.of<InitDataCubit>(context).fixedBatteryPath = mPath;
            // setState(() {
            //   _fixedBatteryImage = pickedFile.path;
            // });
          },
        );
      else if (BlocProvider.of<InitDataCubit>(context).fixedBatteryPathIsError)
        return CustomButtonForImagePreview(
          isError: true,
          title: AppLocalizations.of(context).translate("addFixedBatteryImage"),
          subtitle: AppLocalizations.of(context).translate("example"),
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
            BlocProvider.of<InitDataCubit>(context).fixedBatteryPathIsError =
                false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataFixedBatteryImage(mPath));
            BlocProvider.of<InitDataCubit>(context).fixedBatteryPath = mPath;
            // setState(() {
            //   _fixedBatteryImage = pickedFile.path;
            // });
          },
        );
      else if (state is InitDataFixedBatteryImage)
        return CustomButtonForImagePreview(
          isError: false,
          title: AppLocalizations.of(context).translate("addFixedBatteryImage"),
          subtitle: AppLocalizations.of(context).translate("tapAgainToChange"),
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
            BlocProvider.of<InitDataCubit>(context).fixedBatteryPathIsError =
                false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataFixedBatteryImage(mPath));
            BlocProvider.of<InitDataCubit>(context).fixedBatteryPath = mPath;
            // setState(() {
            //   _fixedBatteryImage = pickedFile.path;
            // });
          },
        );
      else if (BlocProvider.of<InitDataCubit>(context).fixedBatteryPath != null)
        return CustomButtonForImagePreview(
          isError: false,
          title: AppLocalizations.of(context).translate("addFixedBatteryImage"),
          subtitle: AppLocalizations.of(context).translate("tapAgainToChange"),
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.blue, width: 4)),
            clipBehavior: Clip.antiAlias,
            child: Image.file(
              File(BlocProvider.of<InitDataCubit>(context).fixedBatteryPath),
              fit: BoxFit.cover,
            ),
          ),
          onTap: () async {
            // final picker = ImagePicker();
            // final pickedFile = await picker.getImage(
            //     source: ImageSource.camera);
            // print(pickedFile.path);
            var mPath = await myImagePicker();
            BlocProvider.of<InitDataCubit>(context).fixedBatteryPathIsError =
                false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataFixedBatteryImage(mPath));
            BlocProvider.of<InitDataCubit>(context).fixedBatteryPath = mPath;
            // setState(() {
            //   _fixedBatteryImage = pickedFile.path;
            // });
          },
        );
      else
        return CustomButtonForImagePreview(
          isError: false,
          title: AppLocalizations.of(context).translate("addFixedBatteryImage"),
          subtitle: AppLocalizations.of(context).translate("example"),
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
            BlocProvider.of<InitDataCubit>(context).fixedBatteryPathIsError =
                false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataFixedBatteryImage(mPath));
            BlocProvider.of<InitDataCubit>(context).fixedBatteryPath = mPath;
            // setState(() {
            //   _fixedBatteryImage = pickedFile.path;
            // });
          },
        );
    });
  }
}

class AddBatteryFrontImageButton extends StatelessWidget {
  const AddBatteryFrontImageButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        // print(current is InitDataBatteryChosen ||
        //     current is InitDataFrontBatteryImage);
        return current is InitDataBatteryChosenForImage ||
            current is InitDataFrontBatteryImage ||
            current is InitDataFrontBatteryImageError;
        // current is InitDataFrontBatteryImageErrorWhileBatteyIsNotChoosen ||
        // current is InitDataFrontBatteryImageErrorWhileBatteyIsChoosen;
      },
      builder: (context, state) {
        print(state);
        if (state is InitDataFrontBatteryImageError) {
          return CustomButtonForImagePreview(
            isError: true,
            title:
                AppLocalizations.of(context).translate("addBatteryFrontImage"),
            subtitle: AppLocalizations.of(context).translate("example"),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.blue, width: 4)),
              clipBehavior: Clip.antiAlias,
              child: Image.asset('assets/images/batteryExample.png'),
            ),
            onTap: () async {
              // final picker = ImagePicker();
              // final pickedFile = await picker.getImage(
              //     source: ImageSource.camera);
              // print(pickedFile.path);
              var mPath = await myImagePicker();
              BlocProvider.of<InitDataCubit>(context).frontBatteryPathIsError =
                  false;
              BlocProvider.of<InitDataCubit>(context)
                  .emit(InitDataFrontBatteryImage(mPath));
              BlocProvider.of<InitDataCubit>(context).frontBatteryPath = mPath;
            },
          );
        } else if (BlocProvider.of<InitDataCubit>(context)
            .frontBatteryPathIsError) {
          // ignore: missing_return
          return CustomButtonForImagePreview(
            isError: true,
            title:
                AppLocalizations.of(context).translate("addBatteryFrontImage"),
            subtitle: AppLocalizations.of(context).translate("example"),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.blue, width: 4)),
              clipBehavior: Clip.antiAlias,
              child: Image.asset('assets/images/batteryExample.png'),
            ),
            onTap: () async {
              // final picker = ImagePicker();
              // final pickedFile = await picker.getImage(
              //     source: ImageSource.camera);
              // print(pickedFile.path);
              var mPath = await myImagePicker();
              BlocProvider.of<InitDataCubit>(context).frontBatteryPathIsError =
                  false;
              BlocProvider.of<InitDataCubit>(context)
                  .emit(InitDataFrontBatteryImage(mPath));
              BlocProvider.of<InitDataCubit>(context).frontBatteryPath = mPath;
            },
          );
        } else if (state is InitDataFrontBatteryImage) {
          return CustomButtonForImagePreview(
            isError: false,
            title:
                AppLocalizations.of(context).translate("addBatteryFrontImage"),
            subtitle:
                AppLocalizations.of(context).translate("tapAgainToChange"),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.blue, width: 4)),
              clipBehavior: Clip.antiAlias,
              child: Image.file(
                File(
                  state.imagePath,
                ),
                fit: BoxFit.cover,
              ),
            ),
            onTap: () async {
              // final picker = ImagePicker();
              // final pickedFile = await picker.getImage(
              //     source: ImageSource.camera);
              // print(pickedFile.path);
              var mPath = await myImagePicker();
              BlocProvider.of<InitDataCubit>(context).frontBatteryPathIsError =
                  false;
              BlocProvider.of<InitDataCubit>(context)
                  .emit(InitDataFrontBatteryImage(mPath));
              BlocProvider.of<InitDataCubit>(context).frontBatteryPath = mPath;
            },
          );
        } else if (BlocProvider.of<InitDataCubit>(context).frontBatteryPath !=
            null) {
          return CustomButtonForImagePreview(
            isError: false,
            title:
                AppLocalizations.of(context).translate("addBatteryFrontImage"),
            subtitle: AppLocalizations.of(context).translate("example"),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.blue, width: 4)),
              clipBehavior: Clip.antiAlias,
              child: Image.file(
                File(BlocProvider.of<InitDataCubit>(context).frontBatteryPath),
                fit: BoxFit.cover,
              ),
            ),
            onTap: () async {
              // final picker = ImagePicker();
              // final pickedFile = await picker.getImage(
              //     source: ImageSource.camera);
              // print(pickedFile.path);
              var mPath = await myImagePicker();
              BlocProvider.of<InitDataCubit>(context).frontBatteryPathIsError =
                  false;
              BlocProvider.of<InitDataCubit>(context)
                  .emit(InitDataFrontBatteryImage(mPath));
              BlocProvider.of<InitDataCubit>(context).frontBatteryPath = mPath;
            },
          );
        } else {
          return CustomButtonForImagePreview(
            isError: false,
            title:
                AppLocalizations.of(context).translate("addBatteryFrontImage"),
            subtitle: AppLocalizations.of(context).translate("example"),
            child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.blue, width: 4)),
                clipBehavior: Clip.antiAlias,
                child: Image.asset('assets/images/batteryExample.png')),
            onTap: () async {
              // var snackbar = SnackBar(
              //   content: Text(AppLocalizations.of(context)
              //       .translate("SelectBatteryToHelpYouWithInstructions")),
              // );
              // Scaffold.of(context).showSnackBar(snackbar);
              var mPath = await myImagePicker();
              BlocProvider.of<InitDataCubit>(context).frontBatteryPathIsError =
                  false;
              BlocProvider.of<InitDataCubit>(context)
                  .emit(InitDataFrontBatteryImage(mPath));
              BlocProvider.of<InitDataCubit>(context).frontBatteryPath = mPath;
            },
          );
        }
      },
    );
  }
}

class CarNumberTextField extends StatelessWidget {
  const CarNumberTextField({
    Key key,
    @required TextEditingController carNumberTextEditingController,
    @required FocusNode carNumberFieldNode,
  })  : _carNumberTextEditingController = carNumberTextEditingController,
        _carNumberFieldNode = carNumberFieldNode,
        super(key: key);

  final TextEditingController _carNumberTextEditingController;
  final FocusNode _carNumberFieldNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        return current is InitDataCarNumberError ||
            current is InitDataCarNumberReset;
      },
      builder: (context, state) => TextFormField(
        onTap: () {
          BlocProvider.of<InitDataCubit>(context).carNumberIsError = false;
          BlocProvider.of<InitDataCubit>(context)
              .emit(InitDataCarNumberReset());
        },
        controller: _carNumberTextEditingController,
        // keyboardType: TextInputType.phone,
        focusNode: _carNumberFieldNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate("carNumberExample"),
          errorText: (state is InitDataCarNumberError) ||
                  (BlocProvider.of<InitDataCubit>(context).carNumberIsError)
              ? AppLocalizations.of(context).translate("pleaseAddYourCarNumber")
              : null,
          labelText: AppLocalizations.of(context).translate("yourCarNumber"),
          // AppLocalizations.of(context)
          //     .translate("yourPhoneNumber"),
          labelStyle: TextStyle(
            color: _carNumberFieldNode.hasFocus
                ? Theme.of(context).accentColor
                : Colors.blue,
          ),
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
          BlocProvider.of<InitDataCubit>(context).carNumber = value;
        },
      ),
    );
  }
}

class MarketDropdown extends StatelessWidget {
  const MarketDropdown({
    Key key,
    @required FocusNode marketFieldNode,
    @required TextEditingController marketTextEditingController,
    @required this.markets,
  })  : _marketFieldNode = marketFieldNode,
        _marketTextEditingController = marketTextEditingController,
        super(key: key);

  final FocusNode _marketFieldNode;
  final TextEditingController _marketTextEditingController;
  final List markets;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        return current is InitDataMarketError || current is InitDataMarketReset;
      },
      builder: (context, state) => TypeAheadFormField(
        noItemsFoundBuilder: (context1) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: RichText(
                  textAlign: TextAlign.center,
                  //TODO: this is a  hot fix please fin a rialiable solution
                  text: AppLocalizations.of(context)
                          .locale
                          .languageCode
                          .contains("ar")
                      ? TextSpan(
                          text: "موزعك ",
                          style: GoogleFonts.cairo(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .fontSize),
                          children: [
                            TextSpan(
                              text: "غير",
                              style: GoogleFonts.cairo(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .fontSize,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: " مسجل\n",
                              style: GoogleFonts.cairo(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .fontSize,
                              ),
                            ),
                            TextSpan(
                              text: "يجب عليك إضافته عبر الضغط هنا",
                              style: GoogleFonts.cairo(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .fontSize,
                              ),
                            ),
                          ],
                        )
                      : TextSpan(
                          text: "Market ",
                          style: GoogleFonts.cairo(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .fontSize),
                          children: [
                            TextSpan(
                              text: "NOT",
                              style: GoogleFonts.cairo(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .fontSize,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: " Found\n",
                              style: GoogleFonts.cairo(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .fontSize,
                              ),
                            ),
                            TextSpan(
                              text: "You Must Add Yours By Pressing Here",
                              style: GoogleFonts.cairo(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .fontSize,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              onPressed: () {
                _marketFieldNode.unfocus();
                if (BlocProvider.of<InitDataCubit>(context).countryCode !=
                    null) {
                  // BlocProvider.of<InitDataCubit>(context)
                  //     .emit(InitDataNewMarketInitial());
                  var countryCode =
                      BlocProvider.of<InitDataCubit>(context).countryCode;
                  // showMaterialModalBottomSheet(
                  //   expand: true,
                  //   context: context,
                  //   builder: (context1) {
                  //     return BlocProvider.value(
                  //       value: AddMarketCubit(
                  //         countryCode: countryCode,
                  //         language:
                  //             AppLocalizations.of(context).locale.languageCode,
                  //       ),
                  //       child: AddMarketBottomSheet(
                  //         countryCode: countryCode,
                  //       ),
                  //     );
                  //   },
                  //   backgroundColor: Colors.transparent,
                  // )
                  // .then((value) {
                  //   print("Add Warranty:$value");
                  //   // _marketTextEditingController.text = value;
                  //   // print(value);
                  // });
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider<AddMarketCubit>.value(
                                value: AddMarketCubit(
                                  countryCode: countryCode,
                                  language: AppLocalizations.of(context)
                                      .locale
                                      .languageCode,
                                ),
                                child: AddMarketPage(
                                  countryCode: countryCode,
                                ),
                              )))
                      .then((value) {
                    print("Add Warranty:$value");
                    Market market = value;
                    _marketTextEditingController.text =
                        AppLocalizations.of(context)
                                .locale
                                .languageCode
                                .contains("ar")
                            ? market.nameAr
                            : market.nameEn;
                    BlocProvider.of<InitDataCubit>(context).market = value;
                    print(value);
                  });
                } else {
                  BlocProvider.of<InitDataCubit>(context)
                      .emit(InitDataCountryError());
                  BlocProvider.of<InitDataCubit>(context).countryIsError = true;
                  //TODO: translate: Please Select Your Country
                  var snackbar = SnackBar(
                    content: Text(AppLocalizations.of(context)
                            .locale
                            .languageCode
                            .contains("ar")
                        ? "رجاءً أختر بلدك"
                        : "Please Select Your Country"),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                }
              },
            ),
          );
        },
        textFieldConfiguration: TextFieldConfiguration(
          focusNode: _marketFieldNode,
          onTap: () {
            _marketTextEditingController.clear();
            BlocProvider.of<InitDataCubit>(context).marketIsError = false;
            BlocProvider.of<InitDataCubit>(context).emit(InitDataMarketReset());
          },
          // keyboardType: TextInputType.number,
          controller: _marketTextEditingController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).translate("marketExample"),
            errorText: ((state is InitDataMarketError) ||
                    (BlocProvider.of<InitDataCubit>(context).marketIsError))
                ? AppLocalizations.of(context).translate("addMarket")
                : null,
            labelText: AppLocalizations.of(context).translate("marketName"),
            // hintText: AppLocalizations.of(context).translate("ex40"),
            labelStyle: TextStyle(
              color: _marketFieldNode.hasFocus
                  ? Theme.of(context).accentColor
                  : Colors.blue,
            ),
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
            //   borderRadius: BorderRadius.all(
            //       Radius.circular(4.0)),
            //   borderSide:
            //       BorderSide(color: Colors.black45),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(
            //       Radius.circular(4.0)),
            //   borderSide: BorderSide(
            //       color:
            //           Theme.of(context).primaryColor),
            // ),
          ),
        ),
        suggestionsCallback: (pattern) {
          List<Market> results = [];
          markets.forEach((market) {
            // if (battreyModel.capacity == searchedCapacity)
            //   results.add(battreyModel);
            // if (market.nameAr.contains(pattern) ||
            //     (market.nameEn.toLowerCase()).contains(pattern.toLowerCase()))
            //   results.add(market);

            if (AppLocalizations.of(context)
                .locale
                .languageCode
                .contains("ar")) {
              if (market.nameAr != null) if (market.nameAr.contains(pattern))
                results.add(market);
            } else {
              if (market.nameEn != null) if ((market.nameEn.toLowerCase())
                  .contains(pattern.toLowerCase())) results.add(market);
            }
          });

          return results;
        },
        itemBuilder: (context, suggestion) {
          // print(suggestion is Battery);
          Market suggestedMarket = suggestion;
          if (_marketTextEditingController.text.isNotEmpty) {
            // print("${_marketTextEditingController.text}");
            return Card(
              child: ListTile(
                title: Text(AppLocalizations.of(context)
                        .locale
                        .languageCode
                        .contains("ar")
                    ? suggestedMarket.nameAr
                    : suggestedMarket.nameEn),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)
                              .locale
                              .languageCode
                              .contains("ar")
                          ? suggestedMarket.addressAr
                          : suggestedMarket.addressEn,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      suggestedMarket.phoneNumber,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
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
          FocusScope.of(context).unfocus();
          Market suggestedMarket = suggestion;
          _marketTextEditingController.text =
              AppLocalizations.of(context).locale.languageCode.contains("ar")
                  ? suggestedMarket.nameAr
                  : suggestedMarket.nameEn;
          BlocProvider.of<InitDataCubit>(context).market = suggestedMarket;
        },
      ),
    );
  }
}

class CarPropertyDropdown extends StatelessWidget {
  const CarPropertyDropdown({
    Key key,
    @required this.carProperties,
  }) : super(key: key);

  final List carProperties;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        return current is InitDataCarPropertyError ||
            current is InitDataCarPropertyReset;
      },
      builder: (context, state) => DropdownBoxWrapper(
          color: state is InitDataCarPropertyError ||
                  BlocProvider.of<InitDataCubit>(context).carPropertyIdIsError
              ? Colors.redAccent[700]
              : Theme.of(context).primaryColor,
          title: AppLocalizations.of(context).translate("carProperty"),
          child: StreamBuilder<int>(
              stream:
                  BlocProvider.of<InitDataCubit>(context).carPropertyIdStream,
              initialData: null,
              builder: (context, snapshot) {
                return DropdownButton<int>(
                  onTap: () {
                    BlocProvider.of<InitDataCubit>(context)
                        .carPropertyIdIsError = false;
                    BlocProvider.of<InitDataCubit>(context)
                        .emit(InitDataCarPropertyReset());
                  },
                  onChanged: (e) {
                    // setState(() {
                    //   _carPropertyValue = e;
                    // });
                    BlocProvider.of<InitDataCubit>(context)
                        .carPropertyIdSelectedValue(e);
                  },
                  isExpanded: true,
                  hint: Text(
                      AppLocalizations.of(context).translate("carProperty")),
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
              })),
    );
  }
}

class CarTypeDropdown extends StatelessWidget {
  const CarTypeDropdown({
    Key key,
    @required this.carTypes,
  }) : super(key: key);

  final List carTypes;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        return current is InitDataCarTypeError ||
            current is InitDataCarTypeReset;
      },
      builder: (context, state) => DropdownBoxWrapper(
        color: state is InitDataCarTypeError ||
                BlocProvider.of<InitDataCubit>(context).carTypeIdIsError
            ? Colors.redAccent[700]
            : Theme.of(context).primaryColor,
        title: AppLocalizations.of(context).translate("carModel"),
        child: StreamBuilder<int>(
            stream: BlocProvider.of<InitDataCubit>(context).carTypeIdStream,
            initialData: null,
            builder: (context, snapshot) {
              return DropdownButton<int>(
                onTap: () {
                  BlocProvider.of<InitDataCubit>(context).carTypeIdIsError =
                      false;
                  BlocProvider.of<InitDataCubit>(context)
                      .emit(InitDataCarTypeReset());
                },
                onChanged: (e) {
                  BlocProvider.of<InitDataCubit>(context)
                      .carTypeIdSelectedValue(e);
                  if (e == 0) {
                    // showMaterialModalBottomSheet(
                    //   expand: true,
                    //   context: context,
                    //   builder: (context1) {
                    //     return BlocProvider.value(
                    //       value: BlocProvider.of<InitDataCubit>(context),
                    //       child: AddCarBottomSheet(),
                    //     );
                    //   },
                    //   backgroundColor: Colors.transparent,
                    // );
                    var countryCode =
                        BlocProvider.of<InitDataCubit>(context).countryCode;
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<AddCarCubit>.value(
                          value: AddCarCubit(
                            language: AppLocalizations.of(context)
                                .locale
                                .languageCode,
                          ),
                          child: AddMarketPage(
                            countryCode: countryCode,
                          ),
                        ),
                      ),
                    )
                        .then((value) {
                      print("Add Warranty:$value");
                      CarType carType = value;
                      // _marketTextEditingController.text =
                      // AppLocalizations.of(context)
                      //     .locale
                      //     .languageCode
                      //     .contains("ar")
                      //     ? market.nameAr
                      //     : market.nameEn;

                      BlocProvider.of<InitDataCubit>(context)
                          .carTypes
                          .add(carType);
                      BlocProvider.of<InitDataCubit>(context)
                          .carTypeIdSelectedValue(e);
                      BlocProvider.of<InitDataCubit>(context)
                          .emit(InitDataCarTypeReset());
                      print(value);
                    });
                  }
                },
                isExpanded: true,
                hint: Text(AppLocalizations.of(context).translate("carModel")),
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
    );
  }
}

class PhoneNumberTextField extends StatelessWidget {
  const PhoneNumberTextField({
    Key key,
    @required TextEditingController phoneNumberTextEditingController,
    @required FocusNode phoneNumberFieldNode,
  })  : _phoneNumberTextEditingController = phoneNumberTextEditingController,
        _phoneNumberFieldNode = phoneNumberFieldNode,
        super(key: key);

  final TextEditingController _phoneNumberTextEditingController;
  final FocusNode _phoneNumberFieldNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        return current is InitDataPhoneNumberError ||
            current is InitDataPhoneNumberReset ||
            current is InitDataPhoneNumberCountryCode;
      },
      builder: (context, state) {
        if (state is InitDataPhoneNumberError)
          return TextFormField(
            onTap: () {
              BlocProvider.of<InitDataCubit>(context).phoneNumberIsError =
                  false;
              BlocProvider.of<InitDataCubit>(context)
                  .emit(InitDataPhoneNumberReset());
            },
            controller: _phoneNumberTextEditingController,
            // keyboardType: TextInputType.phone,
            focusNode: _phoneNumberFieldNode,
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
                      BlocProvider.of<InitDataCubit>(context).countryCode !=
                          null
                  ? Text(
                      BlocProvider.of<InitDataCubit>(context)
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
                      BlocProvider.of<InitDataCubit>(context).countryCode !=
                          null
                  ? Text(
                      BlocProvider.of<InitDataCubit>(context)
                          .countryCode
                          .dialCode,
                      textDirection: TextDirection.ltr)
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              errorText: ((state is InitDataPhoneNumberError) ||
                      (BlocProvider.of<InitDataCubit>(context)
                          .phoneNumberIsError))
                  ? AppLocalizations.of(context)
                      .translate("pleaseEnterPhoneNumber")
                  : null,
              labelText:
                  AppLocalizations.of(context).translate("yourPhoneNumber"),
              labelStyle: TextStyle(
                color: _phoneNumberFieldNode.hasFocus
                    ? Theme.of(context).accentColor
                    : Colors.blue,
              ),
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
              BlocProvider.of<InitDataCubit>(context).phoneNumber = value;
            },
          );
        else if (state is InitDataPhoneNumberReset)
          return TextFormField(
            onTap: () {
              BlocProvider.of<InitDataCubit>(context).phoneNumberIsError =
                  false;
              BlocProvider.of<InitDataCubit>(context)
                  .emit(InitDataPhoneNumberReset());
            },
            controller: _phoneNumberTextEditingController,
            // keyboardType: TextInputType.phone,
            focusNode: _phoneNumberFieldNode,
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
                      BlocProvider.of<InitDataCubit>(context).countryCode !=
                          null
                  ? Text(
                      BlocProvider.of<InitDataCubit>(context)
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
                      BlocProvider.of<InitDataCubit>(context).countryCode !=
                          null
                  ? Text(
                      BlocProvider.of<InitDataCubit>(context)
                          .countryCode
                          .dialCode,
                      textDirection: TextDirection.ltr)
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              errorText: ((state is InitDataPhoneNumberError) ||
                      (BlocProvider.of<InitDataCubit>(context)
                          .phoneNumberIsError))
                  ? AppLocalizations.of(context)
                      .translate("pleaseEnterPhoneNumber")
                  : null,
              labelText:
                  AppLocalizations.of(context).translate("yourPhoneNumber"),
              labelStyle: TextStyle(
                color: _phoneNumberFieldNode.hasFocus
                    ? Theme.of(context).accentColor
                    : Colors.blue,
              ),
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
              BlocProvider.of<InitDataCubit>(context).phoneNumber = value;
            },
          );
        else if (state is InitDataPhoneNumberCountryCode)
          return TextFormField(
            onTap: () {
              BlocProvider.of<InitDataCubit>(context).phoneNumberIsError =
                  false;
              BlocProvider.of<InitDataCubit>(context)
                  .emit(InitDataPhoneNumberReset());
            },
            controller: _phoneNumberTextEditingController,
            // keyboardType: TextInputType.phone,
            focusNode: _phoneNumberFieldNode,
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
                      .contains("en")
                  ? Text(state.countryCode, textDirection: TextDirection.ltr)
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              suffix: AppLocalizations.of(context)
                      .locale
                      .languageCode
                      .contains("ar")
                  ? Text(state.countryCode, textDirection: TextDirection.ltr)
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              errorText: ((state is InitDataPhoneNumberError) ||
                      (BlocProvider.of<InitDataCubit>(context)
                          .phoneNumberIsError))
                  ? AppLocalizations.of(context)
                      .translate("pleaseEnterPhoneNumber")
                  : null,
              labelText:
                  AppLocalizations.of(context).translate("yourPhoneNumber"),
              labelStyle: TextStyle(
                color: _phoneNumberFieldNode.hasFocus
                    ? Theme.of(context).accentColor
                    : Colors.blue,
              ),
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
              BlocProvider.of<InitDataCubit>(context).phoneNumber = value;
            },
          );
        else
          return TextFormField(
            onTap: () {
              BlocProvider.of<InitDataCubit>(context).phoneNumberIsError =
                  false;
              BlocProvider.of<InitDataCubit>(context)
                  .emit(InitDataPhoneNumberReset());
            },
            controller: _phoneNumberTextEditingController,
            // keyboardType: TextInputType.phone,
            textDirection: TextDirection.ltr,
            inputFormatters: [
              new WhitelistingTextInputFormatter(RegExp("[0-9]"))
            ],
            focusNode: _phoneNumberFieldNode,
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
                      BlocProvider.of<InitDataCubit>(context).countryCode !=
                          null
                  ? Text(
                      BlocProvider.of<InitDataCubit>(context)
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
                      BlocProvider.of<InitDataCubit>(context).countryCode !=
                          null
                  ? Text(
                      BlocProvider.of<InitDataCubit>(context)
                          .countryCode
                          .dialCode,
                      textDirection: TextDirection.ltr)
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              errorText: ((state is InitDataPhoneNumberError) ||
                      (BlocProvider.of<InitDataCubit>(context)
                          .phoneNumberIsError))
                  ? AppLocalizations.of(context)
                      .translate("pleaseEnterPhoneNumber")
                  : null,
              labelText:
                  AppLocalizations.of(context).translate("yourPhoneNumber"),
              labelStyle: TextStyle(
                color: _phoneNumberFieldNode.hasFocus
                    ? Theme.of(context).accentColor
                    : Colors.blue,
              ),
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
              BlocProvider.of<InitDataCubit>(context).phoneNumber = value;
            },
          );
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key key,
    @required FocusNode emailFieldNode,
    @required TextEditingController emailTextEditingController,
  })  : _emailFieldNode = emailFieldNode,
        _emailTextEditingController = emailTextEditingController,
        super(key: key);

  final FocusNode _emailFieldNode;
  final TextEditingController _emailTextEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        return current is InitDataEmailError || current is InitDataEmailReset;
      },
      builder: (context, state) => TextFormField(
        focusNode: _emailFieldNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        onTap: () {
          BlocProvider.of<InitDataCubit>(context).eMailIsError = false;
          BlocProvider.of<InitDataCubit>(context).emit(InitDataEmailReset());
        },
        controller: _emailTextEditingController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate("emailExample"),
          errorText: ((state is InitDataEmailError) ||
                  (BlocProvider.of<InitDataCubit>(context).eMailIsError))
              ? AppLocalizations.of(context).translate("pleaseEnterEMail")
              : null,
          labelText: AppLocalizations.of(context).translate("yourEmail"),
          labelStyle: TextStyle(
            color: _emailFieldNode.hasFocus
                ? Theme.of(context).accentColor
                : Colors.blue,
          ),
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
          BlocProvider.of<InitDataCubit>(context).eMail = value;
          BlocProvider.of<InitDataCubit>(context).eMailIsError =
              !EmailValidator.validate(value);
          if (!EmailValidator.validate(value)) {
            BlocProvider.of<InitDataCubit>(context).emit(InitDataEmailError());
          } else {
            BlocProvider.of<InitDataCubit>(context).emit(InitDataEmailReset());
          }
        },
      ),
    );
  }
}

class AddressTextField extends StatelessWidget {
  const AddressTextField({
    Key key,
    @required TextEditingController addressTextEditingController,
    @required FocusNode addressFieldNode,
  })  : _addressTextEditingController = addressTextEditingController,
        _addressFieldNode = addressFieldNode,
        super(key: key);

  final TextEditingController _addressTextEditingController;
  final FocusNode _addressFieldNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        return current is InitDataAddressError ||
            current is InitDataAddressReset;
      },
      builder: (context, state) => TextFormField(
        onTap: () {
          BlocProvider.of<InitDataCubit>(context).addressIsError = false;
          BlocProvider.of<InitDataCubit>(context).emit(InitDataAddressReset());
        },
        controller: _addressTextEditingController,
        focusNode: _addressFieldNode,
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
          hintText: AppLocalizations.of(context).translate("addressExample"),
          errorText: ((state is InitDataAddressError) ||
                  (BlocProvider.of<InitDataCubit>(context).addressIsError))
              ? AppLocalizations.of(context).translate("addAddress")
              : null,
          labelText: AppLocalizations.of(context).translate("yourAddress"),
          labelStyle: TextStyle(
            color: _addressFieldNode.hasFocus
                ? Theme.of(context).accentColor
                : Colors.blue,
          ),
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
          BlocProvider.of<InitDataCubit>(context).address = value;
        },
      ),
    );
  }
}

class CountryPickerButton extends StatelessWidget {
  CountryPickerButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        return current is InitDataCountryError ||
            current is InitDataCountryReset;
      },
      builder: (context, state) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: (state is InitDataCountryError ||
                    BlocProvider.of<InitDataCubit>(context).countryIsError)
                ? LinearGradient(
                    colors: [
                      Colors.redAccent[700],
                      // Theme.of(context).accentColor
                      Colors.black
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
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
                AppLocalizations.of(context).translate("country"),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              CountryCodePicker(
                showDropDownButton: true,
                textStyle: TextStyle(color: Colors.white),
                // showDropDownButton: true,

                showFlag: true,

                // countryFilter: ['IL'],
                onChanged: (countryCode) {
                  BlocProvider.of<InitDataCubit>(context).countryIsError =
                      false;

                  print(countryCode.name);
                  BlocProvider.of<InitDataCubit>(context).countryName =
                      countryCode.name;
                  BlocProvider.of<InitDataCubit>(context).countryCode =
                      countryCode;
                  BlocProvider.of<InitDataCubit>(context).emit(
                      InitDataPhoneNumberCountryCode(countryCode.dialCode));
                  BlocProvider.of<InitDataCubit>(context)
                      .emit(InitDataCountryReset());

                  // phoneNumberTextEditingController.text = countryCode.dialCode;
                },
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection:
                    BlocProvider.of<InitDataCubit>(context).countryCode != null
                        ? BlocProvider.of<InitDataCubit>(context)
                            .countryCode
                            .code
                        : 'CA',
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
    );
  }
}

class FullnameTextField extends StatelessWidget {
  const FullnameTextField({
    Key key,
    @required FocusNode fullNameFieldNode,
    @required TextEditingController fullNameTextEditingController,
  })  : _fullNameFieldNode = fullNameFieldNode,
        _fullNameTextEditingController = fullNameTextEditingController,
        super(key: key);

  final FocusNode _fullNameFieldNode;
  final TextEditingController _fullNameTextEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        return current is InitDataFullNameError ||
            current is InitDataFullNameReset;
      },
      builder: (context, state) => TextFormField(
        onTap: () {
          BlocProvider.of<InitDataCubit>(context).fullNameIsError = false;
          BlocProvider.of<InitDataCubit>(context).emit(InitDataFullNameReset());
        },
        focusNode: _fullNameFieldNode,
        controller: _fullNameTextEditingController,
        inputFormatters: [
          AppLocalizations.of(context).locale.languageCode.contains("ar")
              ? FilteringTextInputFormatter.allow(
                  RegExp(r"[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FF ]"))
              : FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]')),
        ],
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate("fullNameExample"),
          errorText: ((state is InitDataFullNameError) ||
                  (BlocProvider.of<InitDataCubit>(context).addressIsError))
              ? AppLocalizations.of(context).translate("addFullName")
              : null,
          labelText: AppLocalizations.of(context).translate("yourName"),
          labelStyle: TextStyle(
            color: _fullNameFieldNode.hasFocus
                ? Theme.of(context).accentColor
                : Colors.blue,
          ),
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
          BlocProvider.of<InitDataCubit>(context).fullNameIsError = false;
          BlocProvider.of<InitDataCubit>(context).fullName = value;
        },
      ),
    );
  }
}

class SerialNumberTextField extends StatelessWidget {
  const SerialNumberTextField({
    Key key,
    @required TextEditingController serialTextEditingNumberController,
    @required FocusNode serialNumberFieldNode,
  })  : _serialTextEditingNumberController = serialTextEditingNumberController,
        _serialNumberFieldNode = serialNumberFieldNode,
        super(key: key);

  final TextEditingController _serialTextEditingNumberController;
  final FocusNode _serialNumberFieldNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        return current is InitDataSerialNumberError ||
            current is InitDataSerialNumberReset;
      },
      builder: (context, state) => TextFormField(
        controller: _serialTextEditingNumberController,
        onTap: () {
          BlocProvider.of<InitDataCubit>(context).serialNumberIsError = false;
          BlocProvider.of<InitDataCubit>(context)
              .emit(InitDataSerialNumberReset());
        },
        decoration: InputDecoration(
          hintText:
              AppLocalizations.of(context).translate("ex1052E3orG0014Y0004"),
          errorText: ((state is InitDataSerialNumberError) ||
                  (BlocProvider.of<InitDataCubit>(context).serialNumberIsError))
              ? AppLocalizations.of(context)
                  .translate("pleaseEnterSerialNumber")
              : null,
          suffixIcon: IconButton(
            color: _serialNumberFieldNode.hasFocus
                ? Theme.of(context).accentColor
                : Colors.indigo,
            icon: Icon(WarrantyIcons.warrenty_comment),
            onPressed: () {
              // if (BlocProvider.of<InitDataCubit>(context).battery != null) {
              //   var serialNumberImage = BlocProvider.of<InitDataCubit>(context)
              //       .battery
              //       .serialNumberImage;
              //   var info = AppLocalizations.of(context)
              //           .locale
              //           .languageCode
              //           .contains("ar")
              //       ? BlocProvider.of<InitDataCubit>(context).battery.infoAr
              //       : BlocProvider.of<InitDataCubit>(context).battery.infoEn;
              showDialog(
                context: context,
                builder: (context) => whereIsSerialNumberDialog(
                  context,
                ),
              );
              // } else {
              //   var snackbar = SnackBar(
              //       content: Text(
              //     AppLocalizations.of(context)
              //         .translate("SelectBatteryToHelpYouWithInstructions"),
              //   ));
              //   Scaffold.of(context).showSnackBar(snackbar);
              // }
            },
          ),
          labelText: AppLocalizations.of(context).translate("serialNumber"),
          labelStyle: TextStyle(
            color: _serialNumberFieldNode.hasFocus
                ? Theme.of(context).accentColor
                : Colors.indigo,
          ),

          // suffixStyle: TextStyle(
          //   color: _serialNumberFieldNode.hasFocus
          //       ? Theme.of(context).accentColor
          //       : Colors.indigo,
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(color: Colors.indigo),
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
          BlocProvider.of<InitDataCubit>(context).serialNumber = value;
        },
        focusNode: _serialNumberFieldNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}

class BillFlatButton extends StatelessWidget {
  const BillFlatButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
        buildWhen: (previous, current) {
      // print(current is InitDataBillDate);
      return current is InitDataBillDate || current is InitDataBillDateError;
    }, builder: (context, state) {
      return FlatButton(
        textColor: Colors.white,
        color: ((state is InitDataBillDateError) ||
                (BlocProvider.of<InitDataCubit>(context).billDateIsError))
            ? Colors.redAccent[700]
            : Colors.indigo,
        child: Text(BlocProvider.of<InitDataCubit>(context).billDate ??
            AppLocalizations.of(context).translate("boughtDate")),
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().add(Duration(days: -365 * 120)),
            lastDate: DateTime.now(),
            // helpText: "Select Bill Date",
          ).then((value) {
            var dateString = dateFormater(
              value,
            );
            BlocProvider.of<InitDataCubit>(context).billDateIsError = false;
            // BlocProvider.of<InitDataCubit>(context)
            //         .billDate =
            //     "${value.year}-${value.month}-${value.day}";
            // BlocProvider.of<InitDataCubit>(context)
            //     .emit(InitDataBillDate(
            //         "${value.year}-${value.month}-${value.day}"));
            BlocProvider.of<InitDataCubit>(context).billDate = dateString;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataBillDate(dateString));
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
    });
  }
}

class BatteryTextField extends StatelessWidget {
  const BatteryTextField({
    Key key,
    @required FocusNode batteryFieldNode,
    @required TextEditingController batteryTextEditingController,
    @required this.batteries,
  })  : _batteryFieldNode = batteryFieldNode,
        _batteryTextEditingController = batteryTextEditingController,
        super(key: key);

  final FocusNode _batteryFieldNode;
  final TextEditingController _batteryTextEditingController;
  final List batteries;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        // print(current is InitDataBillDate);
        return current is InitDataBatteryChoosenTextFieldError ||
            current is InitDataBatteryChoosenTextFieldReset;
      },
      builder: (context, state) => TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          focusNode: _batteryFieldNode,
          onTap: () {
            BlocProvider.of<InitDataCubit>(context).batteryIsError = false;
            BlocProvider.of<InitDataCubit>(context)
                .emit(InitDataBatteryChoosenTextFieldReset());
            _batteryTextEditingController.clear();
          },
          keyboardType: TextInputType.number,
          controller: _batteryTextEditingController,
          decoration: InputDecoration(
            errorText: ((state is InitDataBatteryChoosenTextFieldError) ||
                    (BlocProvider.of<InitDataCubit>(context).batteryIsError))
                ? AppLocalizations.of(context)
                    .translate("pleaseChooseBatteryModel")
                : null,
            labelText:
                AppLocalizations.of(context).translate("enterBatteryAmperage"),
            labelStyle: TextStyle(
              color: _batteryFieldNode.hasFocus
                  ? Theme.of(context).accentColor
                  : Colors.indigo,
            ),
            hintText: AppLocalizations.of(context).translate("ex40"),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              borderSide: BorderSide(color: Colors.indigo),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              borderSide: BorderSide(
                color: Theme.of(context).accentColor,
              ),
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
            print(e);
            FirebaseCrashlytics.instance.log(e.toString());
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
          if (_batteryTextEditingController.text.isNotEmpty) {
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
                      imageUrl: "$imageBaseUrl${suggestedBattry.image}",
                      // imageUrl: "http://via.placeholder.com/350x150",
                      // placeholder: (context,text)=>CircularProgressIndicator(),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
              AppLocalizations.of(context).translate("PleaseChooseYourBattery"),
              suggestionsBox);
        },
        onSuggestionSelected: (suggestion) {
          // _batteryFieldNode.unfocus();
          FocusScope.of(context).unfocus();
          Battery suggestedBattry = suggestion;
          BlocProvider.of<InitDataCubit>(context)
              .emit(InitDataBatteryChosenForImage(suggestedBattry));
          BlocProvider.of<InitDataCubit>(context).battery = suggestedBattry;
          BlocProvider.of<InitDataCubit>(context).frontBatteryPathIsError =
              false;
          BlocProvider.of<InitDataCubit>(context).frontBatteryPath = null;
          // print(BlocProvider.of<InitDataCubit>(context).batteryId);
          _batteryTextEditingController.text = suggestedBattry.number;
        },
        // validator: (value) {
        //   if (value.isEmpty) {
        //     return 'Please select a city';
        //   }
        // },
        // onSaved: (value) => this._selectedUser = value,
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
