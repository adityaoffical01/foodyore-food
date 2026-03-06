
import 'package:foodyore/Auth/Controller/Auth_Controller.dart';
import 'package:foodyore/controller/cart_controller.dart';
import 'package:foodyore/data/response/api_response.dart';
import 'package:foodyore/model/Order_details_Model.dart';
import 'package:foodyore/model/order_model.dart';
import 'package:foodyore/repository/order_repo.dart';
import 'package:foodyore/res/app_urls.dart';
import 'package:foodyore/services/device_id_services.dart';
import 'package:foodyore/utils/app_utils.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final OrderRepo _orderRepo = OrderRepo();
  final AuthController _authController = Get.find<AuthController>();

  RxBool isPlacingOrder = false.obs;
  RxBool isOrderHistoryLoading = false.obs;
  RxBool isOrderDetailsLoading = false.obs;

  Rx<ApiResponse<OrderListResponseModel>> orderHistoryData =
      ApiResponse<OrderListResponseModel>.loading().obs;
  Rx<ApiResponse<OrderDetailsResponseModel>> orderDetailsData =
      ApiResponse<OrderDetailsResponseModel>.loading().obs;

  String _loggedInCustomerId() {
    try {
      final user = _authController.profileResponse.value.data?.data;
      return user?.tableId?.toString() ?? '';
    } catch (_) {
      return '';
    }
  }

  /// GET ORDER HISTORY LIST
  Future<void> fetchOrderHistory({String? customerId}) async {
    if (isOrderHistoryLoading.value) return;

    final String resolvedCustomerId =
        (customerId != null && customerId.trim().isNotEmpty)
        ? customerId.trim()
        : _loggedInCustomerId();

    if (resolvedCustomerId.isEmpty) {
      orderHistoryData.value = ApiResponse.error(
        'Customer ID not found for order history',
      );
      return;
    }

    isOrderHistoryLoading.value = true;
    orderHistoryData.value = ApiResponse.loading();

    try {
      final response = await _orderRepo.getOrderHistory(
        AppUrl.get_order_history_URL(resolvedCustomerId),
      );
      orderHistoryData.value = ApiResponse.completed(response);
      print('aditya_order_history_response: ${response.toJson()}');
    } catch (e) {
      orderHistoryData.value = ApiResponse.error(e.toString());
    } finally {
      isOrderHistoryLoading.value = false;
    }
  }

  /// GET ORDER DETAILS
  Future<void> fetchOrderDetails({required String orderId}) async {
    if (isOrderDetailsLoading.value) return;

    final String resolvedOrderId = orderId.trim();

    if (resolvedOrderId.isEmpty) {
      orderDetailsData.value = ApiResponse.error(
        'Order ID is required for order details',
      );
      return;
    }

    isOrderDetailsLoading.value = true;
    orderDetailsData.value = ApiResponse.loading();

    try {
      final response = await _orderRepo.getOrderDetails(
        AppUrl.get_order_details_URL(resolvedOrderId),
      );
      orderDetailsData.value = ApiResponse.completed(response);
      print('aditya_order_details_response: ${response.toJson()}');
    } catch (e) {
      orderDetailsData.value = ApiResponse.error(e.toString());
    } finally {
      isOrderDetailsLoading.value = false;
    }
  }

  /// PLACE ORDER
  Future<void> placeOrder({
    required String paymentType,
    String? promoCode,
    String? visitTime,
  }) async {
    try {
      isPlacingOrder.value = true;

      final deviceId = await DeviceService.getDeviceId();

      // Check auth controller and profile response

      // Safe extraction with default values
      String customerId = '';
      String customerName = '';
      String mobile = '';
      String emailId = '';

      try {
        // Check each level
        final profileResponse = _authController.profileResponse.value;

        final profileData = profileResponse.data;

        final user = profileData?.data;

        if (user != null) {
          customerId = user.tableId?.toString() ?? '';
          customerName = user.fullName ?? '';
          mobile = user.mobileNumber ?? '';
          emailId = user.emailAddress ?? '';
        } else {}
      } catch (e) {}

      // Prepare request body with fallback values
      Map<String, dynamic> body = {
        "userIp": "",
        "userMachine": deviceId,
        "customerId": customerId.isEmpty ? '0' : customerId,
        "customerName": customerName.isEmpty ? 'Guest' : customerName,
        "mobile": mobile.isEmpty ? '0000000000' : mobile,
        "emailId": emailId.isEmpty ? 'guest@example.com' : emailId,
        "paymentType": paymentType,
        "visitTime": visitTime ?? "",
        "promoCode": "",
        "custType": "user",
      };

      final response = await _orderRepo.postData(AppUrl.create_order_URL, body);

      isPlacingOrder.value = false;

      AppUtils.instance.snackBar(
        "Success",
        response['message'] ?? "Order placed successfully",
        false,
      );

      // Refresh cart and navigate
      final CartController _cartController = Get.find<CartController>();
      await _cartController.fetchCartItems();

      Get.offAllNamed('/home');
    } catch (e) {
      isPlacingOrder.value = false;
      AppUtils.instance.snackBar("Error", e.toString(), true);
    }
  }
}
