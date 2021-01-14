import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewarrenty/Constants/Constants.dart';

import '../app_localizations.dart';

AlertDialog whereIsSerialNumberDialog(BuildContext context,
    {@required String text, @required String imageUrl}) {
  //TODO: may the about company change
  return AlertDialog(
    title: Text("Where Is My Batterys Serial Number ?"),
    content: SingleChildScrollView(
      child: Column(
        // shrinkWrap: true,
        children: [
          Text(text),
          SizedBox(
            height: 8,
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageUrl: "$baseUrl/$imageUrl",
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
