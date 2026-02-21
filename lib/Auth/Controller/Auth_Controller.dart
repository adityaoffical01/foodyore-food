import 'package:foodyore/Auth/User_ragisteration_form.dart';
import 'package:foodyore/Screens/Home/Home_Screen.dart';
import 'package:foodyore/model/profile_model.dart';
import 'package:foodyore/services/app_config.dart';
import 'package:get/get.dart';
import 'package:foodyore/data/response/api_response.dart';
import 'package:foodyore/repository/auth_repo.dart';
import 'package:foodyore/utils/app_utils.dart';

class AuthController extends GetxController {
  final AuthRepo _authRepo = AuthRepo();

  var loginResponse = ApiResponse<dynamic>.loading().obs;
  var profileResponse = ApiResponse<UserProfileResponseModel>.loading().obs;
  var userProfile = Rxn<UserData>();
  var currentUserId = ''.obs;
  var isOtpSending = false.obs;
  var isOtpVerifying = false.obs;
  var isProfileLoading = false.obs;
  var isProfileUpdating = false.obs;

  @override
  void onInit() {
    super.onInit();
    final String savedUserId = getUserId();
    if (savedUserId.trim().isNotEmpty) {
      currentUserId.value = savedUserId;
      getProfile(savedUserId);
    }
  }

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
          final token = loginResponse.value.data['token']?.toString();
          if (token != null && token.isNotEmpty && token != 'null') {
            storeAuthToken(token);
          }
          final String id = loginResponse.value.data['user']['id'].toString();
          storeUserId(id);
          currentUserId.value = id;
          await getProfile(id);
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
        final token = response['token']?.toString();
        if (token != null && token.isNotEmpty && token != 'null') {
          storeAuthToken(token);
        }
        final String id = response['user']['id'].toString();
        storeUserId(id);
        currentUserId.value = id;
        await getProfile(id);
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

  // for get profile
  Future<bool> getProfile(String userId) async {
    if (userId.trim().isEmpty) {
      return false;
    }
    try {
      isProfileLoading.value = true;
      profileResponse.value = ApiResponse.loading();

      final response = await _authRepo.getProfile(userId);
      profileResponse.value = ApiResponse.completed(response);

      if (response.success == true && response.data != null) {
        userProfile.value = response.data;
        return true;
      }

      final message = 'Unable to fetch profile';
      profileResponse.value = ApiResponse.error(message);
      AppUtils.instance.snackBar("Error", message, true);
      return false;
    } catch (e) {
      final message = e.toString();
      profileResponse.value = ApiResponse.error(message);
      AppUtils.instance.snackBar("Error", message, true);
      return false;
    } finally {
      isProfileLoading.value = false;
    }
  }

  Future<bool> updateProfile({
    required String userId,
    required String name,
    required String email,
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
    String? phone,
  }) async {
    if (userId.trim().isEmpty) {
      AppUtils.instance.snackBar("Error", "User id is missing", true);
      return false;
    }

    try {
      isProfileUpdating.value = true;
      final response = await _authRepo.updateProfile(
        userId: userId,
        name: name,
        email: email,
        gender: gender,
        alternateNumber: alternateNumber,
        alternateName: alternateName,
        occupation: occupation,
        maritalStatus: maritalStatus,
        dateOfBirth: dateOfBirth == null || dateOfBirth.trim().isEmpty
            ? ''
            : AppUtils.instance.normalizeToYMD(dateOfBirth),
        address: address,
        country: country,
        state: state,
        city: city,
        phone: phone,
      );

      if (response['success'] == true) {
        AppUtils.instance.snackBar(
          "Success",
          response['message'] ?? "Profile updated successfully",
          false,
        );
        await getProfile(userId);

        return true;
      }

      AppUtils.instance.snackBar(
        "Error",
        response['message'] ?? "Profile update failed",
        true,
      );
      return false;
    } catch (e) {
      AppUtils.instance.snackBar("Error", e.toString(), true);
      return false;
    } finally {
      isProfileUpdating.value = false;
    }
  }
}
