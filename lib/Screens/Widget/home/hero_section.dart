import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Widget/home/gradient_overlay.dart';
import 'package:foodyore/Screens/Widget/home/hero_text.dart';
import 'package:foodyore/Screens/Widget/home/top_bar.dart';

class HeroSection extends StatelessWidget {
    final VoidCallback onExploreTap;

  const HeroSection({super.key, required this.onExploreTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/picture/home_background.png',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        GradientOverlay(context),
        TopBar(),
        HeroText(onExploreTap: onExploreTap,),
      ],
    );
  }
}
