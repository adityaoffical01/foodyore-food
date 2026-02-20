// Hero Text Widget
import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/All_experiances_widget.dart';
import 'package:foodyore/Screens/Widget/home/out_line_button.dart';
import 'package:foodyore/Screens/Widget/home/primary_button.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';

class HeroText extends StatelessWidget {
  final VoidCallback onExploreTap;

  const HeroText({super.key, required this.onExploreTap});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Column(
        children: [
          Text(
            'Stories served warm',
            style: AppTextStyles.headingLarge.copyWith(
              color: AppColors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Not just a meal. A place,\na story, a shared table.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: onExploreTap,
            // onTap: () {
            //   Get.to(AllExperiancesWidget());
            // },
            child: PrimaryButton('EXPLORE OUR EXPERIENCES'),
          ),
          const SizedBox(height: 8),
          OutlineButton('BECOME OUR HOST'),
        ],
      ),
    );
  }
}
