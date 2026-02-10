// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

class CustomCircularButton extends StatelessWidget {
  final Widget icon;
  final Color? color;
  const CustomCircularButton({
    Key? key,
    required this.icon,
    this.color = const Color.fromARGB(255, 240, 178, 121),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color!.withOpacity(0.35),
            shape: BoxShape.circle,
          ),
          child: icon,
        ),
      ),
    );
  }
}
