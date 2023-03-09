import 'package:flutter/material.dart';

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    const offset = 50;
    const radius = 80;
    path.lineTo(size.width-offset, 0);
    path.lineTo(size.width-offset, size.height);
    path.lineTo(0, size.height);
    path.moveTo(size.width-offset, size.height/2-radius);
    path.quadraticBezierTo(size.width, size.height/2, size.width-offset, size.height/2+radius);
    path.moveTo(size.width-offset, size.height/2-radius-10);
    path.quadraticBezierTo(size.width-offset, size.height/2-radius+10, size.width-offset, size.height/2-radius+50);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}



//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.6606723,size.height*0.4566367);
    path_0.lineTo(size.width*0.6606723,size.height*0.4574679);
    path_0.arcToPoint(Offset(size.width*0.6176651,size.height*0.5167887),radius: Radius.elliptical(size.width*0.2750708, size.height*0.1122221),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.lineTo(size.width*0.5872764,size.height*0.5365321);
    path_0.arcToPoint(Offset(size.width*0.5652187,size.height*0.5676535),radius: Radius.elliptical(size.width*0.1433535, size.height*0.05848470),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.lineTo(size.width*0.5652187,size.height*0.8799605);
    path_0.cubicTo(size.width*0.5652187,size.height*0.8988223,size.width*0.5266829,size.height*0.9141165,size.width*0.4791460,size.height*0.9141165);
    path_0.lineTo(size.width*-0.1288161,size.height*0.9141165);
    path_0.lineTo(size.width*-0.1288161,0);
    path_0.lineTo(size.width*0.4791436,0);
    path_0.cubicTo(size.width*0.5266829,0,size.width*0.5652162,size.height*0.01528924,size.width*0.5652162,size.height*0.03415597);
    path_0.lineTo(size.width*0.5652162,size.height*0.3464531);
    path_0.arcToPoint(Offset(size.width*0.5872740,size.height*0.3775745),radius: Radius.elliptical(size.width*0.1433535, size.height*0.05848470),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.lineTo(size.width*0.6176626,size.height*0.3973179);
    path_0.arcToPoint(Offset(size.width*0.6606699,size.height*0.4566387),radius: Radius.elliptical(size.width*0.2751434, size.height*0.1122517),rotation: 0 ,largeArc: false,clockwise: true);

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xfff0eee6).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}