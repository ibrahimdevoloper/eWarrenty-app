import 'package:ewarrenty/Blocs/GetWarranty/get_warranty_cubit.dart';
import 'package:ewarrenty/Blocs/InitData/init_data_cubit.dart';
import 'package:ewarrenty/pages/WarrantyDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_localizations.dart';
import "package:ewarrenty/Models/warranty.dart";
import "package:ewarrenty/Function/dateFormatter.dart";

AlertDialog showSummeryDialog(BuildContext context, Warranty warrenty) {
  var bougthDate = DateTime.parse(warrenty.boughtDate);
  var endDate = DateTime(bougthDate.year,
      bougthDate.month + warrenty.warrantyDuration, bougthDate.day);
  return AlertDialog(
    title: Text(AppLocalizations.of(context)
        .translate("congratulationsOnGettingYourWarrenty")),

    // content: SingleChildScrollView(child: Text(AppLocalizations.of(context).translate("aboutCompanyContent"))),
    content: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)
              .translate("pleaseSaveTheFollowingCodeInASecurePlace")),
          SizedBox(
            height: 8,
          ),
          Text("${AppLocalizations.of(context)
              .translate("warrantyCode")}: ${warrenty.warrantyCode}"),
          SizedBox(
            height: 8,
          ),
          Text("${AppLocalizations.of(context)
              .translate("startDate")}: ${dateFormater(bougthDate)}"),
          SizedBox(
            height: 8,
          ),
          Text("${AppLocalizations.of(context)
              .translate("endDate")}: ${dateFormater(endDate)}"),
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
        child: Text(AppLocalizations.of(context)
            .translate("goToDetails")),
      ),
    ],
  );
}
