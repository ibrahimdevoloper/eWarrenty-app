
import 'package:flutter/material.dart';

class ElectricPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint myPaint = Paint();
    // myPaint.strokeWidth=16;
    // myPaint.color=Colors.yellowAccent;
    //
    // Path myPath = Path();
    // myPath.lineTo(0, size.height/2);
    // myPath.quadraticBezierTo(size.width/4, size.height/4, size.width/2, size.height/2);
    // myPath.quadraticBezierTo(size.width*3/4, size.height*3/4, size.width, size.height/2);
    // myPath.lineTo(size.width, size.height);
    // myPath.lineTo(0, size.height);
    // myPath.lineTo(0, size.height/2);
    // myPath.close();
    //
    // canvas.drawPath(myPath, myPaint);

    var paint = Paint();
    paint.color = Colors.yellowAccent[200];
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    // path.quadraticBezierTo(size.width * 0.25, size.height * 0.25,
    //     size.width * 0.5, size.height * 0.5);
    // path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
    //     size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);

    // myPath.quadraticBezierTo(size.width/4, size.height/4, size.width/2, size.height/2);
    // myPath.quadraticBezierTo(size.width/4, size.height/4, size.width/2, size.height/2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }
}