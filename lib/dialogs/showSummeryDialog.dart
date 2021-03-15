import "package:ewarrenty/Function/checkIfCurrentDateIsBeforeDueDate.dart";
import "package:ewarrenty/Function/dateFormatter.dart";
import "package:ewarrenty/Models/warranty.dart";
import 'package:ewarrenty/pages/WarrantyDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../app_localizations.dart';

AlertDialog showSummeryDialog(BuildContext context, Warranty warrenty) {
  FirebaseAnalytics().setCurrentScreen(screenName: "showSummeryDialog");
  var bougthDate = DateTime.parse(warrenty.boughtDate);
  var endDate = DateTime(DateTime.now().year,
      DateTime.now().month + warrenty.warrantyDurationInt, DateTime.now().day);
  return AlertDialog(
    title: Text(AppLocalizations.of(context)
        .translate("congratulationsOnGettingYourWarrenty")),

    // content: SingleChildScrollView(child: Text(AppLocalizations.of(context).translate("aboutCompanyContent"))),
    content: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          checkIfCurrentDateIsBeforeDueDate(endDate)
              ? Text(AppLocalizations.of(context).translate("warrantyExpired"),
                  style: GoogleFonts.cairo(color: Colors.red))
              : Container(
                  height: 0,
                  width: 0,
                ),
          Text(AppLocalizations.of(context)
              .translate("pleaseSaveTheFollowingCodeInASecurePlace")),
          SizedBox(
            height: 8,
          ),
          Text(
              "${AppLocalizations.of(context).translate("warrantyCode")}: ${warrenty.warrantyCode}"),
          SizedBox(
            height: 8,
          ),
          Text(
              "${AppLocalizations.of(context).translate("startDate")}: ${dateFormater(bougthDate)}"),
          SizedBox(
            height: 8,
          ),
          Text(
              "${AppLocalizations.of(context).translate("endDate")}: ${dateFormater(endDate)}"),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    ),
    actions: [
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        child: Text(AppLocalizations.of(context).translate("ok")),
      ),
      FlatButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WarrantyDetailPage(
                warranty: warrenty,
              ),
            ),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => WarrantyDetailPage(
          //       warranty: warrenty,
          //     ),
          //   ),
          // );
        },
        child: Text(AppLocalizations.of(context).translate("goToDetails")),
      ),
    ],
  );
}
