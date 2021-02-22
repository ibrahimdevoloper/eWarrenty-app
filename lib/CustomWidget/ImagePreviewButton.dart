import 'package:flutter/material.dart';

class CustomButtonForImagePreview extends StatelessWidget {
  final bool _isError;
  final String _title;
  final String _subtitle;
  final Widget _child;
  final Function _onTap;

  CustomButtonForImagePreview({isError, title, subtitle, child, onTap})
      : _isError = isError,
        _title = title,
        _subtitle = subtitle,
        _child = child,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        gradient: _isError
            ? LinearGradient(
          colors: [
            Colors.redAccent[700],
            // Theme.of(context).accentColor
            Colors.black
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : LinearGradient(
          stops: [0.1, 0.85],
          colors: [
            Theme.of(context).primaryColor,
            // Theme.of(context).accentColor
            // Colors.deepPurpleAccent[500],
            Colors.indigo[600]
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: ImagePreview(
            _title,
            _subtitle,
            _child,
          ),
          onTap: _onTap,
        ),
      ),

      // textColor: Colors.white,
      // color: Theme.of(context).primaryColor,
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
                fontSize: 20,
                color: Colors.white),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            _subtitle,
            style: TextStyle(
                fontSize: 14,
                color: Colors.white),
          ),
          SizedBox(
            height: 10,
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
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
