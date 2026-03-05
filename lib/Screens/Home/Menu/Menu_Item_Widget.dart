// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Cart/cart_widget.dart';
import 'package:foodyore/Screens/Home/Menu/Menu_Card.dart';
import 'package:foodyore/controller/Menu_Controller.dart';
import 'package:foodyore/controller/cart_controller.dart';
import 'package:foodyore/controller/category_controller.dart';
import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/model/amenities_list_model.dart';
import 'package:foodyore/model/menu_model.dart';
import 'package:foodyore/res/app_urls.dart';
import 'package:foodyore/services/device_id_services.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_Loder.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_butoons.dart';
import 'package:foodyore/utils/helpers/Custom/custom_popup.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MenuItemWidget extends StatefulWidget {
  final String categoryId;
  final String subCategoryId;
  final String hostId;
  final String locationId;
  final String titleName;
  const MenuItemWidget({
    Key? key,
    required this.categoryId,
    required this.subCategoryId,
    required this.hostId,
    required this.locationId,
    required this.titleName,
  }) : super(key: key);

  @override
  State<MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  final MenuItemController _menuController = Get.put(MenuItemController());
  final CategoryController _categoryController = Get.put(CategoryController());
  final CartController _cartController = Get.put(CartController());
  @override
  void initState() {
    super.initState();
    getMenuData();
  }

  // for get menu data
  void getMenuData() async {
    await _menuController.fetchAllMenuItems(
      context: context,
      categoryId: widget.categoryId,
      subCategoryId: widget.subCategoryId,
      hostId: widget.hostId,
      locationId: widget.locationId,
    );
    await _categoryController.fetchAmenitiesData(
      context: context,
      catId: widget.categoryId,
      subCatId: widget.subCategoryId,
      hostId: widget.hostId,
      locationId: widget.locationId,
      userMachine: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppbar(title: 'MENU'),
      body: Obx(() {
        if (_menuController.menuItemData.value.status == Status.LOADING) {
          return Center(child: CustomLoder(color: AppColors.primaryColor));
        } else if (_menuController.menuItemData.value == Status.ERROR) {
          return Center(child: Text("Something went wrong"));
        } else {
          final menuData = _menuController.menuItemData.value.data!.data!;
          return RefreshIndicator(
            onRefresh: () async => getMenuData(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBreadcrumbs(menuData.first, widget.titleName),
                  const SizedBox(height: 20),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: menuData.length,
                    itemBuilder: (context, index) {
                      final item = menuData[index];
                      return MenuCard(menu: item);
                    },
                  ),

                  // const MenuCard(
                  //   image: 'assets/images/panner.jpg',
                  //   title: '2 Kg Paneer Unlimited Roti And Rice ',
                  // ),
                  // const SizedBox(height: 10),
                  // const MenuCard(
                  //   image: 'assets/images/mutton.jpg',
                  //   title: '1 Kg Mutton With Unlimited Roti Chawal Salad',
                  // ),
                  const SizedBox(height: 16),

                  /// SPECIAL ATTRACTIONS
                  _attractionRow(),

                  const SizedBox(height: 16),

                  // _sectionTitle('Other Special Attractions'),
                  const SizedBox(height: 6),
                  // _attractionRow([
                  //   _expectationCard(
                  //     image: 'assets/images/fire.jpg',
                  //     title: 'Birthday Party for couple',
                  //     amount: '25000',
                  //   ),
                  //   _expectationCard(
                  //     image: 'assets/images/boating.jpg',
                  //     title: 'Birthday Party (No Food)',
                  //     amount: '150',
                  //   ),
                  // ]),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          );
        }
      }),

      bottomSheet: Container(
        width: double.infinity,
        color: AppColors.backgroundColor,
        child: CustomButton(
          width: 200,
          color: AppColors.primaryColor,
          top: 10,
          bottom: 12,

          title: 'GO TO CART',
          onPressed: () {
            Get.to(CartWidget());
          },
        ),
      ),
    );
  }

  /// HELPERS

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _attractionRow() {
    return Obx(() {
      if (_categoryController.amenitiesData.value == Status.LOADING) {
        return const Center(child: CustomLoder(color: AppColors.primaryColor));
      } else if (_categoryController.amenitiesData.value == Status.ERROR ||
          _categoryController
              .amenitiesData
              .value
              .data!
              .amenitiesData!
              .isEmpty) {
        return const SizedBox();
      } else {
        final amenitiesData =
            (_categoryController.amenitiesData.value.data?.amenitiesData);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Add Special Attractions to Your Package'),
            const SizedBox(height: 6),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: amenitiesData!.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _expectationCard(
                      item: item,
                      image: AppUrl.baseUrl + (item.amenitieImage ?? ''),
                      title: item.amenitieType ?? '',
                      amount: item.price.toString(),
                      isInCart: item.alreadyAddedToCart ?? false,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      }
    });
  }

  Widget _buildBreadcrumbs(MenuItem menuData, String title) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _breadcrumbText(menuData.categoryName?.toUpperCase() ?? ''),
        _dot(),
        _breadcrumbText(menuData.subCategoryName?.toUpperCase() ?? ''),
        _dot(),
        _breadcrumbText(title.toUpperCase(), bold: true),
        _dot(),
        _breadcrumbText('BOOKING'),
      ],
    );
  }

  Widget _breadcrumbText(String text, {bool bold = false}) {
    return Text(
      text,
      style: AppTextStyles.caption.copyWith(
        color: AppColors.black,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _dot() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Icon(Icons.circle, size: 6),
  );

  Widget _expectationCard({
    required String image,
    required String title,
    required String amount,
    required bool isInCart,
    required AmenitiesData item,
  }) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            image,
            width: 160,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 160,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                  ),
                ),

                child: Icon(Iconsax.image_copy, color: AppColors.white),
              );
            },
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: isInCart != true
              ? InkWell(
                  onTap: () async {
                    final confirmed = await _showAddToCartConfirmation(context);
                    if (!confirmed) return;

                    await _cartController
                        .itemAddToCart(
                          itemId: item.amenitieId.toString(),
                          hostId: item.hostId.toString(),
                          locationId: item.locationId.toString(),
                          categoryId: item.categoryId ?? '',
                          subCategoryId: item.subCategoryId ?? '',
                          price: item.price.toString(),
                          itemDetails: item.amenitieType.toString(),
                          itemType: item.amenitieType.toString(),
                          quantity: item.unit.toString(),
                        )
                        .then((isAdd) async {
                          if (isAdd == true) {
                            final deviceId = await DeviceService.getDeviceId();
                            await _categoryController.fetchAmenitiesData(
                              context: context,
                              catId: widget.categoryId,
                              subCatId: widget.subCategoryId,
                              hostId: widget.hostId,
                              locationId: widget.locationId,
                              userMachine: deviceId,
                            );
                          }
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Add',
                      style: AppTextStyles.buttonText.copyWith(fontSize: 12),
                    ),
                  ),
                )
              : QtySelector(onIncrease: () {}, onDecrease: () {}),
        ),
        Positioned(
          bottom: 6,
          left: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₹$amount',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<bool> _showAddToCartConfirmation(BuildContext context) async {
  final completer = Completer<bool>();

  CustomPopup.show(
    context: context,
    title: 'Confirm',
    message: 'Do you want to add this item to cart?',
    cancelButtonText: 'No',
    submitButtonText: 'Yes',
    submitButtonColor: AppColors.primaryColor,
    onCancel: () {
      if (!completer.isCompleted) completer.complete(false);
    },
    onSubmit: () {
      if (!completer.isCompleted) completer.complete(true);
    },
  );

  return completer.future;
}

// for qty
class QtySelector extends StatelessWidget {
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const QtySelector({required this.onIncrease, required this.onDecrease});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.primaryColor, width: 1.2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onDecrease,
            child: Icon(Icons.remove, color: AppColors.primaryColor, size: 18),
          ),
          Text(
            ' 1 ',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.regular,
            ),
          ),
          GestureDetector(
            onTap: onIncrease,
            child: Icon(Icons.add, color: AppColors.primaryColor, size: 18),
          ),
        ],
      ),
    );
  }
}
