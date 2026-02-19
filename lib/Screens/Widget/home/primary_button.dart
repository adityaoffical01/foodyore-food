import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const PrimaryButton(this.title, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.primaryColor),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
            fontFamily: AppFonts.regular,
          ),
        ),
      ),
    );
  }
}
