import 'package:flutter/material.dart';


class ImagePreviewButtonWithBanner extends StatelessWidget {
  final String _title;
  final String _subtitle;
  final Widget _child;


  ImagePreviewButtonWithBanner({title,subtitle, child}):this._subtitle=subtitle,this._title=title, this._child=child;

  @override
  Widget build(BuildContext context) {

    final bannerStyle =TextStyle(
        color: Colors.white,
        fontSize:
        Theme.of(context).textTheme.headline5.fontSize);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(16) ,
          color: Color.fromRGBO(0x00, 0x4A, 0x80, 0.21),
        ),
        child: Container(
          child: Column(
            children: [
              Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
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
                child: Center(
                  child: Text(
                    // AppLocalizations.of(context)
                    //     .translate("batteryFrontImage"),
                    _title,
                    style: bannerStyle,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(36.0),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: _child,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




class ImagePreview extends StatelessWidget {
  final String _title;
  final String _subtitle;
  final Widget _widget;

  ImagePreview(this._title, this._subtitle, this._widget);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _title,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.button.fontSize,
                color: Colors.white),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            _subtitle,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.caption.fontSize,
                color: Colors.white),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 200,
            child: AspectRatio(aspectRatio: 4 / 3, child: _widget
              // _imagePath.contains("assets")
              //     ? Image.asset(_imagePath)
              //     : Image.file(
              //         File(
              //           _imagePath,
              //         ),
              //         fit: BoxFit.cover,
              //       ),
            ),
          ),
        ],
      ),
    );
  }
}
