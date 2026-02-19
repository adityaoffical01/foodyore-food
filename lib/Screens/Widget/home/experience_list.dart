import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Foodyore_experiance_card.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Widget/Categry_details_widget.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';

class ExperienceList extends StatelessWidget {
  const ExperienceList({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Explore Our Experience',
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () => Get.to(const CategryDetailsWidget()),
              child: const FoodyoreExperianceCard(),
            ),
          ),
        ),
      ],
    );
  }
}
