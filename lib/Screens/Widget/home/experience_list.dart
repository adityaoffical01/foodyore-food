import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Foodyore_experiance_card.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Widget/Categry_details_widget.dart';
import 'package:foodyore/controller/category_controller.dart';

import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_Loder.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';

class ExperienceList extends StatelessWidget {
  ExperienceList({super.key});
  final CategoryController controller = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = controller.categoryData.value;
      switch (state.status) {
        case Status.LOADING:
          return CustomLoder(color: AppColors.primaryColor);
        case Status.COMPLETED:
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
                itemCount: state.data!.data!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final item = state.data!.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () => Get.to(const CategryDetailsWidget()),
                      child: FoodyoreExperianceCard(
                        imgUrls: '',
                        tittle: item.categoryName ?? '',
                      ),
                    ),
                  );
                },
              ),
            ],
          );

        case Status.ERROR:
          return Text("Something went wrong");

        default:
          return SizedBox();
      }
    });
  }
}
