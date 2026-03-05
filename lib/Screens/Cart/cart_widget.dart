

import 'package:flutter/material.dart';
import 'package:foodyore/Auth/Controller/Auth_Controller.dart';
import 'package:foodyore/Screens/Cart/Widget/Cart_Item_card.dart';
import 'package:foodyore/controller/cart_controller.dart';
import 'package:foodyore/controller/order_controller.dart';
import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/model/cart_model.dart';
import 'package:foodyore/services/app_config.dart';
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
  final CartController _cartController = Get.isRegistered<CartController>()
      ? Get.find<CartController>()
      : Get.put(CartController());
  final OrderController _orderController = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        getCartData();
        Get.find<AuthController>().getProfile(userId);
      }
    });
  }

  Future<void> getCartData() async => _cartController.fetchCartItems();

  // Update select all functionality
  void _updateSelectAll(bool? value) {
    setState(() {
      isAllSelected = value ?? false;
      isItemSelected = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppbar(title: 'Cart'),
      body: CustomBackground(
        child: RefreshIndicator(
          onRefresh: () async {
            await getCartData();
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
                final selectedCount = isAllSelected ? cartItems.length : (isItemSelected ? 1 : 0);
                
                return Column(
                  spacing: 2,
                  children: [
                    SizedBox(height: 10),
                    _cartHeder(selectedCount: selectedCount, totalItems: cartItems.length),
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
   bottomSheet: Obx(() {
  final total = _cartController
          .cartData.value.data?.priceBreakup?.totalAmount ??
      0;
 
  // Check if cart is empty
  final cartItems = _cartController.cartData.value.data?.data ?? [];
  final bool isCartEmpty = cartItems.isEmpty;

  return Container(
    height: 80,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(color: AppColors.primaryColor),
    child: Row(
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
                '${AppContent().moneySymbol}$total/-',
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
          child: _orderController.isPlacingOrder.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                )
              : CustomButton(
                  horizontal: 0,
                  raduis: 8.0,
                  color: isCartEmpty 
                      ? AppColors.grey.withOpacity(0.5) 
                      : AppColors.white,
                  tittleColor: isCartEmpty 
                      ? AppColors.white 
                      : AppColors.primaryColor,
                  title: 'Pay Now',
                  onPressed: isCartEmpty 
                      ? (){} 
                      : () {
                          _showPaymentOptionsDialog();
                        },
                ),
        ),
      ],
    ),
  );
}),);
  }
void _showPaymentOptionsDialog() {
  Get.dialog(
    AlertDialog(
      title: Text('Select Payment Method'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.payment, color: AppColors.primaryColor),
            title: Text('Online Payment'),
            onTap: () {
              Get.back();
              _placeOrder(paymentType: 'Online');
            },
          ),
          ListTile(
            leading: Icon(Icons.money, color: AppColors.primaryColor),
            title: Text('Cash on Delivery'),
            onTap: () {
              Get.back();
              _placeOrder(paymentType: 'COD');
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel'),
        ),
      ],
    ),
  );
}

// Place order method
void _placeOrder({required String paymentType}) {
  _orderController.placeOrder(
    paymentType: paymentType,
    promoCode: '', // Empty as per requirement
    visitTime: '', // Optional
  );
}
  Widget _cartHeder({required int selectedCount, required int totalItems}) {
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
            onChanged: _updateSelectAll,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          ),
          Text(
            '$selectedCount/$totalItems ITEMS SELECTED ',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.black,
              fontFamily: AppFonts.regular,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              _showClearCartDialog();
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
        final item = cartItems[index];
        return CartItemCard(
          isSelected: isItemSelected,
          onToggle: () {
            setState(() {
              isItemSelected = !isItemSelected;
              if (!isItemSelected) {
                isAllSelected = false;
              }
            });
          },
          onIncrease: () {
              int currentQty = item.quantity ?? 1;
            _cartController.updateCartItemQuantity(
              cartItemId: item.cartId.toString(),
              newQuantity: currentQty + 1,
            );
          },
          onDecrease: () {
             int currentQty = item.quantity ?? 1;
            if (currentQty > 1) {
              _cartController.updateCartItemQuantity(
                cartItemId: item.cartId.toString(),
                newQuantity: currentQty - 1,
              );
            } else {
              // If quantity is 1, remove the item on decrease
              _showRemoveItemDialog(item.cartId.toString());
            }
          },
          onRemove: () {
            _showRemoveItemDialog(item.cartId.toString());
          },
          cartItem: item,
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

  // Show dialog for removing single item
  void _showRemoveItemDialog(String cartItemId) {
    print("object");
     if (_cartController.isLoading.value) return;

  if (Get.isDialogOpen ?? false) {
    Get.back();
  }

    Get.dialog(
      AlertDialog(
        title: Text('Remove Item'),
        content: Text('Are you sure you want to remove this item?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _cartController.removeCartItem(cartItemId: cartItemId);
              Get.back();

            },
            child: Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Show dialog for clearing entire cart
  void _showClearCartDialog() {
    if (Get.isDialogOpen ?? false) return;
    if (_cartController.isLoading.value) return;
    Get.dialog(
      AlertDialog(
        title: Text('Clear Cart'),
        content: Text('Are you sure you want to clear all items?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await _cartController.clearCart();
            },
            child: Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
