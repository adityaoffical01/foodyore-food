

import 'package:foodyore/data/response/api_response.dart';
import 'package:foodyore/model/cart_model.dart';
import 'package:foodyore/repository/cart_repo.dart';
import 'package:foodyore/res/app_urls.dart';
import 'package:foodyore/services/device_id_services.dart';
import 'package:foodyore/utils/app_utils.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo _cartRepo = CartRepo();

  RxBool isLoading = false.obs;

  Rx<ApiResponse<CartResponseModel>> cartData =
      ApiResponse<CartResponseModel>.loading().obs;

  //  for get cart
  Future<void> fetchCartItems() async {
    if (isLoading.value) return;

  isLoading.value = true;
  cartData.value = ApiResponse.loading();
    cartData.value = ApiResponse.loading();
    final deviceId = await DeviceService.getDeviceId();
    print('aditya_device_id: ${deviceId}');
    try {
      final response = await _cartRepo.getCartItems(
        AppUrl.get_cart_urls(deviceId),
      );
      cartData.value = ApiResponse.completed(response);
    } catch (e) {
      cartData.value = ApiResponse.error(e.toString());
    }finally {
  isLoading.value = false;
}
  }

  /// ADD TO CART
  Future itemAddToCart({
    required String itemType,
    required String itemId,
    required String quantity,
    required String hostId,
    required String locationId,
    required String categoryId,
    required String subCategoryId,
    required String price,
    required String itemDetails,
  }) async {
    try {
      final deviceId = await DeviceService.getDeviceId();

      isLoading.value = true;

      Map<String, dynamic> body = {
        "itemType": itemType,
        "itemId": itemId,
        "quantity": quantity,
        "hostId": hostId,
        "locationId": locationId,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "price": price,
        "userIp": "",
        "userMachine": deviceId,
        "itemDetails": itemDetails,
      };

      final response = await _cartRepo.postData(AppUrl.cart_URL, body);
      isLoading.value = false;
      await fetchCartItems();
      AppUtils.instance.snackBar("Successful", response['message'], false);
      return true;
    } catch (e) {
      isLoading.value = false;
      AppUtils.instance.snackBar("Error", e.toString(), true);
    } finally {
      isLoading.value = false;
    }
  }

  /// UPDATE CART ITEM QUANTITY (INCREMENT/DECREMENT)
  Future<void> updateCartItemQuantity({
    required String cartItemId,
    required int newQuantity,
  }) async {
    if (isLoading.value) return;
    try {
      if (newQuantity < 1) {
        // If quantity becomes 0, remove the item
        await removeCartItem(cartItemId: cartItemId.toString());
        return;
      }

      isLoading.value = true;
      final deviceId = await DeviceService.getDeviceId();

      Map<String, dynamic> body = {
        "quantity": newQuantity.toString(),
      };

      // URL: https://foodyore.apsinghdev.in/api/cart/{cartItemId}?userIp=&userMachine=deviceId
      final String url = '${AppUrl.put_cart_URL}$cartItemId?userIp=&userMachine=$deviceId';
      
      await _cartRepo.putData(url, body);

      isLoading.value = false;
      await fetchCartItems(); // Refresh cart after update
      AppUtils.instance.snackBar("Success", "Cart updated successfully", false);
    } catch (e) {
      isLoading.value = false;
      AppUtils.instance.snackBar("Error", e.toString(), true);
    }
  }

  /// REMOVE SINGLE CART ITEM
  Future<void> removeCartItem({required String cartItemId}) async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;
      final deviceId = await DeviceService.getDeviceId();

      // URL: https://foodyore.apsinghdev.in/api/cart/{cartItemId}?userIp=&userMachine=deviceId
      final String url = '${AppUrl.remove_cart_URL}$cartItemId';

      await _cartRepo.deleteData(url);

      isLoading.value = false;
      await fetchCartItems(); // Refresh cart after removal
      AppUtils.instance.snackBar("Removed", "Item removed from cart", false);
    } catch (e) {
      isLoading.value = false;
      AppUtils.instance.snackBar("Error", e.toString(), true);
    }
  }

  /// CLEAR ENTIRE CART
  Future<void> clearCart() async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;
      final deviceId = await DeviceService.getDeviceId();
  final cartItems = cartData.value.data?.data ?? [];
    
    if (cartItems.isEmpty) {
      isLoading.value = false;
      AppUtils.instance.snackBar("Info", "Cart is already empty", false);
      return;
    }

    // Extract all cart IDs
    final List<String> cartItemIds = cartItems
        .map((item) => item.cartId.toString())
        .where((id) => id.isNotEmpty)
        .toList();

    // Join IDs with commas for URL
    final String idsParam = cartItemIds.join(',');
      // URL: https://foodyore.apsinghdev.in/api/cart/clear?userIp=&userMachine=deviceId
      final String url = '${AppUrl.remove_cart_URL}$idsParam';

      await _cartRepo.deleteData(url);

      isLoading.value = false;
      await fetchCartItems(); // Refresh cart after clearing
      AppUtils.instance.snackBar("Success", "Cart cleared successfully", false);
    } catch (e) {
      isLoading.value = false;
      AppUtils.instance.snackBar("Error", e.toString(), true);
    }
  }
}
