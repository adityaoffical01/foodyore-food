// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: Image.asset(
              'assets/images/chef_one.png',
              color: AppColors.primaryColor.withOpacity(0.08),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
