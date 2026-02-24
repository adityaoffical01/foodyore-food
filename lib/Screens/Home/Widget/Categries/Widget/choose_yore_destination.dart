import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Home/Products/Product_Details_Page.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Widget/category_card_widget.dart';
import 'package:foodyore/controller/category_controller.dart';
import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/model/sub_cate_model.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_Loder.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:get/get.dart';

class ChooseDestinationWidget extends StatefulWidget {
  final SubCategoryItem subCategoryItem;
  const ChooseDestinationWidget({Key? key, required this.subCategoryItem})
    : super(key: key);

  @override
  State<ChooseDestinationWidget> createState() =>
      _ChooseDestinationWidgetState();
}

class _ChooseDestinationWidgetState extends State<ChooseDestinationWidget> {
  final CategoryController _categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    super.initState();
    final subCategoryId = widget.subCategoryItem.subCategoryID ?? '';
    if (subCategoryId.isNotEmpty) {
      _categoryController.fetchFarmlandSubCate(
        context,
        widget.subCategoryItem.categoryID ?? '',
        subCategoryId,
        widget.subCategoryItem.hostID ?? '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationText = [
      widget.subCategoryItem.address1 ?? '',
      widget.subCategoryItem.address2 ?? '',
    ].where((e) => e.trim().isNotEmpty).join(', ');

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppbar(title: 'Choose Your Destination'),
      body: CustomBackground(
        child: LayoutBuilder(
          builder: (context, constraints) {
            const horizontalPadding = 32.0;
            const spacing = 10.0;
            final availableWidth =
                constraints.maxWidth - horizontalPadding - spacing;
            final itemWidth = availableWidth / 2;

            return RefreshIndicator(
              onRefresh: () => _categoryController.fetchFarmlandSubCate(
                context,
                widget.subCategoryItem.categoryID ?? '',
                widget.subCategoryItem.subCategoryID ?? '',
                widget.subCategoryItem.hostID ?? '',
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Obx(() {
                  final response = _categoryController.farmLandSubcate.value;

                  if (response.status == Status.LOADING) {
                    return const Center(
                      child: CustomLoder(color: AppColors.primaryColor),
                    );
                  }

                  if (response.status == Status.ERROR) {
                    return const Center(child: Text("Something went wrong"));
                  }

                  final data = response.data?.data ?? [];
                  if (data.isEmpty) {
                    return const Center(child: Text("not Found data"));
                  }

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: List.generate(data.length, (index) {
                      final item = data[index];
                      return SizedBox(
                        width: itemWidth,
                        child: GestureDetector(
                          onTap: () => Get.to(
                            ProductDetailsPageWidget(
                              cattId: item.categoryID.toString(),
                              hostId: item.hostID.toString(),
                              subCatId: item.subCategoryID.toString(),
                              locationId: '',
                            ),
                          ),
                          child: categoryCard(
                            title: item.titleName,
                            host: '',
                            location: locationText,
                            buttonText: "View Details",
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
