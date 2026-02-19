import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class FoodMemorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),

      child: Column(
        children: [
          Text(
            'Because food is memory',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              fontSize: 28,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "The most meaningful meals aren’t \nfound on menus. \nThey are shared in courtyards, farms, \nkitchens, \nand under open skies. \n\nFoodyore exists to protect these experiences and \nbring people together through food.",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
