import 'package:email_validator/email_validator.dart';
import 'package:ewarrenty/Blocs/ForgottenWarranty/forgotten_warranty_cubit.dart';
import 'package:ewarrenty/Function/dateFormatter.dart';
import 'package:ewarrenty/Models/warranty.dart';
import 'package:ewarrenty/pages/WarrantyDetailPage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_localizations.dart';

class ForgottenWarrantyListPage extends StatefulWidget {
  @override
  _ForgottenWarrantyListPageState createState() =>
      _ForgottenWarrantyListPageState();
}

class _ForgottenWarrantyListPageState extends State<ForgottenWarrantyListPage> {
  // final insideBoxStyle = TextStyle(
  //     color: Color.fromRGBO(0x00, 0x4A, 0x80, 1.00),
  //     fontSize: Theme.of(context).textTheme.subtitle1.fontSize);
  // final bannerStyle = TextStyle(
  //     color: Colors.white,
  //     fontSize: Theme.of(context).textTheme.headline5.fontSize);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  FocusNode _emailFieldNode = FocusNode();
  FocusNode _phoneNumberFieldNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // _emailController = TextEditingController();
    // _phoneNumberController = TextEditingController();

    // _emailFieldNode = FocusNode();
    // _phoneNumberFieldNode = FocusNode();
    FirebaseAnalytics()
        .setCurrentScreen(screenName: "ForgottenWarrantyListPage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ForgottenWarrantyCubit>(
        create: (context) => ForgottenWarrantyCubit(),
        child: BlocConsumer<ForgottenWarrantyCubit, ForgottenWarrantyState>(
            listenWhen: (previous, current) {
          return current is ForgottenWarrantyError;
        }, listener: (context, state) {
          if (state is ForgottenWarrantyError) {
            var snackbar = SnackBar(
                content: Text(AppLocalizations.of(context)
                        .locale
                        .languageCode
                        .contains("ar")
                    ? state.errorArabic
                    : state.errorEnglish));
            Scaffold.of(context).showSnackBar(snackbar);
          }
        }, buildWhen: (previous, current) {
          return current is ForgottenWarrantyInitial ||
              current is ForgottenWarrantyLoaded ||
              current is ForgottenWarrantyLoading ||
              current is ForgottenWarrantyError;
        }, builder: (context, state) {
          if (state is ForgottenWarrantyInitial) {
            return ForgottenWarrantyInitailWidget(
              emailController: _emailController,
              phoneNumberController: _phoneNumberController,
            );
          } else if (state is ForgottenWarrantyLoading) {
            return ForgottenWarrantyLoadingWidget();
          } else if (state is ForgottenWarrantyLoaded) {
            return ForgottenWarrantyLoadedWidget(
              emailController: _emailController,
              phoneNumberController: _phoneNumberController,
              warranties: state.warranties,
            );
          } else {
            return ForgottenWarrantyInitailWidget(
              emailController: _emailController,
              phoneNumberController: _phoneNumberController,
            );
          }

          // return Stack(
          //   fit: StackFit.expand,
          //   children: [
          //     Image.asset(
          //       'assets/images/whiteback.png',
          //       fit: BoxFit.cover,
          //     ),
          //     Scaffold(
          //       backgroundColor: Colors.transparent,
          //       appBar: AppBar(
          //         title: Text(
          //             AppLocalizations.of(context)
          //                 .translate("warrantyInformation"),
          //             style: GoogleFonts.cairo()),
          //       ),
          //       body: ListView.builder(
          //         itemCount: 3,
          //         itemBuilder: (context, i) {
          //           return Card(
          //             elevation: 8,
          //             child: ListTile(
          //               title: Text("kjsdv"),
          //               subtitle: Container(
          //                 height: 125,
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //   ],
          // );
        }),
      ),
    );
  }
}

class ForgottenWarrantyLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/whiteback.png',
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
                AppLocalizations.of(context).translate("forgotWarrantyCode"),
                style: GoogleFonts.cairo()),
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}

class ForgottenWarrantyInitailWidget extends StatelessWidget {
  final TextEditingController _emailController;
  final TextEditingController _phoneNumberController;

  FocusNode _emailFieldNode = FocusNode();
  FocusNode _phoneNumberFieldNode = FocusNode();

  ForgottenWarrantyInitailWidget(
      {Key key, emailController, phoneNumberController})
      : this._phoneNumberController = phoneNumberController,
        this._emailController = emailController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/whiteback.png',
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                  AppLocalizations.of(context).translate("forgotWarrantyCode"),
                  style: GoogleFonts.cairo()),
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppLocalizations.of(context).translate("youCanUse"),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  ForgottenWarrantyByEmailTextField(
                      emailFieldNode: _emailFieldNode,
                      emailController: _emailController),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppLocalizations.of(context).translate("or"),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  ForgottenWarrantyByPhoneNumberTextField(
                      phoneNumberController: _phoneNumberController,
                      phoneNumberFieldNode: _phoneNumberFieldNode),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate("toRestoreYourWarranties"),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class ForgottenWarrantyByPhoneNumberTextField extends StatelessWidget {
  const ForgottenWarrantyByPhoneNumberTextField({
    Key key,
    @required TextEditingController phoneNumberController,
    @required FocusNode phoneNumberFieldNode,
  })  : _phoneNumberController = phoneNumberController,
        _phoneNumberFieldNode = phoneNumberFieldNode,
        super(key: key);

  final TextEditingController _phoneNumberController;
  final FocusNode _phoneNumberFieldNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgottenWarrantyCubit, ForgottenWarrantyState>(
      buildWhen: (previous, current) {
        return current is ForgottenWarrantyPhoneNumberReset ||
            current is ForgottenWarrantyPhoneNumberError;
      },
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                onTap: () {
                  BlocProvider.of<ForgottenWarrantyCubit>(context)
                      .phoneNumberIsError = false;
                  BlocProvider.of<ForgottenWarrantyCubit>(context)
                      .emit(ForgottenWarrantyPhoneNumberReset());
                },
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                focusNode: _phoneNumberFieldNode,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                  if (value.isNotEmpty)
                    BlocProvider.of<ForgottenWarrantyCubit>(context)
                        .getWarrantyByPhoneNumber(value);
                },
                decoration: InputDecoration(
                  errorText: ((state is ForgottenWarrantyPhoneNumberError) ||
                          (BlocProvider.of<ForgottenWarrantyCubit>(context)
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
                  // enabledBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  //   borderSide: BorderSide(color: Colors.blue),
                  // ),
                  // focusedBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  //   borderSide: BorderSide(
                  //     color: Theme.of(context).accentColor,
                  //   ),
                  // ),
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
                  BlocProvider.of<ForgottenWarrantyCubit>(context).phoneNumber =
                      value;
                },
              ),
            ),
            Material(
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                color: Theme.of(context).primaryColor,
                child: IconButton(
                  onPressed: () {
                    if (BlocProvider.of<ForgottenWarrantyCubit>(context)
                                .phoneNumber !=
                            null &&
                        (!BlocProvider.of<ForgottenWarrantyCubit>(context)
                            .phoneNumberIsError)) {
                      BlocProvider.of<ForgottenWarrantyCubit>(context)
                          .getWarrantyByPhoneNumber(
                              BlocProvider.of<ForgottenWarrantyCubit>(context)
                                  .phoneNumber);
                    } else {
                      SnackBar snackbar = SnackBar(
                        content: Text(
                          AppLocalizations.of(context)
                              .translate("checkYourInformation"),
                        ),
                      );
                      Scaffold.of(context).showSnackBar(snackbar);
                    }
                  },
                  icon: Icon(
                    AppLocalizations.of(context)
                            .locale
                            .languageCode
                            .contains("ar")
                        ? Icons.keyboard_arrow_left
                        : Icons.keyboard_arrow_right,
                    color: Colors.white,
                  ),
                  iconSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgottenWarrantyByEmailTextField extends StatelessWidget {
  const ForgottenWarrantyByEmailTextField({
    Key key,
    @required FocusNode emailFieldNode,
    @required TextEditingController emailController,
  })  : _emailFieldNode = emailFieldNode,
        _emailController = emailController,
        super(key: key);

  final FocusNode _emailFieldNode;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgottenWarrantyCubit, ForgottenWarrantyState>(
      buildWhen: (previous, current) {
        return current is ForgottenWarrantyEmailError ||
            current is ForgottenWarrantyEmailReset;
      },
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: _emailFieldNode,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                  if (value.isNotEmpty)
                    BlocProvider.of<ForgottenWarrantyCubit>(context)
                        .getWarrantyByEmail(value);
                },
                onTap: () {
                  BlocProvider.of<ForgottenWarrantyCubit>(context)
                      .emailIsError = false;
                  BlocProvider.of<ForgottenWarrantyCubit>(context)
                      .emit(ForgottenWarrantyEmailReset());
                },
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: ((state is ForgottenWarrantyEmailError) ||
                          (BlocProvider.of<ForgottenWarrantyCubit>(context)
                              .emailIsError))
                      ? AppLocalizations.of(context)
                          .translate("pleaseEnterEMail")
                      : null,
                  labelText:
                      AppLocalizations.of(context).translate("yourEmail"),
                  labelStyle: TextStyle(
                    color: _emailFieldNode.hasFocus
                        ? Theme.of(context).accentColor
                        : Colors.blue,
                  ),
                  // enabledBorder: OutlineInputBorder(
                  //   borderRadius:
                  //       BorderRadius.all(Radius.circular(4.0)),
                  //   borderSide: BorderSide(color: Colors.blue),
                  // ),
                  // focusedBorder: OutlineInputBorder(
                  //   borderRadius:
                  //       BorderRadius.all(Radius.circular(4.0)),
                  //   borderSide: BorderSide(
                  //     color: Theme.of(context).accentColor,
                  //   ),
                  // ),
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
                  BlocProvider.of<ForgottenWarrantyCubit>(context).eMail =
                      value;
                  BlocProvider.of<ForgottenWarrantyCubit>(context)
                      .emailIsError = !EmailValidator.validate(value);
                  if (!EmailValidator.validate(value)) {
                    BlocProvider.of<ForgottenWarrantyCubit>(context)
                        .emit(ForgottenWarrantyEmailError());
                  } else {
                    BlocProvider.of<ForgottenWarrantyCubit>(context)
                        .emit(ForgottenWarrantyEmailReset());
                  }
                },
              ),
            ),
            Material(
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                color: Theme.of(context).primaryColor,
                child: IconButton(
                  onPressed: () {
                    if (BlocProvider.of<ForgottenWarrantyCubit>(context)
                                .eMail !=
                            null &&
                        (!BlocProvider.of<ForgottenWarrantyCubit>(context)
                            .emailIsError)) {
                      BlocProvider.of<ForgottenWarrantyCubit>(context)
                          .getWarrantyByEmail(
                              BlocProvider.of<ForgottenWarrantyCubit>(context)
                                  .eMail);
                    } else {
                      SnackBar snackbar = SnackBar(
                        content: Text(
                          AppLocalizations.of(context)
                              .translate("checkYourInformation"),
                        ),
                      );
                      Scaffold.of(context).showSnackBar(snackbar);
                    }
                  },
                  icon: Icon(
                    AppLocalizations.of(context)
                            .locale
                            .languageCode
                            .contains("ar")
                        ? Icons.keyboard_arrow_left
                        : Icons.keyboard_arrow_right,
                    color: Colors.white,
                  ),
                  iconSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgottenWarrantyLoadedWidget extends StatelessWidget {
  final List<Warranty> warranties;

  FocusNode _emailFieldNode = FocusNode();
  FocusNode _phoneNumberFieldNode = FocusNode();
  final TextEditingController _emailController;
  final TextEditingController _phoneNumberController;

  ForgottenWarrantyLoadedWidget(
      {Key key, this.warranties, emailController, phoneNumberController})
      : this._phoneNumberController = phoneNumberController,
        this._emailController = emailController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final insideBoxStyle = TextStyle(
        color: Color.fromRGBO(0x00, 0x4A, 0x80, 1.00),
        fontSize: Theme.of(context).textTheme.subtitle1.fontSize);
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/whiteback.png',
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
                AppLocalizations.of(context).translate("forgotWarrantyCode"),
                style: GoogleFonts.cairo()),
          ),
          body: Column(
            children: [
              ForgottenWarrantyByEmailTextField(
                  emailFieldNode: _emailFieldNode,
                  emailController: _emailController),
              ForgottenWarrantyByPhoneNumberTextField(
                  phoneNumberController: _phoneNumberController,
                  phoneNumberFieldNode: _phoneNumberFieldNode),
              Expanded(
                child: ListView.builder(
                  itemCount: warranties.length,
                  itemBuilder: (context, i) {
                    var _warranty = warranties[i];
                    return ForgottenWarrantyItemWidget(
                        warranty: _warranty, insideBoxStyle: insideBoxStyle);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ForgottenWarrantyItemWidget extends StatelessWidget {
  const ForgottenWarrantyItemWidget({
    Key key,
    @required Warranty warranty,
    @required this.insideBoxStyle,
  })  : _warranty = warranty,
        super(key: key);

  final Warranty _warranty;
  final TextStyle insideBoxStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        // color: Theme.of(context).primaryColor.withOpacity(0.3),
        color: Color.fromRGBO(0x00, 0x4A, 0x80, 0.21),
        // color: Colors.transparent,
        elevation: 0,
        child: Material(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WarrantyDetailPage(
                    warranty: _warranty,
                  ),
                ),
              );
            },
            splashColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                      "${AppLocalizations.of(context).translate("warrantyCode")}: ${_warranty.warrantyCode}",
                      style: insideBoxStyle),
                  Text(
                      "${AppLocalizations.of(context).translate("batteryModel")}: ${_warranty.battery.number}",
                      style: insideBoxStyle),
                  // Text(
                  //   "${AppLocalizations.of(context).translate("batterySerialNumber")}: ${_warranty.batterySerialNumber}",
                  //   style: insideBoxStyle,
                  // ),
                  Text(
                    "${AppLocalizations.of(context).translate("boughtDate")}: ${dateFormater(_warranty.boughtDateAsDateTime)}",
                    style: insideBoxStyle,
                  ),
                  // Text(
                  //   "${AppLocalizations.of(context).translate("endDate")}: ${dateFormater(DateTime(_warranty.boughtDateAsDateTime.year, _warranty.boughtDateAsDateTime.month + _warranty.warrantyDurationInt, _warranty.boughtDateAsDateTime.day))}",
                  //   style: insideBoxStyle,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
