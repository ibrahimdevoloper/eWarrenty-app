import 'package:ewarrenty/CustomWidget/MyFlatButton.dart';
import 'package:ewarrenty/Providers/LangProvider.dart';
import 'package:ewarrenty/app_localizations.dart';
import 'package:ewarrenty/helpers/PrefKeys.dart';
import 'package:ewarrenty/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

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
        body: Center(
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
                      Image.asset(
                        "assets/images/carBackground1.png",
                        fit: BoxFit.cover,

                      ),
                      Wrap(alignment: WrapAlignment.center, children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              border: Border(
                                bottom: BorderSide(
                                    width: 4,
                                    color: Theme.of(context).primaryColor),
                                top: BorderSide(
                                    width: 4,
                                    color: Theme.of(context).primaryColor),
                                left: BorderSide(
                                    width: 4,
                                    color: Theme.of(context).primaryColor),
                                right: BorderSide(
                                    width: 4,
                                    color: Theme.of(context).primaryColor),
                              ),
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              "assets/images/logo.png",
                              fit: BoxFit.scaleDown,
                              height: 100,
                            ))
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 4,
              color: Theme.of(context).primaryColor,
              thickness: 4,
            ),
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
                            child: AspectRatio(
                              aspectRatio: 4/3,
                              child: Container(
                                color: Colors.indigo[800],
                                child: Center(
                                  child: Text("EN",style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Theme.of(context).textTheme.headline5.fontSize
                                  ),),
                                ),
                              ),
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
                          child: AspectRatio(
                            aspectRatio: 4/3,
                            child: Container(
                              color: Colors.green[800],
                              child: Center(
                                child: Text("ع",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Theme.of(context).textTheme.headline5.fontSize
                                ),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
