import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class IntroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(color: AppColors.primaryColor),
      child: Text(
        "Dining, the way it was meant to be\n"
        "At Foodyore, food is not served, it is shared. "
        "You step into real spaces, meet real hosts, and experience meals shaped by land, tradition, and people. "
        "This is dining beyond restaurants.\n\n"
        "Foodyore curates immersive dining experiences across India, hosted in homes, farms, villages, "
        "heritage spaces, and open landscapes. "
        "Each experience is personal, limited, and rooted in culture.",
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.regular,
          color: AppColors.white,
        ),
      ),
    );
  }
}
