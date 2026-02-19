import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class OutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color borderColor;
  const OutlineButton(
    this.title, {
    this.onTap,
    this.borderColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: borderColor)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: borderColor,
            fontFamily: AppFonts.regular,
          ),
        ),
      ),
    );
  }
}
