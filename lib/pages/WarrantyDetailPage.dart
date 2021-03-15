import 'dart:io';

import 'package:ewarrenty/Function/PDFGenerator.dart';
import 'package:ewarrenty/Function/dateFormatter.dart';
import 'package:ewarrenty/Icons/warranty_icons_icons.dart';
import 'package:ewarrenty/Models/warranty.dart';
import 'package:ewarrenty/app_localizations.dart';
import 'package:ewarrenty/pages/PdfViewerPage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class WarrantyDetailPage extends StatelessWidget {
  final Warranty _warranty;

  WarrantyDetailPage({@required Warranty warranty}) : this._warranty = warranty;

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics().setCurrentScreen(screenName: "WarrantyDetailPage");
    final insideBoxStyle = TextStyle(
        color: Color.fromRGBO(0x00, 0x4A, 0x80, 1.00),
        fontSize: Theme.of(context).textTheme.subtitle1.fontSize);
    final bannerStyle = TextStyle(
        color: Colors.white,
        fontSize: Theme.of(context).textTheme.headline5.fontSize);
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/whiteback.png',
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
                AppLocalizations.of(context).translate("warrantyInformation"),
                style: GoogleFonts.cairo()),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: Icon(
                      WarrantyIcons.warrenty_pdf,
                      size: 36,
                    ),
                    onPressed: () async {
                      Directory tempDir = await getTemporaryDirectory();
                      String tempPath = tempDir.path;
                      var path = "$tempPath/SAC64${DateTime.now()}.pdf";
                      await PDFGenerator(
                        path: path,
                        warranty: _warranty,
                        startDate: dateFormater(_warranty.boughtDateAsDateTime),
                        endDate: dateFormater(
                          DateTime(
                              DateTime.now().year,
                              DateTime.now().month +
                                  _warranty.warrantyDurationInt,
                              DateTime.now().day),
                        ),
                        lang: AppLocalizations.of(context).locale.languageCode,
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PdfViewerPage(
                                    path: path,
                                  )));
                    }),
              )
            ],
          ),
          body: ListView(
            shrinkWrap: true,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    // stops: [0.1, 0.85],
                    colors: [
                      Colors.blue[700],
                      // Theme.of(context).primaryColor,
                      // Theme.of(context).accentColor
                      // Colors.deepPurpleAccent[500],
                      Colors.indigo[900]
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/images/whitelogo.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  // color: Theme.of(context).primaryColor.withOpacity(0.3),
                  color: Color.fromRGBO(0x00, 0x4A, 0x80, 0.21),
                  // color: Colors.transparent,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                            "${AppLocalizations.of(context).translate("warrantyCode")}: ${_warranty.warrantyCode}",
                            style: insideBoxStyle),
                        Text(
                            "${AppLocalizations.of(context).translate("batteryModel")}: ${_warranty.battery.number}",
                            style: insideBoxStyle),
                        Text(
                          "${AppLocalizations.of(context).translate("batterySerialNumber")}: ${_warranty.batterySerialNumber}",
                          style: insideBoxStyle,
                        ),
                        Text(
                          "${AppLocalizations.of(context).translate("boughtDate")}: ${dateFormater(_warranty.boughtDateAsDateTime)}",
                          style: insideBoxStyle,
                        ),
                        Text(
                          "${AppLocalizations.of(context).translate("endDate")}: ${dateFormater(DateTime(_warranty.boughtDateAsDateTime.year, _warranty.boughtDateAsDateTime.month + _warranty.warrantyDurationInt, _warranty.boughtDateAsDateTime.day))}",
                          style: insideBoxStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  // color: Theme.of(context).primaryColor.withOpacity(0.3),
                  color: Color.fromRGBO(0x00, 0x4A, 0x80, 0.21),
                  // color: Colors.transparent,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                            "${AppLocalizations.of(context).translate("customerName")}:${_warranty.customerName}",
                            style: insideBoxStyle),
                        Text(
                            "${AppLocalizations.of(context).translate("carModel")}: ${AppLocalizations.of(context).locale.languageCode.contains("ar") ? _warranty.carType.nameAr : _warranty.carType.nameEn}",
                            style: insideBoxStyle),
                        Text(
                          "${AppLocalizations.of(context).translate("carProperty")}: ${AppLocalizations.of(context).locale.languageCode.contains("ar") ? _warranty.carProperty.nameAr : _warranty.carProperty.nameEn}",
                          style: insideBoxStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  // color: Theme.of(context).primaryColor.withOpacity(0.3),
                  color: Color.fromRGBO(0x00, 0x4A, 0x80, 0.21),

                  // color: Colors.transparent,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                            "${AppLocalizations.of(context).translate("marketName")}: ${AppLocalizations.of(context).locale.languageCode.contains("ar") ? _warranty.market.nameAr : _warranty.market.nameEn}",
                            style: insideBoxStyle),
                        Text(
                            "${AppLocalizations.of(context).translate("marketAddress")}: ${AppLocalizations.of(context).locale.languageCode.contains("ar") ? _warranty.market.addressAr : _warranty.market.addressEn}",
                            style: insideBoxStyle),
                        Text(
                          "${AppLocalizations.of(context).translate("marketEMail")}: ${_warranty.market.email}",
                          style: insideBoxStyle,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${AppLocalizations.of(context).translate("marketPhone")}: ",
                              style: insideBoxStyle,
                            ),
                            Text(
                              _warranty.market.phoneNumber,
                              style: insideBoxStyle,
                              textDirection: TextDirection.ltr,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 16,
              // ),
              // ImageBanner(
              //   title: AppLocalizations.of(context)
              //       .translate("yourBatteryFrontImage"),
              //   child: Material(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(16),
              //         side: BorderSide(color: Colors.blue, width: 4)),
              //     clipBehavior: Clip.antiAlias,
              //     // child: Image.asset("assets/images/home/1.png",
              //     //     fit: BoxFit.cover),
              //     child: CachedNetworkImage(
              //       fit: BoxFit.cover,
              //       imageUrl: "$imageBaseUrl${_warranty.batteryFrontImage}",
              //       progressIndicatorBuilder:
              //           (context, url, downloadProgress) => Center(
              //         child: CircularProgressIndicator(
              //             value: downloadProgress.progress),
              //       ),
              //       errorWidget: (context, url, error) => Icon(Icons.error),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              // ImageBanner(
              //   title: AppLocalizations.of(context)
              //       .translate("yourBatteryFixedImage"),
              //   child: Material(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(16),
              //         side: BorderSide(color: Colors.blue, width: 4)),
              //     clipBehavior: Clip.antiAlias,
              //     child: CachedNetworkImage(
              //       fit: BoxFit.cover,
              //       imageUrl: "$imageBaseUrl${_warranty.fixedBatteryImage}",
              //       progressIndicatorBuilder:
              //           (context, url, downloadProgress) => Center(
              //         child: CircularProgressIndicator(
              //             value: downloadProgress.progress),
              //       ),
              //       errorWidget: (context, url, error) => Icon(Icons.error),
              //     ),
              //     // child: Image.asset("assets/images/FixedBatteryImage.png",
              //     //     fit: BoxFit.cover),
              //   ),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              // ImageBanner(
              //   title: AppLocalizations.of(context)
              //       .translate("yourCarsColorAndNumber"),
              //   child: Material(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(16),
              //         side: BorderSide(color: Colors.blue, width: 4)),
              //     clipBehavior: Clip.antiAlias,
              //     child: CachedNetworkImage(
              //       fit: BoxFit.cover,
              //       imageUrl: "$imageBaseUrl${_warranty.carNumberImage}",
              //       progressIndicatorBuilder:
              //           (context, url, downloadProgress) => Center(
              //         child: CircularProgressIndicator(
              //             value: downloadProgress.progress),
              //       ),
              //       errorWidget: (context, url, error) => Icon(Icons.error),
              //     ),
              //     // child: Image.asset("assets/images/carFront.png",
              //     //     fit: BoxFit.cover),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
