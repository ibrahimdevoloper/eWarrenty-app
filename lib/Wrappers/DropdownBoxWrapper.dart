import 'package:flutter/material.dart';

class DropdownBoxWrapper extends StatelessWidget {
  final String title;
  final Color color;
  final Widget child;

  const DropdownBoxWrapper({Key key, this.title, this.color, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              color: color),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            border: Border(
              bottom: BorderSide(width: 2, color: color),
              top: BorderSide(width: 2, color: color),
              left: BorderSide(width: 2, color: color),
              right: BorderSide(width: 2, color: color),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        )
      ],
    );
  }
}
