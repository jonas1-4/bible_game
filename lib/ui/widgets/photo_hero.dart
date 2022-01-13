import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero({required this.photo, required this.width});

  final String photo;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: Image.asset(
            photo,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
