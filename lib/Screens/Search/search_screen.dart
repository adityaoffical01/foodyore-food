import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leadingWidth: 40,
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            Get.back();
          },
          icon: Icon(Iconsax.arrow_left_2_copy, color: AppColors.primaryColor),
        ),
        title: Row(
          spacing: 5,
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    hintText: "Search for your favorite city",
                    prefixIcon: Icon(
                      Iconsax.search_normal_1_copy,
                      color: AppColors.primaryColor,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Iconsax.setting_4_copy,
                  color: AppColors.backgroundColor,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: CustomBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  spacing: 5,
                  children: [
                    Icon(Iconsax.gps_copy, color: AppColors.red, size: 20),
                    Text(
                      "Detact My Location",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: List.generate(8, (index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/lucknow_monuent.png',
                          height: 55,
                          width: 55,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Lucknow',
                          style: AppTextStyles.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
