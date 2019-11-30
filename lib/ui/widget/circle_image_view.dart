import 'dart:math';

import 'package:flutter/material.dart';

class CircleImageView extends StatelessWidget {
  final Image image;

  const CircleImageView({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: CircleClip(),
      child: image,
    );
  }
}

class CircleClip extends CustomClipper<Rect>{

  @override
  getClip(Size size) {
    // TODO: implement getClip 
    return Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: min(size.width, size.height) / 2
    );
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}