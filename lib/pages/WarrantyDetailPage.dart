import 'dart:io';

import 'package:ewarrenty/Function/PDFGenerator.dart';
import 'package:ewarrenty/Icons/warranty_icons_icons.dart';
import 'package:ewarrenty/pages/PdfViewerPage.dart';
import 'package:flutter/material.dart';
import 'package:ewarrenty/app_localizations.dart';
import 'package:path_provider/path_provider.dart';


class WarrantyDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${AppLocalizations.of(context).translate("warrantyCode")} 1596"),
          actions: [
            IconButton(icon: Icon(WarrantyIcons.warrenty_pdf,size: 36,), onPressed: () async {
              Directory tempDir = await getTemporaryDirectory();
              String tempPath = tempDir.path;
              var path ="$tempPath/SAC64${DateTime.now()}.pdf";
              await PDFGenerator(path, "ksdbg", "batteryModel", "ownerNAme", DateTime.now(), DateTime.now());
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfViewerPage(path: path,)));
            })
          ],
        ),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "${AppLocalizations.of(context).translate("batteryModel")}: MPU-15",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "${AppLocalizations.of(context).translate("batterySerialNumber")}: LSKVLK518SSDV5",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "${AppLocalizations.of(context).translate("customerName")}: Name Surname",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "${AppLocalizations.of(context).translate("marketName")}: Al-Awael",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "${AppLocalizations.of(context).translate("marketAddress")}: Dams-Beruit",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "${AppLocalizations.of(context).translate("marketEMail")}: email@email.com",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "${AppLocalizations.of(context).translate("marketPhone")}: +39654921684",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "${AppLocalizations.of(context).translate("boughtDate")}: 2020-12-20",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "${AppLocalizations.of(context).translate("carProperty")}: Private",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "${AppLocalizations.of(context).translate("carModel")}: Lamborghini",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate("batteryFrontImage"),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.asset("assets/images/home/1.png",
                        fit: BoxFit.cover),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate("fixedBatteryImage"),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child:
                        Image.asset("assets/images/bill.jpg", fit: BoxFit.cover),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate("carNumberIncludingItsColorImage"),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.asset(
                      "assets/images/number.jpg",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
