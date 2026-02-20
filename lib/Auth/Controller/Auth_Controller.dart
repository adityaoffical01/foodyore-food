import 'package:foodyore/Auth/User_ragisteration_form.dart';
import 'package:foodyore/Screens/Home/Home_Screen.dart';
import 'package:foodyore/services/app_config.dart';
import 'package:get/get.dart';
import 'package:foodyore/data/response/api_response.dart';
import 'package:foodyore/repository/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo _authRepo = AuthRepo();

  var loginResponse = ApiResponse<dynamic>.loading().obs;
  var isOtpSending = false.obs;
  var isOtpVerifying = false.obs;

  // 🔹 Get OTP
  Future<bool> initOTP(String phone) async {
    try {
      isOtpSending.value = true;

      final response = await _authRepo.initiateOtp(phone);

      loginResponse.value = ApiResponse.completed(response);

      if (loginResponse.value.data['success'] == true) {
        return true;
      } else {
        loginResponse.value = ApiResponse.error(
          response['message'] ?? "OTP failed",
        );
        return false;
      }
    } catch (e) {
      loginResponse.value = ApiResponse.error("Something went wrong");
      return false;
    } finally {
      isOtpSending.value = false;
    }
  }

  // 🔹 Verify OTP
  Future<bool> verifyOTP({
    required String otp,
    required String mobileNumber,
  }) async {
    try {
      isOtpVerifying.value = true;

      final response = await _authRepo.verifyOtp(
        otp: otp,
        mobileNumber: mobileNumber,
      );

      loginResponse.value = ApiResponse.completed(response);

      if (loginResponse.value.data['success'] == true) {
        if (loginResponse.value.data['nextStep'] == 'fill_registration_form') {
          Get.back();
          Get.to(
            UserRagisterationWidget(
              phoneNumber: mobileNumber,
              verificationId: loginResponse.value.data['verificationId'],
            ),
          );
        } else {
          storeAuthToken(loginResponse.value.data['token'].toString());
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

  // for user ragistration
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required String verificationId,
    required String phone,
    String? gender,
    String? alternateNumber,
    String? alternateName,
    String? occupation,
    String? maritalStatus,
    String? dateOfBirth,
    String? address,
    String? country,
    String? state,
    String? city,
  }) async {
    try {
      isOtpSending.value = true;
      final response = await _authRepo.registerUser(
        name: name,
        email: email,
        password: password,
        gender: gender,
        alternateName: alternateName,
        alternateNumber: alternateNumber,
        occupation: occupation,
        maritalStatus: maritalStatus,
        dateOfBirth: dateOfBirth,
        address: address,
        country: country,
        state: state,
        city: city,
        verificationId: verificationId,
        phone: phone,
      );
      isOtpSending.value = false;
      if (response['success'] == true) {
        storeAuthToken(response['token'].toString());
        return true;
      } else {
        Get.snackbar("Registration Failed", response['message'] ?? "Error");
        return false;
      }
    } catch (e) {
      isOtpSending.value = false;
      print("Registration Error: $e");
      Get.snackbar("Error", "Something went wrong");
      return false;
    }
  }
}
