import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewarrenty/Constants/Constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

AlertDialog whereIsSerialNumberDialog(BuildContext context,
    {@required String text, @required String imageUrl}) {
  FirebaseAnalytics().setCurrentScreen(screenName: "whereIsSerialNumberDialog");
  return AlertDialog(
    title: Text(AppLocalizations.of(context)
        .translate("WhereIsMyBatterysSerialNumber")),
    content: SingleChildScrollView(
      child: Column(
        // shrinkWrap: true,
        children: [
          Text(text),
          SizedBox(
            height: 8,
          ),
          Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageUrl: "$imageBaseUrl/$imageUrl",
              ),
            ),
          )
        ],
      ),
    ),
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
