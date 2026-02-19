import 'package:flutter/material.dart';

class BottomImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/picture/bottom_background.jpg',
      width: double.infinity,
      height: 400,
      fit: BoxFit.cover,
    );
  }
}
