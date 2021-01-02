import 'package:flutter/material.dart';

import '../app_localizations.dart';

AlertDialog aboutCompanyDialog(BuildContext context) {
  //todo: may the about company change
  return AlertDialog(
    title: Text(AppLocalizations.of(context).translate("aboutCompany")),
    content: SingleChildScrollView(child: Text(AppLocalizations.of(context).translate("aboutCompanyContent"))),
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
