// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: IgnorePointer(
              child: Image.asset(
                'assets/images/chef_one.png',
                color: AppColors.primaryColor.withOpacity(0.08),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
