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
}
