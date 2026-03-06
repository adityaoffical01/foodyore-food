import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Home/Products/Product_Details_Page.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Widget/category_card_widget.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Widget/choose_yore_destination.dart';
import 'package:foodyore/controller/category_controller.dart';
import 'package:foodyore/controller/search_controller.dart';

import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_Loder.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:get/get.dart';

class CategryDetailsWidgetBySearch extends StatefulWidget {
  final String cityId;
  const CategryDetailsWidgetBySearch({super.key, required this.cityId});

  @override
  State<CategryDetailsWidgetBySearch> createState() =>
      _CategryDetailsWidgetBySearchState();
}

class _CategryDetailsWidgetBySearchState
    extends State<CategryDetailsWidgetBySearch> {
  final SearchCityController searchCityController =
      Get.find<SearchCityController>();
  final CategoryController categoryController = Get.find<CategoryController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    searchCityController.fetchCitySubcategories(widget.cityId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppbar(
        title: 'SubCategory',
        subTitle: 'Farm-based dining shaped by season and soil',
      ),
      body: CustomBackground(
        child: LayoutBuilder(
          builder: (context, constraints) {
            const horizontalPadding = 32.0;
            const spacing = 10.0;

            final availableWidth =
                constraints.maxWidth - horizontalPadding - spacing;

            final itemWidth = availableWidth / 2;

            return SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Obx(() {
                final response =
                    searchCityController.subCategorySearchData.value;

                if (response.status == Status.LOADING) {
                  return const Center(
                    child: CustomLoder(color: AppColors.primaryColor),
                  );
                }

                if (response.status == Status.ERROR) {
                  return const Center(child: Text("Something went wrong"));
                }

                if (response.data?.data == null ||
                    response.data!.data!.isEmpty) {
                  return Center(child: Text("not Found data"));
                }

                final subCategories = response.data!.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: List.generate(subCategories.length, (index) {
                        final item = subCategories[index];
                        return SizedBox(
                          width: itemWidth,
                          child: GestureDetector(
                            onTap: () {
                              print('Item: ${item.toJson()}');
                              if (item.subCategoryName!.toLowerCase().contains(
                                'farm land',
                              )) {
                                Get.to(
                                  ChooseDestinationWidget(
                                    subCategoryItem: item,
                                  ),
                                );
                              } else {
                                categoryController
                                    .fetchFarmlandSubCate(
                                      context: context,
                                      cateID: item.categoryID ?? "",
                                      subCateID: item.subCategoryID ?? '',
                                      hostId: item.hostID ?? '',
                                    )
                                    .then((isCate) {
                                      if (isCate) {
                                        Get.to(
                                          ProductDetailsPageWidget(
                                            cattId: item.categoryID.toString(),
                                            hostId: item.hostID.toString(),
                                            subCatId: item.subCategoryID
                                                .toString(),
                                            // locationId: item.locationID
                                            //     .toString(),
                                            descriptionId: '',
                                          ),
                                        );
                                      }
                                    });
                                // Get.to(
                                //   ProductDetailsPageWidget(
                                //     cattId: item.categoryID.toString(),
                                //     hostId: item.hostID.toString(),
                                //     subCatId: item.subCategoryID.toString(),
                                //     locationId: item.locationID.toString(),

                                //   ),
                                // );
                              }
                            },
                            child: categoryCard(
                              title: item.subCategoryName ?? '',
                              host: (item.hostName ?? '').toUpperCase(),
                              location: item.city ?? '',
                              buttonText:
                                  item.categoryName!.toLowerCase().contains(
                                    'farm land',
                                  )
                                  ? "View Avalible Option"
                                  : "View Details",
                            ),
                          ),
                        );
                      }),
                    ),
                    if (categoryController.isSubCategoryLoadingMore.value)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: CustomLoder(color: AppColors.primaryColor),
                      ),
                    if (!categoryController.hasMoreSubCategories.value &&
                        subCategories.isNotEmpty)
                      Center(
                        child: const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 4),
                          child: Text('No more data'),
                        ),
                      ),
                  ],
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
