import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class BottomContent extends StatelessWidget {
  final VoidCallback? onExploreTap;
  const BottomContent({this.onExploreTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: const BoxDecoration(color: Color(0xff5A4B2D)),
      child: Column(
        children: [
          Text(
            'For those who seek\n more than restaurants',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              fontSize: 28,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Foodyore is for travellers, food lovers, families, and curious minds '
            'who want to connect with culture through food.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              'You don’t just eat here. You belong, even if only for an evening.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.regular,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onExploreTap,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.white, width: 1),
                ),
              ),
              child: Text(
                'Explore Our Dining Experiences',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.regular,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
