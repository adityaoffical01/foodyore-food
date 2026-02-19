import 'package:flutter/material.dart';
import 'package:foodyore/Welcome/Splash_Widget.dart';
import 'package:foodyore/services/App_bindings.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/shared_preference_util.dart';
import 'package:get/get.dart';
import 'package:foodyore/utils/helpers/get_di.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await SharedPreferenceUtil.getInstance();
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
      initialBinding: AppBinding(),
    );
  }
}
