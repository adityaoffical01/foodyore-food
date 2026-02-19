
import 'package:flutter/material.dart';

class GradientOverlay extends StatelessWidget {
  final BuildContext context;
  const GradientOverlay(this.context);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black26, Colors.black],
          ),
        ),
      ),
    );
  }
}

