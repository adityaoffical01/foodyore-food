import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Home/Products/Product_Details_Page.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Widget/category_card_widget.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Widget/choose_yore_destination.dart';
import 'package:foodyore/controller/category_controller.dart';
import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/model/category_model.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_Loder.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:get/get.dart';

class CategryDetailsWidget extends StatefulWidget {
  final CategoryItem? catItem;
  const CategryDetailsWidget({Key? key, this.catItem}) : super(key: key);

  @override
  State<CategryDetailsWidget> createState() => _CategryDetailsWidgetState();
}

class _CategryDetailsWidgetState extends State<CategryDetailsWidget> {
  final CategoryController categoryController = Get.find<CategoryController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    if (widget.catItem?.categoryID != null) {
      categoryController.fetchSubCategories(
        context,
        widget.catItem!.categoryID!,
      );
    }
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 250) {
      categoryController.fetchMoreSubCategories(context);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppbar(
        title: widget.catItem?.categoryName ?? '',
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
                final response = categoryController.subCategoryData.value;

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
                              if (widget.catItem!.categoryName!
                                  .toLowerCase()
                                  .contains('farm land')) {
                                Get.to(
                                  ChooseDestinationWidget(
                                    subCategoryItem: item,
                                  ),
                                );
                              } else {
                                Get.to(ProductDetailsPageWidget());
                              }
                            },
                            child: categoryCard(
                              title: item.subCategoryName ?? '',
                              host: (item.hostName ?? '').toUpperCase(),
                              location: item.address2 ?? '',
                              buttonText:
                                  widget.catItem!.categoryName!
                                      .toLowerCase()
                                      .contains('farm land')
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
                      const Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 4),
                        child: Text('No more data'),
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
