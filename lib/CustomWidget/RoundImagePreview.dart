import 'package:flutter/material.dart';

class RoundImagePreview extends StatelessWidget {
  Widget _child;

  RoundImagePreview({
    Key key,
    Widget child,
  })  : this._child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
      child: AspectRatio(aspectRatio: 4 / 3, child: _child),
    );
  }
}
