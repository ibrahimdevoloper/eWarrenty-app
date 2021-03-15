import 'package:ewarrenty/CustomWidget/MyFlatButton.dart';
import 'package:ewarrenty/Providers/LangProvider.dart';
import 'package:ewarrenty/dialogs/PrivacyPolicyDialog.dart';
import 'package:ewarrenty/dialogs/termsOfServiceDialog.dart';
import 'package:ewarrenty/helpers/PrefKeys.dart';
import 'package:ewarrenty/pages/HomePage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChooseLanguagePage extends StatefulWidget {
  @override
  _ChooseLanguagePageState createState() => _ChooseLanguagePageState();
}

class _ChooseLanguagePageState extends State<ChooseLanguagePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animeController;
  CurvedAnimation _curvedAnimation;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    _animeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _curvedAnimation =
        CurvedAnimation(curve: Curves.easeInCubic, parent: _animeController);
    _offsetAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(_curvedAnimation);
    super.initState();
    _animeController.forward();
    FirebaseAnalytics().setCurrentScreen(screenName: "ChooseLanguagePage");
  }

  @override
  void dispose() {
    _animeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //     // stops: [0,0.35],
      //     colors: [
      //       Theme.of(context).primaryColor,
      //       Theme.of(context).accentColor
      //     ],
      //   ),
      // ),
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   shadowColor: Colors.transparent,
        //   // backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   // actions: [
        //   //   Consumer<LangProvider>(
        //   //     builder:(_,provider,__)=> IconButton(
        //   //         icon: Icon(Icons.language),
        //   //         onPressed: () {
        //   //           AppLocalizations.of(context)
        //   //               .locale
        //   //               .languageCode
        //   //               .contains("en");
        //   //           provider.languageCode = "ar";
        //   //         }),
        //   //   ),
        //   //   IconButton(
        //   //       icon: Icon(FontAwesomeIcons.userCircle),
        //   //       onPressed: () {
        //   //         Navigator.of(context).push(
        //   //             MaterialPageRoute(builder: (context) => LoginPage()));
        //   //       })
        //   // ],
        //   title: Text("Choose Your Language"),
        // ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/whiteback.png',
              fit: BoxFit.cover,
            ),
            Center(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    child: SlideTransition(
                      position: _offsetAnimation,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        fit: StackFit.expand,
                        children: [
                          Material(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(24),
                                    bottomRight: Radius.circular(24))),
                            child: Image.asset(
                              "assets/images/carBackground1.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Wrap(alignment: WrapAlignment.center, children: [
                            Image.asset(
                              "assets/images/logo.png",
                              fit: BoxFit.scaleDown,
                              height: 100,
                              width: 200,
                            )
                            // Container(
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.only(
                            //         bottomLeft: Radius.circular(16),
                            //         bottomRight: Radius.circular(16),
                            //       ),
                            //       border: Border(
                            //         bottom: BorderSide(
                            //             width: 4,
                            //             color: Theme.of(context).primaryColor),
                            //         top: BorderSide(
                            //             width: 4,
                            //             color: Theme.of(context).primaryColor),
                            //         left: BorderSide(
                            //             width: 4,
                            //             color: Theme.of(context).primaryColor),
                            //         right: BorderSide(
                            //             width: 4,
                            //             color: Theme.of(context).primaryColor),
                            //       ),
                            //       color: Colors.white,
                            //     ),
                            //     child: Image.asset(
                            //       "assets/images/logo.png",
                            //       fit: BoxFit.scaleDown,
                            //       height: 100,
                            //       width: 200,
                            //     ))
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
                // Divider(
                //   height: 4,
                //   color: Theme.of(context).primaryColor,
                //   thickness: 4,
                // ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Text(AppLocalizations.of(context).translate(key)),
                      Text(
                        "Choose Your Language",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize:
                                Theme.of(context).textTheme.headline6.fontSize),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Consumer<LangProvider>(
                            builder: (context, provider, _) => MyFlatButton(
                              function: () {
                                // var provider = Provider.of<LangProvider>(context);
                                provider.languageCode = "en";
                                provider.prefs.setString(PrefKeys.lang, "en");
                                provider.notifyListeners();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              },
                              title: "English",
                              // child: SvgPicture.asset(
                              //   "assets/images/english.svg",
                              //   height: 50,
                              //   width: 60,
                              //   fit: BoxFit.cover,
                              // ),
                              child: Center(
                                child: Text("EN",
                                    style: GoogleFonts.alfaSlabOne(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            .fontSize,
                                        color: Colors.indigoAccent)),
                              ),
                              // child: Icon(IconData(0xe911)),
                              // child: Container(
                              //   color: Colors.red,
                              //   height: 50,
                              //   width: 50,
                              // ),
                            ),
                          ),
                          Consumer<LangProvider>(
                            builder: (context, provider, _) => MyFlatButton(
                              function: () {
                                // var provider = Provider.of<LangProvider>(context);
                                provider.languageCode = "ar";
                                provider.prefs.setString(PrefKeys.lang, "ar");
                                provider.notifyListeners();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              },
                              title: "العربية",
                              // child: SvgPicture.asset(
                              //   "assets/images/arabic.svg",
                              //   height: 50,
                              //   width: 60,
                              //   fit: BoxFit.cover,
                              // ),
                              child: Center(
                                child: Text(
                                  "ض",
                                  style: GoogleFonts.reemKufi(
                                      color: Colors.green[800],
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .fontSize),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "By Choosing a Language You Agreeing to Our\n",
                      style: GoogleFonts.cairo(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "Terms of Service",
                          style: GoogleFonts.cairo(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      termsOfServiceDialog(context));
                            },
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: GoogleFonts.cairo(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      privacyPolicyDialog(context));
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
