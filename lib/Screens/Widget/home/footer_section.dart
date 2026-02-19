
import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      decoration: const BoxDecoration(color: Color(0xff5A4B2D)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/icon/logo_icon.png', height: 20),
          SizedBox(height: 15),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Foodyore ',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.regular,
                    color: AppColors.white,
                  ),
                ),
                TextSpan(
                  text:
                      'is a curated experiential dining platform connecting guests with hosts across India. '
                      'Each experience is rooted in place, people, and tradition.',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.regular,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 15),
          Text(
            'About Us',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Contact Us',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Privacy Policy',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Terms and Conditions',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
