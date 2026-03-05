import 'dart:convert';

import 'package:foodyore/Auth/Controller/Auth_Controller.dart';
import 'package:foodyore/controller/cart_controller.dart';
import 'package:foodyore/repository/order_repo.dart';
import 'package:foodyore/res/app_urls.dart';
import 'package:foodyore/services/device_id_services.dart';
import 'package:foodyore/utils/app_utils.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final OrderRepo _orderRepo = OrderRepo();
  final AuthController _authController = Get.find<AuthController>();

  RxBool isPlacingOrder = false.obs;
/// PLACE ORDER
Future<void> placeOrder({
  required String paymentType,
  String? promoCode,
  String? visitTime,
}) async {
  try {
    print("========== PLACE ORDER STARTED ==========");
    print("Payment Type: $paymentType");
    print("Promo Code: $promoCode");
    print("Visit Time: $visitTime");
    
    isPlacingOrder.value = true;

    final deviceId = await DeviceService.getDeviceId();
    print("Device ID: $deviceId");
    
    // Check auth controller and profile response
    print("Auth Controller exists: ${_authController != null}");
    print("Profile Response value: ${_authController.profileResponse.value}");
    
    // Safe extraction with default values
    String customerId = '';
    String customerName = '';
    String mobile = '';
    String emailId = '';

    try {
      print("Attempting to extract user data...");
      
      // Check each level
      final profileResponse = _authController.profileResponse.value;
      print("Profile Response: $profileResponse");
      
      final profileData = profileResponse.data;
      print("Profile Data: $profileData");
      
      final user = profileData?.data;
      print("User object: $user");
      
      if (user != null) {
        print("User tableId: ${user.tableId}");
        print("User fullName: ${user.fullName}");
        print("User mobileNumber: ${user.mobileNumber}");
        print("User emailAddress: ${user.emailAddress}");
        
        customerId = user.tableId?.toString() ?? '';
        customerName = user.fullName ?? '';
        mobile = user.mobileNumber ?? '';
        emailId = user.emailAddress ?? '';
        
        print("Extracted values:");
        print("  customerId: '$customerId'");
        print("  customerName: '$customerName'");
        print("  mobile: '$mobile'");
        print("  emailId: '$emailId'");
      } else {
        print("User is NULL!");
      }
    } catch (e) {
      print("Error extracting user data: $e");
      print("Stack trace: ${StackTrace.current}");
    }

    // Prepare request body with fallback values
    Map<String, dynamic> body = {
      "userIp": "124324234", 
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

    print("========== FINAL REQUEST BODY ==========");
    print("Final Request Body: ${jsonEncode(body)}");
    print("========================================");

    print("Calling API: ${AppUrl.create_order_URL}");
    final response = await _orderRepo.postData(
      AppUrl.create_order_URL,
      body,
    );
    
    print("API Response: $response");

    isPlacingOrder.value = false;
    
    AppUtils.instance.snackBar(
      "Success", 
      response['message'] ?? "Order placed successfully", 
      false
    );
    
    // Refresh cart and navigate
    print("Refreshing cart...");
    final CartController _cartController = Get.find<CartController>();
    await _cartController.fetchCartItems();
    
    print("Navigating to home...");
    Get.offAllNamed('/home');
    
    print("========== PLACE ORDER COMPLETED ==========");
    
  } catch (e) {
    print("========== ERROR IN PLACE ORDER ==========");
    print("Error placing order: $e");
    print("Stack trace: ${StackTrace.current}");
    isPlacingOrder.value = false;
    AppUtils.instance.snackBar("Error", e.toString(), true);
  }
}


}