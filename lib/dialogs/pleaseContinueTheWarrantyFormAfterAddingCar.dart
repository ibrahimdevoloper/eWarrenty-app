import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

AlertDialog pleaseContinueTheWarrantyFormAfterAddingCarDialog(
    BuildContext context) {
  //TODO: may the about company change
  FirebaseAnalytics().setCurrentScreen(
      screenName: "pleaseContinueTheWarrantyFormAfterAddingCarDialog",
      screenClassOverride: "pleaseContinueTheWarrantyFormAfterAddingCarDialog");
  return AlertDialog(
    title: Text(AppLocalizations.of(context).translate("carWasRegistered")),
    content: SingleChildScrollView(
        child: Text(AppLocalizations.of(context).translate(
            "pleaseContinueTheWarrantyRegistrationByFillingTheRemainingFields"))),
    actions: [
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(AppLocalizations.of(context).translate("ok")),
      ),
    ],
  );
}
