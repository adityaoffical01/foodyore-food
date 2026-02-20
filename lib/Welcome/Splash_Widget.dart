// ignore_for_file: deprecated_member_use

import 'package:foodyore/Screens/Home/Home_Screen.dart';
import 'package:foodyore/Welcome/Introduction_widget.dart';
import 'package:foodyore/services/app_config.dart';
import 'package:foodyore/services/auth.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    authToken = getAuthToken();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        authToken.isEmpty
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnboardingScreen(),
                ),
              )
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            color: AppColors.white.withOpacity(0.3),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          FadeTransition(
            opacity: _animation,
            child: Center(
              child: ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  'assets/icon/logo_icon.png',
                  width: 180,
                  height: 180,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
