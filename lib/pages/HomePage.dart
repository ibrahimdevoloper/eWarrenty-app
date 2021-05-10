import 'package:ewarrenty/CustomWidget/MyFlatButton.dart';
import 'package:ewarrenty/Icons/warranty_icons_icons.dart';
import 'package:ewarrenty/Providers/LangProvider.dart';
import 'package:ewarrenty/app_localizations.dart';
import 'package:ewarrenty/dialogs/PrivacyPolicyDialog.dart';
import 'package:ewarrenty/dialogs/WarrentyTermsDialog.dart';
import 'package:ewarrenty/dialogs/aboutCompanyDialog.dart';
import 'package:ewarrenty/dialogs/termsOfServiceDialog.dart';
import 'package:ewarrenty/helpers/PrefKeys.dart';
import 'package:ewarrenty/pages/RequestDetailPage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'AddWarrantyPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // AnimationController _animController;
  AnimationController _fadeController;

  // Animation<Offset> _offsetAnime;
  Animation<double> _fadeAnime;

  AnimationController _animeController;
  CurvedAnimation _curvedAnimation;
  Animation<Offset> _offsetAnimation;

  AnimationController _flickerController;
  Animation<double> _flickerAnime;
  CurvedAnimation _flickerCurvedAnimation;

  @override
  void initState() {
    // _animController = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 1200),
    // )..forward();
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    // _offsetAnime = Tween<Offset>(
    //   begin: Offset(0, 1.5),
    //   end: Offset.zero,
    // ).animate(CurvedAnimation(
    //   parent: _animController,
    //   curve: Curves.easeInOut,
    // ));
    _fadeAnime = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    _fadeController.forward();
    // _animController.addListener(() {
    //   print("dx:${_offsetAnime.value.dx} dy:${_offsetAnime.value.dy}");
    // });

    // _animController.forward();

    _animeController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _curvedAnimation =
        CurvedAnimation(curve: Curves.easeInCubic, parent: _animeController);
    _offsetAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(_curvedAnimation);
    _animeController.forward();

    _flickerController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _flickerCurvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _flickerController,
    );
    _flickerAnime =
        Tween<double>(begin: 0.0, end: 1.0).animate(_flickerCurvedAnimation);
    _flickerController.repeat(reverse: true);
    FirebaseAnalytics().setCurrentScreen(
        screenName: "HomePage", screenClassOverride: "HomePage");
  }

  @override
  void dispose() {
    _animeController.dispose();
    _fadeController.dispose();
    _flickerController.dispose();
    super.dispose();
    // _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // backgroundColor: Theme.of(context).primaryColor,
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(42),
                  child: Image.asset("assets/images/whitelogo.png"),
                )),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                title:
                    Text(AppLocalizations.of(context).translate("addWarranty")),
                leading: Icon(WarrantyIcons.warrenty_add),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddWarrantyPage()));
                },
              ),
              ListTile(
                title: Text(
                    AppLocalizations.of(context).translate("requestWarranty")),
                leading: Icon(WarrantyIcons.warrenty_correct),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RequestDetailPage()));
                },
              ),
              ListTile(
                title: Text(
                    AppLocalizations.of(context).translate("aboutCompany")),
                leading: Icon(WarrantyIcons.warrenty_web),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => aboutCompanyDialog(context));
                },
              ),
              ListTile(
                title: Text(
                    AppLocalizations.of(context).translate("warrantyTerms")),
                leading: Icon(WarrantyIcons.warrenty_target),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => warrantyTermsDialog(context));
                },
              ),
              ListTile(
                title: Text(
                    AppLocalizations.of(context).translate("privacyPolicy")),
                leading: Icon(WarrantyIcons.warrenty_comment),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => privacyPolicyDialog(context));
                },
              ),
              ListTile(
                title: Text(
                    AppLocalizations.of(context).translate("termsOfService")),
                leading: Icon(WarrantyIcons.warrenty_like),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => termsOfServiceDialog(context));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          shadowColor: Colors.transparent,
          // backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Consumer<LangProvider>(
              builder: (_, provider, __) => IconButton(
                  icon: FadeTransition(
                    opacity: _fadeAnime,
                    child: Container(
                      height: 20,
                      width: 25,
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: provider.languageCode.contains("en")
                            ? Container(
                                color: Colors.indigo[800],
                                child: Center(
                                  child: Text(
                                    "EN",
                                    style: GoogleFonts.alfaSlabOne(
                                        color: Colors.white,
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .fontSize),
                                  ),
                                ),
                              )
                            : AspectRatio(
                                aspectRatio: 4 / 3,
                                child: Container(
                                  color: Colors.indigo[800],
                                  child: Center(
                                    child: Text(
                                      "ض",
                                      style: GoogleFonts.reemKufi(
                                          color: Colors.white,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .fontSize),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  // Icon(Icons.language),
                  onPressed: () {
                    // FirebaseCrashlytics.instance.crash();
                    _fadeController.repeat();
                    if (AppLocalizations.of(context)
                        .locale
                        .languageCode
                        .contains("en")) {
                      provider.prefs.setString(PrefKeys.lang, "ar");
                      provider.languageCode = "ar";
                      FirebaseAnalytics().logEvent(
                        name: 'changedLanguage',
                        parameters: <String, dynamic>{
                          'lang': 'ar',
                        },
                      );
                    } else {
                      provider.prefs.setString(PrefKeys.lang, "en");
                      provider.languageCode = "en";
                      FirebaseAnalytics().logEvent(
                        name: 'changedLanguage',
                        parameters: <String, dynamic>{
                          'lang': 'en',
                        },
                      );
                    }
                    provider.notifyListeners();
                    _fadeController.forward();
                  }),
            ),
          ],
          title: Text(AppLocalizations.of(context).translate("eWarranty"),
              style: GoogleFonts.cairo()),
        ),
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
                            Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/logo.png",
                                  fit: BoxFit.scaleDown,
                                  height: 120,
                                  width: 220,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Consumer<LangProvider>(
                          builder: (context, provider, _) => MyFlatButton(
                              function: () {
                                // var provider = Provider.of<LangProvider>(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RequestDetailPage()));
                              },
                              title: AppLocalizations.of(context)
                                  .translate("requestWarranty"),
                              child: Icon(
                                WarrantyIcons.warrenty_correct,
                                size: 56,
                                color: Theme.of(context).accentColor,
                              )),
                        ),
                        Consumer<LangProvider>(
                          builder: (context, provider, _) => MyFlatButton(
                              function: () {
                                // var provider = Provider.of<LangProvider>(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddWarrantyPage()));
                              },
                              title: AppLocalizations.of(context)
                                  .translate("addWarranty"),
                              // child: SvgPicture.asset(
                              //   "assets/images/arabic.svg",
                              //   height: 50,
                              //   width: 60,
                              //   fit: BoxFit.cover,
                              // ),
                              child: Icon(
                                WarrantyIcons.warrenty_add,
                                size: 56,
                                color: Theme.of(context).accentColor,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: FadeTransition(
                      opacity: _flickerAnime,
                      child: RichText(
                        text: TextSpan(
                            text: AppLocalizations.of(context)
                                .translate("forReviewingTheWarrantyTermsPress"),
                            style: GoogleFonts.cairo(
                              shadows: [
                                Shadow(
                                  blurRadius: 2.0,
                                  color: Theme.of(context).primaryColor,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              fontSize:
                                  Theme.of(context).textTheme.button.fontSize,
                              color: Theme.of(context).primaryColor,
                            ),
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)
                                    .translate("here"),
                                style: GoogleFonts.cairo(
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2.0,
                                      color: Colors.redAccent,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .button
                                      .fontSize,
                                  color: Colors.redAccent,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            warrantyTermsDialog(context));
                                  },
                              ),
                            ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlickerCurve extends Curve {
  FlickerCurve();

  @override
  double transformInternal(double t) {
    var result = 0.0;
    if ((t >= 0.2 && t <= 0.25) || (t >= 0.4 && t <= 0.5) || (t >= 0.7))
      result = 1.0;
    else
      result = 0.0;

    return result;
  }
}
