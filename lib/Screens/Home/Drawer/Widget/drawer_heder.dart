// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class DrawerHeaderSection extends StatelessWidget {
  const DrawerHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        image: const DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 1),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/dp.jpg',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),

          Text(
            'Nittya Singh',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.regular,
              fontSize: 14,
              height: 1.4,
            ),
          ),

          Text(
            'nittyasingh@gmail.com',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.white.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: 12,
              fontFamily: AppFonts.regular,
              // height: 1.2,
            ),
          ),

          Text(
            '+91 9876543210',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.white.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: 12,
              fontFamily: AppFonts.regular,
              // height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
