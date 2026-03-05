// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Cart/Widget/Cart_Item_card.dart';
import 'package:foodyore/controller/cart_controller.dart';
import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/model/cart_model.dart';
import 'package:foodyore/services/device_id_services.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_Loder.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_butoons.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_dottedline.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  bool isAllSelected = true;
  bool isItemSelected = true;
  final CartController _cartController = Get.put(CartController());
  @override
  void initState() {
    super.initState();
    getCartData();
  }

  void getCartData() async {
    await _cartController.fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppbar(title: 'Cart'),
      body: CustomBackground(
        child: RefreshIndicator(
          onRefresh: () async {
            getCartData();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Obx(() {
              if (_cartController.cartData.value.status == Status.LOADING) {
                return Center(
                  child: CustomLoder(color: AppColors.primaryColor),
                );
              } else if (_cartController.cartData.value.status ==
                  Status.ERROR) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(child: Text('Failed to load cart items')),
                );
              } else {
                final cartItems =
                    _cartController.cartData.value.data?.data ?? [];
                return Column(
                  spacing: 2,
                  children: [
                    SizedBox(height: 10),
                    _cartHeder(),
                    // for location discription
                    _LocationDiscription(),
                    // for cart items card
                    _cartItems(cartItems: cartItems),

                    // for coopan
                    _coopanSection(),
                    // for price biferfication
                    _priceBiferficationSection(
                      priceBreakup:
                          _cartController.cartData.value.data?.priceBreakup ??
                          PriceBreakup(),
                      totalItems: '${cartItems.length} ',
                    ),
                    SizedBox(height: 100),
                  ],
                );
              }
            }),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: AppColors.primaryColor),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Total Amount',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.backgroundColor,
                    ),
                  ),
                  Text(
                    '${AppContent().moneySymbol}290/-',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.white,
                      fontFamily: AppFonts.regular,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CustomButton(
                horizontal: 0,
                raduis: 8.0,
                color: AppColors.white,
                tittleColor: AppColors.primaryColor,
                title: 'Pay Now',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartHeder() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isAllSelected,
            activeColor: AppColors.primaryColor,
            onChanged: (value) {
              setState(() {
                isAllSelected = value!;
                isItemSelected = value;
              });
            },
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          ),
          Text(
            '2/2 ITEMS SELECTED ',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.black,
              fontFamily: AppFonts.regular,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              showCustomSnackBar(
                message: 'Clear all items from cart',
                isError: true,
              );
            },
            child: Icon(Iconsax.trash_copy, size: 22.0, color: AppColors.red),
          ),
        ],
      ),
    );
  }

  // for location discription
  Widget _LocationDiscription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(color: AppColors.white),
      child: Row(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Vilage',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.regular,
              fontSize: 11.0,
            ),
          ),
          Icon(Icons.circle, size: 6),
          Text(
            'Raja Itaunja Bahadurpur',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.regular,
              fontSize: 11.0,
            ),
          ),
          Icon(Icons.circle, size: 6),
          Text(
            'Raghvendra Singh',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.regular,
              fontSize: 11.0,
            ),
          ),
        ],
      ),
    );
  }

  // for cart items card
  Widget _cartItems({required List cartItems}) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return CartItemCard(
          isSelected: isItemSelected,
          onToggle: () {
            setState(() {
              isItemSelected = !isItemSelected;
            });
          },
          onIncrease: () {
            showCustomSnackBar(
              message: 'Increase item quantity',
              isError: false,
            );
          },
          onDecrease: () {
            showCustomSnackBar(
              message: 'Decrease item quantity',
              isError: false,
            );
          },
          onRemove: () {
            showCustomSnackBar(message: 'Item removed', isError: true);
          },
          cartItem: cartItems[index],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 2),
    );
  }

  // for coopan section
  Widget _coopanSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(color: AppColors.white),
      child: Row(
        spacing: 5,
        children: [
          Icon(
            Iconsax.ticket_2_copy,
            size: 16.0,
            color: AppColors.primaryColor,
          ),
          Text(
            '10 % Discount is avalible for your order',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.regular,
              color: const Color.fromARGB(255, 15, 117, 15),
              // fontSize: 11.0,
            ),
          ),
        ],
      ),
    );
  }

  // for price biferfication section
  Widget _priceBiferficationSection({
    required PriceBreakup priceBreakup,
    required String totalItems,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PRICE BREAKUP (${totalItems} ITEMS)',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Icon(
                Iconsax.info_circle_copy,
                size: 18,
                color: AppColors.primaryColor,
              ),
            ],
          ),
          Divider(color: AppColors.primaryColor.withOpacity(0.4)),
          // for total item price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Item Total',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontFamily: AppFonts.regular,
                  fontSize: 11,
                ),
              ),
              Text(
                '${AppContent().moneySymbol} ${priceBreakup.itemTotal ?? 0.0}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontFamily: AppFonts.regular,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          // for tax percantage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tax',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontFamily: AppFonts.regular,
                  fontSize: 11,
                ),
              ),
              Text(
                '${priceBreakup.taxPercent} %',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontFamily: AppFonts.regular,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          // total tax amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tax amount',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontFamily: AppFonts.regular,
                  fontSize: 11,
                ),
              ),
              Text(
                '${AppContent().moneySymbol} ${priceBreakup.taxAmount ?? 0.0}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontFamily: AppFonts.regular,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          // for discount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontFamily: AppFonts.regular,
                  fontSize: 11,
                ),
              ),
              Text(
                '${AppContent().moneySymbol} ${priceBreakup.discountAmount ?? 0.0}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontFamily: AppFonts.regular,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          CustomDottedDivider(color: AppColors.primaryColor.withOpacity(0.5)),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '${AppContent().moneySymbol} ${priceBreakup.totalAmount ?? 0.0}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontFamily: AppFonts.regular,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
