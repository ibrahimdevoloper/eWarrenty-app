import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

import '../app_localizations.dart';

class PdfViewerPage extends StatelessWidget {
  final String path;
  const PdfViewerPage({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics().setCurrentScreen(screenName: "PdfViewerPage",screenClassOverride: "PdfViewerPage");
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("preview"),
          style: GoogleFonts.cairo(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.shareAlt,
              color: Colors.white,
            ),
            onPressed: () {
              Share.shareFiles(
                [path],
                text: "hi see you soon",
              );
            },
          )
        ],
      ),
      path: path,
    );
  }
}
