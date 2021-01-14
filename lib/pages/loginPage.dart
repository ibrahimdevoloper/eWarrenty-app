// import 'package:awael_bmi/Providers/LoginProvider.dart';
// import 'package:awael_bmi/dialogs/restorePasswordDialog.dart';
// import 'package:awael_bmi/functions/getJSONMap.dart';
// import 'package:ewarrenty/functions/sendFirebaseToken.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
//
// import '../app_localizations.dart';
//
// import 'package:awael_bmi/helpers/PrefKeys.dart' as prefKeys;

import 'package:ewarrenty/Providers/LoginProvider.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../app_localizations.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/background.jpg',
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: ModalProgressHUD(
            inAsyncCall: Provider.of<LoginProvider>(context).loginProgress,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  //TODO: don't forget about "forgot password button"
                  Consumer<LoginProvider>(builder: (context, provider, _) {
                    return TextFormField(
                      onChanged: (value) {
                        //TODO: username validetion
                        provider.username = value;
                      },
                      style: TextStyle(color: Colors.white),
                      // autofocus: true,
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate("username"),
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 16,
                  ),
                  Consumer<LoginProvider>(
                    builder: (context, provider, _) {
                      return TextFormField(
                        onChanged: (value) {
                          //TODO: password validetion
                          provider.password = value;
                        },
                        style: TextStyle(color: Colors.white),
                        // autofocus: true,
                        obscureText: provider.isPasswordShown,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              var isPasswordShown = provider.isPasswordShown;
                              provider.isPasswordShown = !isPasswordShown;
                            },
                            icon: Icon(Icons.remove_red_eye_outlined,
                                color: Colors.white),
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate("password"),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Consumer<LoginProvider>(builder: (context, provider, __) {
                    print("${provider.failedLoginCounter}");
                    return AnimatedContainer(
                      curve: Curves.bounceOut,
                      height: (provider.failedLoginCounter >= 3) ? 24 : 0,
                      duration: Duration(milliseconds: 500),
                      child: FlatButton(
                        textColor: Colors.red[500],
                        onPressed: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) =>
                          //       restorePasswordDialog(context, provider),
                          // );
                        },
                        child: (provider.failedLoginCounter >= 3)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.vpn_key),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("forgotPassword"),
                                  ),
                                ],
                              )
                            : Container(
                                height: 0,
                                width: 0,
                              ),
                      ),
                    );

                    // if(provider.failedLoginCounter<3)
                    //   return Container(height: 0,width: 0,);
                    // else{
                    //   flat
                    // }
                  }),
                  SizedBox(
                    height: 24,
                  ),
                  Consumer<LoginProvider>(builder: (context, provider, _) {
                    return RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        AppLocalizations.of(context).translate("login"),
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        // LoginService()
                        Map<String, dynamic> map = Map<String, String>();
                        map["username"] = provider.username;
                        map["password"] = provider.password;
                        // print(map);
                        provider.loginProgress = true;
                        // provider.loginService.postLogin(map).then((value) {
                        //   if (value.statusCode == 200) {
                        //     var response = value.body;
                        //     // print(response is String);
                        //     Map<String, dynamic> myMap = getJSONMap(response);
                        //     int status = myMap["status"];
                        //     if (status == 1) {
                        //       List tempList = myMap["user data"];
                        //       var userData = tempList[0];
                        //       //print("$userData");
                        //       var firstName = userData["first_name"];
                        //       var lastName = userData["last_name"];
                        //       var token = userData["token"];
                        //       var email = userData["email"];
                        //       var role = myMap["role"];
                        //       int userId = int.parse(userData["id"]);
                        //       // print(role);
                        //       provider.token = token;
                        //       provider.userRole = role;
                        //       // print(token);
                        //       provider.fullName = "$firstName $lastName";
                        //       provider.email = email;
                        //       provider.prefs.setString(prefKeys.token, token);
                        //       provider.prefs.setString(
                        //           prefKeys.fullName, "$firstName $lastName");
                        //       provider.prefs
                        //           .setString(prefKeys.userEmail, email);
                        //       provider.prefs.setString(prefKeys.userRole, role);
                        //       provider.prefs.setInt(prefKeys.userId, userId);
                        //
                        //       provider.loginProgress = false;
                        //
                        //       FirebaseMessaging messaging =
                        //           FirebaseMessaging.instance;
                        //       if (messaging != null)
                        //         sendFirebaseToken(messaging, provider, true);
                        //
                        //       var message = myMap["message"];
                        //       SnackBar snackbar =
                        //           SnackBar(content: Text(message));
                        //       Scaffold.of(context).showSnackBar(snackbar);
                        //     } else {
                        //       provider.failedLoginCounter += 1;
                        //       var response = value.body;
                        //       Map<String, dynamic> myMap = getJSONMap(response);
                        //       // print(myMap);
                        //       int status = myMap["status"];
                        //       // print(status);
                        //       var message = myMap["message"];
                        //
                        //       provider.loginProgress = false;
                        //
                        //       SnackBar snackbar =
                        //           SnackBar(content: Text(message));
                        //       Scaffold.of(context).showSnackBar(snackbar);
                        //     }
                        //   }
                        // }).catchError((e) {
                        //   provider.loginProgress = false;
                        //   print(e.toString());
                        //   SnackBar snackbar = SnackBar(
                        //       content: Text(AppLocalizations.of(context)
                        //           .translate("checkInternetConnection")));
                        //   Scaffold.of(context).showSnackBar(snackbar);
                        // });
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
