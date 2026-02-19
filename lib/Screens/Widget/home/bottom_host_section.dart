import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Widget/home/primary_button.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class BecomeHostSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: const BoxDecoration(color: AppColors.white),
      child: Column(
        children: [
          Text(
            'Become a Host',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              fontSize: 28,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Foodyore is for travellers, food lovers, families, and curious minds who want to connect with culture through food.",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
            child: Text(
              "You don’t just eat here.You belong, even if only for an evening.",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.regular,
                color: AppColors.black,
              ),
            ),
          ),
          const SizedBox(height: 12),
          PrimaryButton('JOIN AS A HOST'),
        ],
      ),
    );
  }
}
