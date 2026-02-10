import 'package:flutter/material.dart';
import 'package:foodyore/Welcome/Splash_Widget.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Foodyore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      ),
      home: SplashScreen(),
    );
  }
}
