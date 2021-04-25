import 'package:flutter/material.dart';

class LoginBackground extends CustomPainter{

  LoginBackground({@required this.isJoin});

  final bool isJoin;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = isJoin ? Colors.redAccent : Colors.lightBlue;
    canvas.drawCircle(Offset(size.width*0.5, 0), size.height*0.7, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}