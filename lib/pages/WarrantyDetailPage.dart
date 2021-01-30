import 'dart:io';

import 'package:ewarrenty/Blocs/GetWarranty/get_warranty_cubit.dart';
import 'package:ewarrenty/Function/PDFGenerator.dart';
import 'package:ewarrenty/Icons/warranty_icons_icons.dart';
import 'package:ewarrenty/Models/warranty.dart';
import 'package:ewarrenty/pages/PdfViewerPage.dart';
import 'package:flutter/material.dart';
import 'package:ewarrenty/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pdf/widgets/decoration.dart';

class WarrantyDetailPage extends StatelessWidget {
  final Warranty _warranty;

  WarrantyDetailPage({@required Warranty warranty}) : this._warranty = warranty;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/whiteback.png',fit: BoxFit.cover,),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
                "${AppLocalizations.of(context).translate("warrantyCode")} 1596"),
            actions: [
              IconButton(
                  icon: Icon(
                    WarrantyIcons.warrenty_pdf,
                    size: 36,
                  ),
                  onPressed: () async {
                    Directory tempDir = await getTemporaryDirectory();
                    String tempPath = tempDir.path;
                    var path = "$tempPath/SAC64${DateTime.now()}.pdf";
                    await PDFGenerator(path, "ksdbg", "batteryModel", "ownerNAme",
                        DateTime.now(), DateTime.now());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PdfViewerPage(
                                  path: path,
                                )));
                  })
            ],
          ),
          body: ListView(
            shrinkWrap: true,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient:LinearGradient(
                    // stops: [0.1, 0.85],
                    colors: [
                      Colors.blue[700],
                      // Theme.of(context).primaryColor,
                      // Theme.of(context).accentColor
                      // Colors.deepPurpleAccent[500],
                      Colors.indigo[900]
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset('assets/images/whitelogo.png',fit: BoxFit.fitHeight,),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Card(
                // color: Theme.of(context).primaryColor.withOpacity(0.3),
                color: Color.fromRGBO(0x00, 0x4A, 0x80, 0.21),
                // color: Colors.transparent,
                elevation: 0,
                child: Text("${AppLocalizations.of(context).translate("warrantyCode")} 1596"
                ),
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
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "${AppLocalizations.of(context).translate("marketEMail")}: email@email.com",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(
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
                      AppLocalizations.of(context)
                          .translate("carNumberIncludingItsColorImage"),
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
          ),
        ),
      ],
    );
  }
}
