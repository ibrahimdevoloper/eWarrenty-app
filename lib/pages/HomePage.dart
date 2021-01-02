import 'package:ewarrenty/CustomWidget/MyFlatButton.dart';
import 'package:ewarrenty/Icons/warranty_icons_icons.dart';
import 'package:ewarrenty/Providers/LangProvider.dart';
import 'package:ewarrenty/app_localizations.dart';
import 'package:ewarrenty/customPainters/CurvePainter.dart';
import 'package:ewarrenty/helpers/PrefKeys.dart';
import 'package:ewarrenty/pages/RequestDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  @override
  void initState() {
    // TODO: implement initState

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

    _animeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _curvedAnimation =
        CurvedAnimation(curve: Curves.easeInCubic, parent: _animeController);
    _offsetAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(_curvedAnimation);
    _animeController.forward();
  }

  @override
  void dispose() {
    _animeController.dispose();
    _fadeController.dispose();
    super.dispose();
    // _animController.dispose();

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
        // backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          // backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            // SvgPicture.asset("assets/document/plank.svg",color: Colors.red,),
            Consumer<LangProvider>(
              builder: (_, provider, __) => IconButton(
                  icon: FadeTransition(
                    opacity: _fadeAnime,
                    child: Container(
                      height: 20,
                      width: 25,
                      child: AspectRatio(
                        aspectRatio: 4/3,
                        child: provider.languageCode.contains("en")?Container(
                          color: Colors.indigo[800],
                          child: Center(
                            child: Text("EN",style: TextStyle(
                                color: Colors.white,
                                fontSize: Theme.of(context).textTheme.caption.fontSize
                            ),),
                          ),
                        ):AspectRatio(
                          aspectRatio: 4/3,
                          child: Container(
                            color: Colors.green[800],
                            child: Center(
                              child: Text("ع",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Theme.of(context).textTheme.caption.fontSize
                              ),),
                            ),
                          ),
                        ),
                      ),
                      // child: Image.asset(
                      //   provider.languageCode.contains("en")
                      //       ? 'assets/images/english.png'
                      //       : 'assets/images/arabic.png',
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                  // Icon(Icons.language),
                  onPressed: () {
                    _fadeController.repeat();
                    if (AppLocalizations.of(context)
                        .locale
                        .languageCode
                        .contains("en")) {
                      provider.prefs.setString(PrefKeys.lang, "ar");
                      provider.languageCode = "ar";
                    } else {
                      provider.prefs.setString(PrefKeys.lang, "en");
                      provider.languageCode = "en";
                    }
                    provider.notifyListeners();
                    _fadeController.forward();
                  }),
            ),
            // IconButton(
            //     icon: Icon(FontAwesomeIcons.userCircle),
            //     onPressed: () {
            //       Navigator.of(context).push(
            //           MaterialPageRoute(builder: (context) => LoginPage()));
            //     })
          ],
          title: Text(AppLocalizations.of(context).translate("eWarranty")),
        ),
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
                              height: 86,
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
            // Expanded(
            //   flex: 5,
            //   child: Container(
            //     child: SlideTransition(
            //       position: _offsetAnimation,
            //       child: Card(
            //         margin: EdgeInsets.zero,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.only(
            //                 bottomLeft: Radius.circular(16),
            //                 bottomRight: Radius.circular(16))),
            //         elevation: 0,
            //         color: Theme.of(context).primaryColor,
            //         child: Center(
            //           child: Center(
            //               child: CircleAvatar(
            //                   backgroundColor: Theme.of(context).accentColor,
            //                   radius: 72,
            //                   child: Text("Golden Warranty"))),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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
                                  builder: (context) => RequestDetailPage()));
                        },
                        title: AppLocalizations.of(context)
                            .translate("requestWarranty"),
                        // child: SvgPicture.asset(
                        //   "assets/images/english.svg",
                        //   height: 50,
                        //   width: 60,
                        //   fit: BoxFit.cover,
                        // ),
                        child: Icon(
                          WarrantyIcons.warrenty_correct,
                          size: 56,
                          color: Theme.of(context).accentColor,
                        )
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddWarrantyPage()));
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
          ],
        )),
        // body: Center(
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Material(
        //         color: Colors.transparent,
        //         clipBehavior: Clip.antiAlias,
        //         shape: CircleBorder(),
        //         child: SlideTransition(
        //           position: _offsetAnime,
        //           child: Container(
        //             height: 200,
        //             width: 200,
        //             child: Stack(
        //               fit: StackFit.expand,
        //               children: [
        //                 CustomPaint(
        //                   painter: CurvePainter(),
        //                 ),
        //                 Center(child: Text("OMG"))
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //       SizedBox(
        //         height: 36,
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           FlatButton(
        //             textColor: Colors.white,
        //             color: Theme.of(context).primaryColor,
        //             onPressed: () {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => AddWarrantyPage()));
        //             },
        //             child: Text(
        //                 AppLocalizations.of(context).translate("addWarranty")),
        //           ),
        //           FlatButton(
        //             textColor: Colors.white,
        //             color: Theme.of(context).primaryColor,
        //             onPressed: () {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => RequestDetailPage()));
        //             },
        //             child: Text(AppLocalizations.of(context)
        //                 .translate("requestWarranty")),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
