import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MClipper(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 380,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.deepPurple,
            Colors.blue,
            Colors.blue,
            Colors.blue,
            Colors.deepPurple,
          ]),
        ),
      ),
    );
  }
}

class MClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
