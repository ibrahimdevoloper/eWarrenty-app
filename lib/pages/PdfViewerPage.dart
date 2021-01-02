import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

import '../app_localizations.dart';

class PdfViewerPage extends StatelessWidget {
  final String path;
  const PdfViewerPage({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context).translate("preview")),actions: [
          IconButton(icon: Icon(
            FontAwesomeIcons.shareAlt
            ,color: Colors.white,)
          ,onPressed: (){
            // todo: share the file
              Share.shareFiles([path],text:"hi see you soon",);
            },)
        ],),
        path: path,
      );
  }
}