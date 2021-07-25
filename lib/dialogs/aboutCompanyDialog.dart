import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

AlertDialog aboutCompanyDialog(BuildContext context) {
  //TODO: may the about company change
  FirebaseAnalytics().setCurrentScreen(
      screenName: "aboutCompanyDialog",
      screenClassOverride: "aboutCompanyDialog");
  return AlertDialog(
    title: Text(AppLocalizations.of(context).translate("aboutCompany")),
    content: SingleChildScrollView(
        child: Text(
            AppLocalizations.of(context).translate("aboutCompanyContent"))),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(AppLocalizations.of(context).translate("ok")),
      ),
    ],
  );
}
