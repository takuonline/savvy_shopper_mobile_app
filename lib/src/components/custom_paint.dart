import 'package:e_grocery/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class HomeBGCustomPaint extends CustomPainter{

  HomeBGCustomPaint({this.color});

  Color color ;


  @override
  void paint(Canvas canvas, Size size) {



    Paint paint_0 = new Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.00, 0);
    path_0.quadraticBezierTo(size.width * -0.01, size.height * 0.88,
        size.width * -0.01, size.height * 0.84);
    path_0.cubicTo(size.width * 0.08, size.height * 0.80, size.width * 0.18,
        size.height * 0.74, size.width * 0.26, size.height * 0.74);
    path_0.cubicTo(size.width * 0.36, size.height * 0.74, size.width * 0.58,
        size.height * 0.90, size.width * 0.74, size.height * 0.89);
    path_0.cubicTo(size.width * 0.83, size.height * 0.90, size.width * 0.91,
        size.height * 0.82, size.width, size.height * 0.82);
    path_0.quadraticBezierTo(
        size.width * 1.00, size.height * 0.63, size.width, size.height * 0.00);
    path_0.lineTo(size.width * -0.00, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}


