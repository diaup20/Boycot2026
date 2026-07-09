import 'package:flutter/material.dart';

class BottomWavePathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path();
    p.lineTo(0, size.height - 40);
    p.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    p.lineTo(size.width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
