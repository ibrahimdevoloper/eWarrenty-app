import 'package:ewarrenty/Blocs/InitData/init_data_cubit.dart';
import 'package:ewarrenty/Wrappers/ResponsiveSafeArea.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_localizations.dart';

class AddMarketBottomSheet extends StatelessWidget {
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context, size) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: NameTextField(
                      nameTextEditingController: nameTextEditingController),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AddressTextField(
                      addressTextEditingController:
                          addressTextEditingController),
                ),
                RaisedButton(
                    child:
                        Text(AppLocalizations.of(context).translate("submit")),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      //TODO: Check if field are null
                      if (addressTextEditingController.text.isNotEmpty &&
                          nameTextEditingController.text.isNotEmpty) {
                        BlocProvider.of<InitDataCubit>(context)
                                .notesMarketAddress =
                            addressTextEditingController.text;
                        BlocProvider.of<InitDataCubit>(context)
                            .notesMarketName = nameTextEditingController.text;
                        Navigator.of(context)
                            .pop(nameTextEditingController.text);
                      } else if (addressTextEditingController.text.isEmpty &&
                          nameTextEditingController.text.isEmpty) {
                        BlocProvider.of<InitDataCubit>(context)
                            .emit(InitDataNewMarketNameError());
                        BlocProvider.of<InitDataCubit>(context)
                            .emit(InitDataNewMarketAddressError());
                      } else if (addressTextEditingController.text.isEmpty &&
                          nameTextEditingController.text.isNotEmpty) {
                        BlocProvider.of<InitDataCubit>(context)
                            .emit(InitDataNewMarketAddressError());
                      } else if (addressTextEditingController.text.isNotEmpty &&
                          nameTextEditingController.text.isEmpty) {
                        BlocProvider.of<InitDataCubit>(context)
                            .emit(InitDataNewMarketNameError());
                      }
                    }),
                Expanded(
                    child: Center(child: Image.asset("assets/images/logo.png")))
              ],
            ),
          ),
        );
      },
    );
  }
}

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
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        return current is InitDataNewMarketNameReset ||
            current is InitDataNewMarketNameError;
      },
      builder: (context, state) => TextFormField(
        onTap: () {
          // BlocProvider.of<InitDataCubit>(context).addressIsError = false;
          BlocProvider.of<InitDataCubit>(context)
              .emit(InitDataNewMarketNameReset());
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
          errorText: ((state is InitDataNewMarketNameError))
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
          BlocProvider.of<InitDataCubit>(context).address = value;
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
    return BlocBuilder<InitDataCubit, InitDataState>(
      buildWhen: (previous, current) {
        return current is InitDataNewMarketAddressReset ||
            current is InitDataNewMarketAddressError;
      },
      builder: (context, state) => TextFormField(
        onTap: () {
          // BlocProvider.of<InitDataCubit>(context).addressIsError = false;
          BlocProvider.of<InitDataCubit>(context)
              .emit(InitDataNewMarketAddressReset());
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
          errorText: (state is InitDataNewMarketAddressError)
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
          BlocProvider.of<InitDataCubit>(context).address = value;
        },
      ),
    );
  }
}
