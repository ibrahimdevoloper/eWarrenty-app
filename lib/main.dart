import 'package:ewarrenty/Providers/LangProvider.dart';
import 'package:ewarrenty/helpers/PrefKeys.dart';
import 'package:ewarrenty/pages/ChooseLanguagePage.dart';
import 'package:ewarrenty/pages/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Providers/LoginProvider.dart';
import 'app_localizations.dart';

void main() async {
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LoginProvider()),
    ChangeNotifierProvider(create: (context) => LangProvider()),
    // ChangeNotifierProvider(create: (context) => ShoppingCartProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Consumer<LangProvider>(builder: (context, provider, _) {
            provider.prefs = snapshot.data;
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
                // These delegates make sure that the localization data for the proper language is loaded
                localizationsDelegates: [
                  // A class which loads the translations from JSON files
                  AppLocalizations.delegate,
                  // Built-in localization of basic text for Material widgets
                  GlobalMaterialLocalizations.delegate,
                  // Built-in localization for text direction LTR/RTL
                  GlobalWidgetsLocalizations.delegate,
                ],
                // Returns a locale which will be used by the app
                localeResolutionCallback: (locale, supportedLocales) {
                  //TODO: here save the lang
                  print("Main ${locale.languageCode}");
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
                title: 'Flutter Demo',
                theme: ThemeData(
                  textTheme: GoogleFonts.cairoTextTheme(
                    Theme.of(context).textTheme,
                  ),
                  primaryColor: Color.fromARGB(0xFF, 0x1F, 0x8D, 0xC5),
                  accentColor: Color.fromARGB(0xFF, 0xFD, 0xB9, 0x13),
                  // primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: provider.languageCode.isEmpty
                    ? ChooseLanguagePage()
                    : HomePage());
          });
        } else {
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
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
              ],
              // Returns a locale which will be used by the app
              localeResolutionCallback: (locale, supportedLocales) {
                //TODO: here save the lang
                print("Splash Screen ${locale.languageCode}");
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
              title: 'Flutter Demo',
              theme: ThemeData(
                textTheme: GoogleFonts.cairoTextTheme(
                  Theme.of(context).textTheme,
                ),
                primaryColor: Color.fromARGB(0xFF, 0x1F, 0x8D, 0xC5),
                accentColor: Color.fromARGB(0xFF, 0xFD, 0xB9, 0x13),
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
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor
          ],
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/background.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
    // return Consumer<LangProvider>(
    //   builder: (context, provider, _) =>
    //       SplashScreen(
    //
    //         // seconds: 8,
    //         // navigateAfterSeconds: provider.prefs.containsKey(PrefKeys.lang)
    //         //     ? HomePage()
    //         //     : ChooseLanguagePage(),
    //         // title: new Text('Welcome In SplashScreen',
    //         //   style: new TextStyle(
    //         //       fontWeight: FontWeight.bold,
    //         //       fontSize: 20.0
    //         //   ),),
    //           gradientBackground: LinearGradient(
    //               begin: Alignment.topLeft,
    //               end: Alignment.bottomRight,
    //               colors: [
    //                 Theme
    //                     .of(context)
    //                     .primaryColor,
    //                 Theme
    //                     .of(context)
    //                     .accentColor
    //               ]),
    //           image: Image.asset(
    //             'assets/images/background.jpg',
    //             fit: BoxFit.cover,
    //           ),
    //           // backgroundColor: Colors.white,
    //           // styleTextUnderTheLoader: new TextStyle(),
    //           photoSize: 100.0,
    //           // onClick: ()=>print("Flutter Egypt"),
    //           useLoader: false,
    //           loaderColor: Colors.red),
    // );
  }
}

// class MyHomePage extends StatefulWidget {
//   // MyHomePage({Key key, this.title}) : super(key: key);
//   // final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           // stops: [0,0.35],
//           colors: [
//             Theme.of(context).primaryColor,
//             Theme.of(context).accentColor
//           ],
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           shadowColor: Colors.transparent,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           actions: [
//             IconButton(
//                 icon: Icon(FontAwesomeIcons.userCircle),
//                 onPressed: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => LoginPage()));
//                 })
//           ],
//           title: Text("EWarranty"),
//         ),
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//           child: Swiper(
//             itemCount: 4,
//             itemWidth:
//                 MediaQuery.of(context).orientation == Orientation.portrait
//                     ? 300.0
//                     : 600,
//             layout: SwiperLayout.STACK,
//             pagination: new SwiperCustomPagination(
//                 builder: (BuildContext context, SwiperPluginConfig config) {
//               // config.pageController
//               return Align(
//                 alignment: FractionalOffset.bottomCenter,
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: AnimatedSmoothIndicator(
//                     duration: Duration(milliseconds: 500),
//                     activeIndex: config.activeIndex,
//                     count: config.itemCount,
//                     effect: ExpandingDotsEffect(
//                         dotHeight: 12,
//                         dotWidth: 12,
//                         activeDotColor: Theme.of(context).primaryColor,
//                         dotColor: Theme.of(context).accentColor),
//                   ),
//                 ),
//               );
//
//               //   SmoothPageIndicator(
//               //
//               //   effect: WormEffect(),
//               //     controller: config.pageController, count: config.itemCount
//               // );
//             }),
//             // pagination: SwiperPagination(
//             //   builder: DotSwiperPaginationBuilder(
//             //       activeColor: Theme.of(context).primaryColor,
//             //       color: Theme.of(context).accentColor),
//             // ),
//             itemBuilder: (context, index) {
//               return MediaQuery.of(context).orientation == Orientation.portrait
//                   ? VerticalWarranty(
//                       "assets/images/home/${(index % 4) + 1}.png", () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => WarrantyDetailPage()));
//                     })
//                   : HorizontalWarranty(
//                       "assets/images/home/${(index % 4) + 1}.png", () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => WarrantyDetailPage()));
//                     });
//             },
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.white,
//           onPressed: () {
//             Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => AddWarrantyPage()));
//           },
//           tooltip: 'Add Warranty',
//           child: Icon(
//             Icons.add,
//             color: Colors.blueAccent,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class VerticalWarranty extends StatelessWidget {
//   final String _image;
//   final Function _onPressed;
//
//   VerticalWarranty(this._image, this._onPressed);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             AspectRatio(
//               aspectRatio: 16 / 12,
//               child: Image.asset(
//                 _image,
//                 fit: BoxFit.cover,
//               ),
//               // child: Container(
//               //   color: Colors.blue,
//               //   child: Center(child: Text("imge")),
//               // ),
//             ),
//             // SizedBox(
//             //   height: 8,
//             // ),
//             Text("Battary Model: MPU 15"),
//             // SizedBox(
//             //   height: 8,
//             // ),
//             Text("Serial Number: SDKBFS5482"),
//             // SizedBox(
//             //   height: 8,
//             // ),
//             Text("Start Date: 2020/12/16"),
//             // SizedBox(
//             //   height: 8,
//             // ),
//             Text("End Date: 2020/12/26"),
//             // SizedBox(
//             //   height: 8,
//             // ),
//             Text("Warranty State: Ended"),
//             // SizedBox(
//             //   height: 8,
//             // ),
//             FlatButton(
//                 color: Colors.blue,
//                 textColor: Colors.white,
//                 onPressed: _onPressed,
//                 child: Text("details")),
//             SizedBox(
//               height: 8,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class HorizontalWarranty extends StatelessWidget {
//   final String _image;
//   final Function _onPressed;
//
//   HorizontalWarranty(this._image, this._onPressed);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AspectRatio(
//               aspectRatio: 4 / 3,
//               child: Image.asset(
//                 _image,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Battary Model: MPU 15"),
//                 // SizedBox(
//                 //   height: 8,
//                 // ),
//                 Text("Serial Number: SDKBFS5482"),
//                 // SizedBox(
//                 //   height: 8,
//                 // ),
//                 Text("Start Date: 2020/12/16"),
//                 // SizedBox(
//                 //   height: 8,
//                 // ),
//                 Text("End Date: 2020/12/26"),
//                 // SizedBox(
//                 //   height: 8,
//                 // ),
//                 Text("Warranty State: Ended"),
//                 // SizedBox(
//                 //   height: 8,
//                 // ),
//                 FlatButton(
//                     color: Colors.blue,
//                     textColor: Colors.white,
//                     onPressed: _onPressed,
//                     child: Text("details")),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
