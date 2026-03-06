import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Widget/Category_Details_widget_by_search.dart';
import 'package:foodyore/controller/search_controller.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_Loder.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final SearchCityController _searchController = Get.put(
    SearchCityController(),
  );
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
                    suffixIcon: Icon(
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
                  onFieldSubmitted: (value) {
                    _searchController.searchCity(value);
                  },
                  onChanged: (value) {
                    _searchController.searchCity(value);
                  },
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
                SizedBox(height: 20),
                Obx(() {
                  if (_searchController.isSearchLoading.value) {
                    return Center(
                      child: CustomLoder(color: AppColors.primaryColor),
                    );
                  } else if (_searchController.searchData.value.data == null ||
                      _searchController.searchData.value.data!.data!.isEmpty) {
                    return Text(
                      'Curently no outlet avalible at your location ',
                    );
                  } else {
                    final searh =
                        _searchController.searchData.value.data!.data!;
                    return GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      children: List.generate(searh.length, (index) {
                        return InkWell(
                          onTap: () {
                            Get.to(
                              CategryDetailsWidgetBySearch(
                                cityId: searh[index].cityId ?? '0',
                              ),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/lucknow_monuent.png',
                                height: 55,
                                width: 55,
                                fit: BoxFit.contain,
                              ),
                              // const SizedBox(height: 6),
                              Text(
                                searh[index].cityName ?? '',
                                style: AppTextStyles.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
