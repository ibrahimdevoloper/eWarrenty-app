import 'package:ewarrenty/Blocs/GetWarranty/get_warranty_cubit.dart';
import 'package:ewarrenty/app_localizations.dart';
import 'package:ewarrenty/pages/ForgottenWarrantyListPage.dart';
import 'package:ewarrenty/pages/WarrantyDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RequestDetailPage extends StatefulWidget {
  @override
  _RequestDetailPageState createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _offsetAnime;
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    )..forward();
    _offsetAnime = Tween<Offset>(
      begin: Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    ));
    // _animController.addListener(() {
    //   print("dx:${_offsetAnime.value.dx} dy:${_offsetAnime.value.dy}");
    // });

    // _animController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
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
      child: BlocProvider<GetWarrantyCubit>(
        create: (context) => GetWarrantyCubit(),
        child: Scaffold(
          // backgroundColor: Colors.transparent,
          appBar: AppBar(
            // shadowColor: Colors.transparent,
            // backgroundColor: Colors.transparent,
            elevation: 0,
            // actions: [
            //   IconButton(
            //       icon: Icon(FontAwesomeIcons.userCircle),
            //       onPressed: () {
            //         Navigator.of(context).push(
            //             MaterialPageRoute(builder: (context) => LoginPage()));
            //       })
            // ],
            title: Text(
                AppLocalizations.of(context).translate("requestWarranty"),
                style: GoogleFonts.cairo()),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/whiteback.png',
                fit: BoxFit.cover,
              ),
              BlocConsumer<GetWarrantyCubit, GetWarrantyState>(
                listenWhen: (previous, current) {
                  return current is GetWarrantyError;
                },
                listener: (context, state) {
                  if (state is GetWarrantyError) {
                    var snackbar = SnackBar(
                      content: Text(AppLocalizations.of(context)
                              .locale
                              .languageCode
                              .contains("ar")
                          ? state.errorArabic
                          : state.errorEnglish),
                      duration: Duration(seconds: 3),
                    );
                    Scaffold.of(context).showSnackBar(snackbar);
                  }
                },
                buildWhen: (previous, current) {
                  return current is GetWarrantyInitial ||
                      current is GetWarrantyLoading ||
                      current is GetWarrantyLoaded;
                },
                builder: (context, state) {
                  return ModalProgressHUD(
                    inAsyncCall: state is GetWarrantyLoading,
                    child: Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          "assets/images/whitelogo.png",
                                          fit: BoxFit.contain,
                                          height: 80,
                                          width: 160,
                                        ),
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
                                      //             color:
                                      //                 Theme.of(context).primaryColor),
                                      //         top: BorderSide(
                                      //             width: 4,
                                      //             color:
                                      //                 Theme.of(context).primaryColor),
                                      //         left: BorderSide(
                                      //             width: 4,
                                      //             color:
                                      //                 Theme.of(context).primaryColor),
                                      //         right: BorderSide(
                                      //             width: 4,
                                      //             color:
                                      //                 Theme.of(context).primaryColor),
                                      //       ),
                                      //       color: Colors.white,
                                      //     ),
                                      //     child: Image.asset(
                                      //       "assets/images/logo.png",
                                      //       fit: BoxFit.scaleDown,
                                      //       height: 86,
                                      //     ))
                                    ]),
                              ],
                            ),
                          ),
                        ),
                        // Divider(
                        //   height: 4,
                        //   color: Theme.of(context).primaryColor,
                        //   thickness: 4,
                        // ),
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
                          child: Center(
                            child: ListView(
                              shrinkWrap: true,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: BlocBuilder<GetWarrantyCubit,
                                          GetWarrantyState>(
                                        buildWhen: (previous, current) {
                                          current is GetWarrantyCodeTextEditorReset ||
                                              current
                                                  is GetWarrantyCodeTextEditorError;
                                        },
                                        builder: (context, state) =>
                                            TextFormField(
                                          controller: _textController,
                                          autocorrect: false,
                                          autofocus: false,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9A-Z]')),
                                          ],
                                          decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)
                                                    .translate("warrantyCode"),
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .translate("ex15FSD"),
                                            errorText: state
                                                    is GetWarrantyCodeTextEditorError
                                                ? AppLocalizations.of(context)
                                                    .translate(
                                                        "makeSureYouAreEntering7CapitalCaseCharactersAndOrNumbers")
                                                : null,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.black45),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ),
                                          onTap: () {
                                            BlocProvider.of<GetWarrantyCubit>(
                                                    context)
                                                .emit(
                                                    GetWarrantyCodeTextEditorReset());
                                          },
                                          onFieldSubmitted: (value) {
                                            goToWarrantyDetailPage(context);
                                          },
                                          onChanged: (value) {
                                            if (value.length > 7 ||
                                                value.length < 7)
                                              BlocProvider.of<GetWarrantyCubit>(
                                                      context)
                                                  .emit(
                                                      GetWarrantyCodeTextEditorError());
                                            else
                                              BlocProvider.of<GetWarrantyCubit>(
                                                      context)
                                                  .emit(
                                                      GetWarrantyCodeTextEditorReset());
                                          },
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      textColor: Colors.red,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgottenWarrantyListPage()));
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate("forgotWarrantyCode"),
                                        style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .fontSize),
                                      ),
                                    )
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: FlatButton(
                                    textColor: Colors.white,
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => WarrantyDetailPage()));
                                      goToWarrantyDetailPage(context);
                                    },
                                    child: Text(AppLocalizations.of(context)
                                        .translate("requestWarranty")),
                                  ),
                                ),

                                // Consumer<LangProvider>(
                                //   builder: (context, provider, _) => MyFlatButton(
                                //       function: () {
                                //         // var provider = Provider.of<LangProvider>(context);
                                //         Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //                 builder: (context) => RequestDetailPage()));
                                //       },
                                //       title: AppLocalizations.of(context)
                                //           .translate("requestWarranty"),
                                //       // child: SvgPicture.asset(
                                //       //   "assets/images/english.svg",
                                //       //   height: 50,
                                //       //   width: 60,
                                //       //   fit: BoxFit.cover,
                                //       // ),
                                //       child: Icon(
                                //         WarrantyIcons.warrenty_correct,
                                //         size: 56,
                                //         color: Theme.of(context).accentColor,
                                //       )
                                //     // child: Icon(IconData(0xe911)),
                                //     // child: Container(
                                //     //   color: Colors.red,
                                //     //   height: 50,
                                //     //   width: 50,
                                //     // ),
                                //   ),
                                // ),
                                // Consumer<LangProvider>(
                                //   builder: (context, provider, _) => MyFlatButton(
                                //       function: () {
                                //         // var provider = Provider.of<LangProvider>(context);
                                //         Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //                 builder: (context) => AddWarrantyPage()));
                                //       },
                                //       title: AppLocalizations.of(context)
                                //           .translate("addWarranty"),
                                //       // child: SvgPicture.asset(
                                //       //   "assets/images/arabic.svg",
                                //       //   height: 50,
                                //       //   width: 60,
                                //       //   fit: BoxFit.cover,
                                //       // ),
                                //       child: Icon(
                                //         WarrantyIcons.warrenty_add,
                                //         size: 56,
                                //         color: Theme.of(context).accentColor,
                                //       )),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                  );
                },
              ),
            ],
          ),
          // body:
          // Center(
          //   child: ListView(
          //
          //     shrinkWrap: true,
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
          //                 Center(child: Text("oisdbnvosdnv"))
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 16,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 16),
          //         child: TextFormField(
          //           decoration: InputDecoration(
          //             labelText: "Warranty Code",
          //             hintText: "ex: 15FSD",
          //             enabledBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.all(Radius.circular(4.0)),
          //               borderSide: BorderSide(color: Colors.black45),
          //             ),
          //             focusedBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.all(Radius.circular(4.0)),
          //               borderSide:
          //                   BorderSide(color: Theme.of(context).primaryColor),
          //             ),
          //           ),
          //           onChanged: (value) {},
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 16),
          //         child: FlatButton(
          //           textColor: Colors.white,
          //           color: Theme.of(context).primaryColor,
          //           onPressed: () {
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => WarrantyDetailPage()));
          //           },
          //           child: Text("Request Warranty"),
          //         ),
          //       ),
          //       // Row(
          //       //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       //   children: [
          //       //     FlatButton(
          //       //       textColor: Theme.of(context).accentColor,
          //       //       onPressed: () {
          //       //         Navigator.push(
          //       //             context,
          //       //             MaterialPageRoute(
          //       //                 builder: (context) => AddWarrantyPage()));
          //       //       },
          //       //       child: Text("Add Warranty"),
          //       //       color: Theme.of(context).primaryColor,
          //       //     ),
          //       //     FlatButton(
          //       //       textColor: Theme.of(context).primaryColor,
          //       //       onPressed: () {},
          //       //       child: Text("Request Warranty"),
          //       //       color: Theme.of(context).accentColor,
          //       //     ),
          //       //   ],
          //       // )
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }

  void goToWarrantyDetailPage(BuildContext context) {
    BlocProvider.of<GetWarrantyCubit>(context).getWarrantyDetail(
        code: _textController.text,
        onDone: () {
          var warranty = BlocProvider.of<GetWarrantyCubit>(context).warranty;
          print(BlocProvider.of<GetWarrantyCubit>(context).warranty);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WarrantyDetailPage(warranty: warranty)));
        });
  }
}
