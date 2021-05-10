import 'dart:io';

import 'package:ewarrenty/Function/FirebaseCrashlyticsLog.dart';
import 'package:ewarrenty/Function/checkIfArabic.dart';
import 'package:ewarrenty/Models/warranty.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future PDFGenerator({
  @material.required String path,
  @material.required Warranty warranty,
  @material.required String startDate,
  @material.required String endDate,
  @material.required String lang,
}) async {
  final Document pdf = Document();
  var dataAR = await rootBundle.load("fonts/alja/Al-Jazeera-Regular.ttf");
  var myFontAR = Font.ttf(dataAR);
  var dataEn = await rootBundle.load("fonts/Almarai/Almarai-Regular.ttf");
  var myFontEn = Font.ttf(dataEn);
  var arabicStyle = TextStyle(font: myFontAR, fontSize: 24);
  var englishStyle = TextStyle(font: myFontEn, fontSize: 24);

  var footer = await imageFromAsset(
      assetsPath: "assets/images/PDF/footer.png", filename: "footer.png");
  var header = await imageFromAsset(
      assetsPath: "assets/images/PDF/header.png", filename: "header.png");
  var background = await imageFromAsset(
      assetsPath: "assets/images/PDF/background.png",
      filename: "background.png");

  pdf.addPage(MultiPage(
    pageFormat: PdfPageFormat.a4,
    margin: EdgeInsets.zero,
    header: (context) => Image(header, fit: BoxFit.scaleDown),
    footer: (context) => Image(footer, fit: BoxFit.scaleDown),
    maxPages: 3,
    build: (context) {
      return [
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        lang.contains("ar")
                            ? arabicTextWidget(
                                text: "كود الكفالة:", style: arabicStyle)
                            : englishTextWidget(
                                text: "Warranty Code:", style: englishStyle),
                        englishTextWidget(
                            text: warranty.warrantyCode, style: englishStyle)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        lang.contains("ar")
                            ? arabicTextWidget(
                                text: "موديل البطارية:", style: arabicStyle)
                            : englishTextWidget(
                                text: "Battery Model:", style: englishStyle),
                        englishTextWidget(
                            text: warranty.battery.number, style: englishStyle)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 4, color: PdfColors.grey),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        lang.contains("ar")
                            ? arabicTextWidget(
                                text: "تاريخ بداية الكفالة:",
                                style: arabicStyle)
                            : englishTextWidget(
                                text: "Warranty's Start Date:",
                                style: englishStyle),
                        englishTextWidget(text: startDate, style: englishStyle)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        lang.contains("ar")
                            ? arabicTextWidget(
                                text: "تاريخ نهاية الكفالة:",
                                style: arabicStyle)
                            : englishTextWidget(
                                text: "Warranty's End Date:",
                                style: englishStyle),
                        englishTextWidget(text: endDate, style: englishStyle)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 4, color: PdfColors.grey),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  lang.contains("ar")
                      ? arabicTextWidget(
                          text: "اسم مالك الكفالة:", style: arabicStyle)
                      : englishTextWidget(
                          text: "Warranty's Owner Name:", style: englishStyle),
                  checkIfTextInArabic(warranty.customerName)
                      ? arabicTextWidget(
                          text: warranty.customerName, style: arabicStyle)
                      : lang.contains("ar")
                          ? arabicTextWidget(
                              text: warranty.customerName, style: englishStyle)
                          : englishTextWidget(
                              text: warranty.customerName, style: englishStyle)
                ],
              ),
            )
          ],
        ))
      ];
    },
  ));
  //save PDF
  // final String dir = (await getApplicationDocumentsDirectory()).path;
  // final String path = '$dir/BMI/orders/report.pdf';
  // print(path);
  try {
    // print('before save');
    File file = File(path);
    // file.createSync();
    await file.writeAsBytes(await pdf.save());
    // print('after save');
  } catch (e) {
    // print(e);
    firebaseCrashLog(
      tag: "PDFGenerator",
      message: e.toString(),
    );
  }
}

Widget arabicTextWidget({text, style}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Text(text, style: style),
  );
}

Widget englishTextWidget({text, style}) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Text(text, style: style),
  );
  // return Text(text, style: style);
}

Widget returnTAble(List<List<String>> e, context) {
  // print("returnTAble:${e.length}");
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Table.fromTextArray(
      context: context,
      data: e,
    ),
  );
}

Future<MemoryImage> imageFromAsset({
  @material.required String assetsPath,
  @material.required String filename,
}) async {
  var bytes = await rootBundle.load(assetsPath);

  // var filename = 'header.png';
  String dir = (await getApplicationDocumentsDirectory()).path;

  final buffer = bytes.buffer;
  File file = await File('$dir/$filename').writeAsBytes(
    buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
  );

  var image = MemoryImage(
      // File('$dir/$filename').readAsBytesSync(),
      file.readAsBytesSync());
  return image;
}
