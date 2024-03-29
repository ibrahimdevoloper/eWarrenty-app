import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  final String _title;
  final Widget _child;


  ImageBanner({title, child}):this._title=title, this._child=child;

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
                      // Theme.of(context).colorScheme.secondary
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

