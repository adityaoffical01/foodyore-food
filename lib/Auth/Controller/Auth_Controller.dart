import 'package:foodyore/Auth/User_ragisteration_form.dart';
import 'package:foodyore/Screens/Home/Home_Screen.dart';
import 'package:foodyore/res/app_urls.dart';
import 'package:foodyore/services/app_config.dart';
import 'package:get/get.dart';
import 'package:foodyore/data/network/network_api_services.dart';
import 'package:foodyore/data/response/api_response.dart';
import 'package:foodyore/data/network/base_api_services.dart';

class AuthController extends GetxController {
  final BaseApiServices _apiServices = NetworkApiServices();

  var loginResponse = ApiResponse<dynamic>.loading().obs;
  var isOtpSending = false.obs;
  var isOtpVerifying = false.obs;

  // for get OTP
  Future initOTP(String phone) async {
    try {
      isOtpSending.value = true;

      Map<String, dynamic> data = {"mobileNumber": phone};

      final response = await _apiServices.postApi(data, AppUrl.initiate_otp);

      loginResponse.value = ApiResponse.completed(response);
      isOtpSending.value = false;
      if (loginResponse.value.data['success'] == true) {
        print('Login successful: ${response['message']}');
        return true;
      } else {
        loginResponse.value = ApiResponse.error(
          response['message'] ?? "OTP is getting failed",
        );
      }
    } catch (e) {
      loginResponse.value = ApiResponse.error("Something went wrong");
    }
  }

  // for vericaion of OTP
  Future<bool> verifyOTP({
    required String otp,
    required String mobileNumber,
  }) async {
    try {
      isOtpVerifying.value = true;
      final response = await _apiServices.postApi({
        "otpNumber": otp,
        "mobileNumber": mobileNumber,
      }, AppUrl.verify_otp);
      loginResponse.value = ApiResponse.completed(response);
      if (loginResponse.value.data['success'] == true) {
        if (loginResponse.value.data['nextStep'] == 'fill_registration_form') {
          Get.back();
          Get.to(UserRagisterationWidget(phoneNumber: mobileNumber));
        } else {
          storeAuthToken(loginResponse.value.data['user']['id'].toString());
          Get.offAll(HomeScreen());
        }
        return true;
      } else {
        loginResponse.value = ApiResponse.error(
          response['message'] ?? "OTP verification failed",
        );
        return false;
      }
    } catch (e) {
      loginResponse.value = ApiResponse.error("Something went wrong");
      return false;
    } finally {
      isOtpVerifying.value = false;
    }
  }
}
