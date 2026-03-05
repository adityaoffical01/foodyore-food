// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodyore/controller/cart_controller.dart';
import 'package:foodyore/model/menu_model.dart';
import 'package:foodyore/res/app_urls.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_Loder.dart';
import 'package:foodyore/utils/helpers/Custom/custom_popup.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MenuCard extends StatelessWidget {
  final MenuItem menu;
  MenuCard({super.key, required this.menu});
  final CartController _cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ).copyWith(bottom: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    AppUrl.baseUrl + (menu.itemImage ?? ''),
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 80,
                        width: 80,
                        color: AppColors.textHintColor.withOpacity(0.2),
                        child: Icon(Iconsax.image_copy, color: AppColors.grey),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: Builder(
                    builder: (_) {
                      final int totalPrice = menu.price ?? 0;
                      final int guestCount =
                          int.tryParse(menu.numberOfGuest ?? '0') ?? 0;

                      final int perPerson = guestCount > 0
                          ? (totalPrice ~/ guestCount)
                          : 0;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menu.itemDetails ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 6),

                          /// PERFECT ALIGNMENT TABLE
                          Table(
                            columnWidths: const {
                              0: FlexColumnWidth(),
                              1: FlexColumnWidth(),
                              2: FlexColumnWidth(),
                            },
                            children: [
                              TableRow(
                                children: [
                                  InfoColumn(
                                    title: 'MENU TYPE',
                                    value: menu.itemType?.capitalize ?? '',
                                  ),
                                  InfoColumn(
                                    title: 'PACKAGE',
                                    value: menu.menuType?.capitalize ?? '',
                                  ),
                                  InfoColumn(
                                    title: 'NO. OF GUESTS',
                                    value: menu.numberOfGuest ?? '',
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  SizedBox(height: 6),
                                  SizedBox(height: 6),
                                  SizedBox(height: 6),
                                ],
                              ),
                              TableRow(
                                children: [
                                  InfoColumn(
                                    title: 'TOTAL',
                                    value:
                                        '₹${menu.price} (min. ${menu.numberOfGuest ?? ''})',
                                  ),
                                  InfoColumn(
                                    title: 'PER PERSON',
                                    value: '₹${perPerson}',
                                  ),
                                  SizedBox(),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          // _addToCartButton(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final confirmed = await _showAddToCartConfirmation(context);
              if (!confirmed) return;

              await _cartController.itemAddToCart(
                itemId: menu.itemID.toString(),
                hostId: menu.hostID.toString(),
                locationId: menu.locationID.toString(),
                categoryId: menu.categoryID ?? '',
                subCategoryId: menu.subCategoryID ?? '',
                price: menu.price.toString(),
                itemDetails: menu.itemDetails ?? '',
                itemType: menu.itemType.toString(),
                quantity: menu.quantity.toString(),
              );
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  'ADD TO CART',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

  // Widget _addToCartButton() {
  //   return Container(
  //     // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     decoration: BoxDecoration(
  //       color: AppColors.primaryColor,
  //       borderRadius: BorderRadius.circular(44),
  //     ),
  //     child: Text(
  //       'ADD TO CART',
  //       style: AppTextStyles.caption.copyWith(
  //         color: AppColors.white,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  // }
}

// for info column
class InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const InfoColumn({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.caption.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
