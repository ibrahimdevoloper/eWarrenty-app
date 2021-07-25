import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

AlertDialog warrantyTermsDialog(BuildContext context) {
  //TODO: may the about company change
  FirebaseAnalytics().setCurrentScreen(
      screenName: "warrantyTermsDialog",
      screenClassOverride: "warrantyTermsDialog");
  return AlertDialog(
    title: Text(AppLocalizations.of(context).translate("warrantyTerms")),
    content: SingleChildScrollView(
        child: Text(
            AppLocalizations.of(context).translate("warrantyTermsContent"))),
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
