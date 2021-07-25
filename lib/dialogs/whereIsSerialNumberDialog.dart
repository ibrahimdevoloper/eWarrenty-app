import 'package:ewarrenty/CustomWidget/RoundImagePreview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

AlertDialog whereIsSerialNumberDialog(BuildContext context,
    {@required String text, @required String imageUrl}) {
  FirebaseAnalytics().setCurrentScreen(
      screenName: "whereIsSerialNumberDialog",
      screenClassOverride: "whereIsSerialNumberDialog");
  return AlertDialog(
    title: Text(AppLocalizations.of(context)
        .translate("WhereIsMyBatterysSerialNumber")),
    content: SingleChildScrollView(
      child: Column(
        // shrinkWrap: true,
        children: [
          Text("example on where you can find the Serial Number"),
          SizedBox(
            height: 8,
          ),
          RoundImagePreview(
            child: Image.asset('assets/images/serialNumber/1.png'),
          ),
          RoundImagePreview(
            child: Image.asset('assets/images/serialNumber/2.jpg'),
          ),
          RoundImagePreview(
            child: Image.asset('assets/images/serialNumber/3.png'),
          ),
        ],
      ),
    ),
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
