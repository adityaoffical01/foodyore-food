// ignore_for_file: deprecated_member_use

import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:flutter/material.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_Loder.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? raduis;
  final Color? color;
  final double? bottom;
  final double? horizontal;
  final double? top;
  final bool? isShadow;

  final double? height;
  final double? width;
  final bool? isLoading;
  final Color? tittleColor;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.raduis = 60.0,
    this.color = AppColors.secondaryColor,
    this.bottom = 10,
    this.height = 45.0,
    this.isLoading = false,
    this.width = double.infinity,
    this.tittleColor = AppColors.white,
    this.horizontal = 15,
    this.isShadow = true,
    this.top,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal!,
      ).copyWith(bottom: bottom, top: top),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(raduis!),
          boxShadow: isShadow == true
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: MaterialButton(
          elevation: 0,
          height: height,
          minWidth: width,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(raduis!),
          ),
          color: color,
          onPressed: onPressed,
          child: isLoading == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomLoder(size: 20),
                    const SizedBox(width: 15),
                    Text(
                      'Please Wait..',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: tittleColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.primaryFont,
                    color: tittleColor,
                  ),
                ),
        ),
      ),
    );
  }
}
