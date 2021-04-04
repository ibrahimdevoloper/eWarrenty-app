import 'package:ewarrenty/Blocs/AddCar/add_car_cubit.dart';
import 'package:ewarrenty/Wrappers/ResponsiveSafeArea.dart';
import 'package:ewarrenty/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCarPage extends StatefulWidget {
  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  var nameTextEditingController = TextEditingController();
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
                RaisedButton(
                    child:
                        Text(AppLocalizations.of(context).translate("submit")),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      //TODO: Check if field are null
                      // if (nameTextEditingController.text.isNotEmpty) {
                      //   BlocProvider.of<InitDataCubit>(context).notesCarName =
                      //       nameTextEditingController.text;
                      //   Navigator.of(context)
                      //       .pop(nameTextEditingController.text);
                      // } else {
                      //   BlocProvider.of<InitDataCubit>(context)
                      //       .emit(AddCarNameError());
                      // }
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
    return BlocBuilder<AddCarCubit, AddCarState>(
      buildWhen: (previous, current) {
        return current is AddCarNameReset || current is AddCarNameError;
      },
      builder: (context, state) => TextFormField(
        onTap: () {
          // BlocProvider.of<InitDataCubit>(context).addressIsError = false;
          BlocProvider.of<AddCarCubit>(context).emit(AddCarNameReset());
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
          errorText: ((state is AddCarNameError))
              ? AppLocalizations.of(context).translate("addYourMarketNameError")
              : null,
          labelText: AppLocalizations.of(context).translate("addYourCarName"),
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
          BlocProvider.of<AddCarCubit>(context).name = value;
        },
      ),
    );
  }
}
