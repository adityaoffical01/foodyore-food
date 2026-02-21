import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Home/Products/Product_Details_Page.dart';
import 'package:foodyore/controller/category_controller.dart';
import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/model/category_model.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_Loder.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CategryDetailsWidget extends StatefulWidget {
  final CategoryItem? catItem;
  const CategryDetailsWidget({Key? key, this.catItem}) : super(key: key);

  @override
  State<CategryDetailsWidget> createState() => _CategryDetailsWidgetState();
}

class _CategryDetailsWidgetState extends State<CategryDetailsWidget> {
  final CategoryController categoryController = Get.find<CategoryController>();
  final ScrollController _scrollController = ScrollController();
  final items = [
    {
      "title": "Orchards",
      "host": "Aditya Singh",
      "location": "Lucknow",
      "btn": "View 2 Available Options",
    },
    {
      "title": "Agricultural Land",
      "host": "Nitya Singh",
      "location": "Lucknow",
      "btn": "View 1 Available Options",
    },
    {
      "title": "Orchards",
      "host": "Aditya Singh",
      "location": "Lucknow",
      "btn": "View 2 Available Options",
    },
    {
      "title": "Agricultural Land",
      "host": "Nitya Singh",
      "location": "Lucknow",
      "btn": "View 1 Available Options",
    },
    {
      "title": "Orchards",
      "host": "Aditya Singh",
      "location": "Lucknow",
      "btn": "View 2 Available Options",
    },
  ];
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
                            onTap: () => Get.to(ProductDetailsPageWidget()),
                            child: categoryCard(
                              title: item.subCategoryName ?? '',
                              host: (item.hostName ?? '').toUpperCase(),
                              location: item.address2 ?? '',
                              buttonText: "View Details",
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

  // for card
  Widget categoryCard({
    required String title,
    required String host,
    required String location,
    required String buttonText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                'assets/images/formland.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Hosted by ',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: host,
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Iconsax.location,
                        size: 10,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ❌ Spacer REMOVED
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: AppColors.primaryColor,
              child: Center(
                child: Text(
                  buttonText,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
