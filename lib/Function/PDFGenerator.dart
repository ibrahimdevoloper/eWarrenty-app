import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';

import 'dateFormatter.dart';

Future PDFGenerator(String path, String warrantyCode, String batteryModel,
    String ownerNAme, DateTime startDate, DateTime endDate) async {
  final Document pdf = Document();
  // var myTheme = ThemeData.withFont(
  //   base: Font.ttf(
  //       await rootBundle.load("assets/fonts/alja/Al-Jazeera-Regular.ttf")),
  //   bold: Font.ttf(
  //       await rootBundle.load("assets/fonts/alja/Al-Jazeera-Bold.ttf")),
  // );
  var data = await rootBundle.load("fonts/alja/Al-Jazeera-Regular.ttf");
  var myFont = Font.ttf(data);
  var arabicStyle = TextStyle(font: myFont, fontSize: 18);
  var englishStyle = TextStyle(fontSize: 18);
  pdf.addPage(Page(
    // pageFormat: PdfPageFormat.a5,
    build: (context) {
      return Center(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text("Warranty Code: ", style: englishStyle),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(warrantyCode, style: englishStyle),
                    ),
                    // Directionality(
                    //   textDirection: TextDirection.rtl,
                    //   child: Text("كود الكفالة",
                    //       style: arabicStyle,
                    // ),
                  ],
                )),
            Container(height: 4, color: PdfColors.grey),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text("Battery Model: ", style: englishStyle),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(batteryModel, style: englishStyle),
                    ),
                    // Directionality(
                    //   textDirection: TextDirection.rtl,
                    //   child: Text("موديل البطارية: ",
                    //       style: TextStyle(font: myFont, fontSize: 18)),
                    // ),
                  ],
                )),
            Container(height: 4, color: PdfColors.grey),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text("Owner Name: ", style: englishStyle),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(ownerNAme, style: englishStyle),
                    ),
                    // Directionality(
                    //   textDirection: TextDirection.rtl,
                    //   child: Text("اسم المالك",
                    //       style: TextStyle(font: myFont, fontSize: 18)),
                    // ),
                  ],
                )),
            Container(height: 4, color: PdfColors.grey),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text("Warranty Start Date: ", style: englishStyle),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(dateFormater(startDate), style: englishStyle),
                  ),
                  // Directionality(
                  //   textDirection: TextDirection.rtl,
                  //   child: Text("اسم المالك",
                  //       style: TextStyle(font: myFont, fontSize: 18)),
                  // ),
                ],
              ),
            ),
            Container(height: 4, color: PdfColors.grey),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text("Warranty End Date: ", style: englishStyle),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(dateFormater(endDate), style: englishStyle),
                    ),
                    // Directionality(
                    //   textDirection: TextDirection.rtl,
                    //   child: Text("اسم المالك",
                    //       style: TextStyle(font: myFont, fontSize: 18)),
                    // ),
                  ],
                )),
            Container(height: 4, color: PdfColors.grey),
            //TODO: add image for the battery
          ],
        ),
      );
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
    await file.writeAsBytes(pdf.save());
    // print('after save');
  } catch (e) {
    print(e);
  }
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
