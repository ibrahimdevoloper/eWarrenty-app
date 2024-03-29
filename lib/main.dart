import 'dart:io';

import 'package:ewarrenty/Providers/LangProvider.dart';
import 'package:ewarrenty/helpers/PrefKeys.dart';
import 'package:ewarrenty/pages/ChooseLanguagePage.dart';
import 'package:ewarrenty/pages/HomePage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import 'app_localizations.dart';

void main() async {
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // // Set `enableInDevMode` to true to see reports while in debug mode
  // // This is only to be used for confirming that reports are being
  // // submitted as expected. It is not intended to be used for everyday
  // // development.
  // Crashlytics.instance.enableInDevMode = true;
  // Pass all uncaught errors from the framework to Crashlytics.
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(providers: [
    // ChangeNotifierProvider(create: (context) => LoginProvider()),
    ChangeNotifierProvider(create: (context) => LangProvider()),

    // ChangeNotifierProvider(create: (context) => ShoppingCartProvider()),
  ], child: MyApp()));
}

// splash screen image : splash-srceen.png

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
          [SharedPreferences.getInstance(), Firebase.initializeApp()]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          SharedPreferences _pref = snapshot.data[0];
          // FirebaseApp _firebaseApp = snapshot.data[1];
          FlutterError.onError =
              FirebaseCrashlytics.instance.recordFlutterError;
          FirebaseMessaging messaging = FirebaseMessaging.instance;
          if(Platform.isIOS){
            messaging.requestPermission(alert: true,sound: true,provisional: true,announcement: false,badge: false,carPlay: false,criticalAlert: false,).then((settings){
              if (settings.authorizationStatus == AuthorizationStatus.authorized) {
                print('User granted permission');
                FirebaseAnalytics().logEvent(name: "iOS User granted permission",);
              } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
                print('User granted provisional permission');
                FirebaseAnalytics().logEvent(name: "User granted provisional permission",);
              } else {
                print('User declined or has not accepted permission');
                FirebaseAnalytics().logEvent(name: "User declined or has not accepted permission",);
              }
            });
          }
          final ThemeData theme = ThemeData();
          return Consumer<LangProvider>(builder: (context, provider, _) {
            provider.prefs = _pref;
            if (provider.prefs.containsKey(PrefKeys.lang)) {
              if (provider.languageCode.isEmpty) {
                provider.languageCode = provider.prefs.getString(PrefKeys.lang);
                // provider.notifyListeners();
              }
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: provider.languageCode.isEmpty
                  ? null
                  : Locale(provider.languageCode),
              supportedLocales: [
                Locale('en'),
                Locale('ar'),
              ],
              navigatorObservers: [
                FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
              ],
              // These delegates make sure that the localization data for the proper language is loaded
              localizationsDelegates: [
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
              ],
              // Returns a locale which will be used by the app
              localeResolutionCallback: (locale, supportedLocales) {
                //TODO: here save the lang
                // print("Main ${locale.languageCode}");
                // Check if THERE IS A SAVED LOCALE
                if (provider.prefs.containsKey(PrefKeys.lang)) {
                  if (provider.languageCode.isEmpty) {
                    provider.languageCode =
                        provider.prefs.getString(PrefKeys.lang);
                    return Locale(provider.languageCode);
                  }
                }
                // Check if the current device locale is supported
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              title: 'Marvel tech\'s E-Warranty',
              theme: theme.copyWith(
                textTheme: GoogleFonts.cairoTextTheme(
                  Theme.of(context).textTheme,
                ),
                colorScheme: theme.colorScheme.copyWith(
                  primary: Color.fromARGB(0xFF, 0x1F, 0x8D, 0xC5),
                  secondary: Color.fromARGB(0xFF, 0xFD, 0xB9, 0x13),
                ),
                primaryColor:Color.fromARGB(0xFF, 0x1F, 0x8D, 0xC5) ,
                // colorScheme.secondary: Color.fromARGB(0xFF, 0xFD, 0xB9, 0x13),
                // primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: UpgradeAlert(
                child: provider.languageCode.isEmpty
                    ? ChooseLanguagePage()
                    : HomePage(),
              ),
            );
          });
        } else {
          final ThemeData theme = ThemeData();
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              // locale: provider.languageCode.isEmpty
              //     ? null
              //     : Locale(provider.languageCode),
              supportedLocales: [
                Locale('en'),
                Locale('ar'),
              ],
              // These delegates make sure that the localization data for the proper language is loaded
              localizationsDelegates: [
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
              ],
              // Returns a locale which will be used by the app
              localeResolutionCallback: (locale, supportedLocales) {
                //TODO: here save the lang
                // print("Splash Screen ${locale.languageCode}");
                // Check if the current device locale is supported
                // if (provider.prefs != null) if (provider.prefs
                //     .containsKey(PrefKeys.lang))
                //   return Locale(provider.prefs.getString(PrefKeys.lang));
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              title: 'Marvel tech\'s E-Warranty',
              theme: theme.copyWith(
                textTheme: GoogleFonts.cairoTextTheme(
                  Theme.of(context).textTheme,
                ),
                colorScheme: theme.colorScheme.copyWith(
                  primary: Color.fromARGB(0xFF, 0x1F, 0x8D, 0xC5),
                  secondary: Color.fromARGB(0xFF, 0xFD, 0xB9, 0x13),
                ),
                // colorScheme.secondary: Color.fromARGB(0xFF, 0xFD, 0xB9, 0x13),
                // primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: MySplashScreen());
        }
      },
    );

    // return Consumer<LangProvider>(builder: (context, provider, child) {
    //
    // });
  }
}

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // stops: [0,0.35],
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/splash-srceen.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
