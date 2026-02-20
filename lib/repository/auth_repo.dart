import 'package:foodyore/data/network/network_api_services.dart';
import 'package:foodyore/res/app_urls.dart';

class AuthRepo {
  final _apiService = NetworkApiServices();

  // Initiate OTP
  Future<dynamic> initiateOtp(String phone) async {
    Map<String, dynamic> data = {"mobileNumber": phone};

    dynamic response = await _apiService.postApi(data, AppUrl.initiate_otp);

    return response;
  }

  // Verify OTP
  Future<dynamic> verifyOtp({
    required String otp,
    required String mobileNumber,
  }) async {
    Map<String, dynamic> data = {
      "otpNumber": otp,
      "mobileNumber": mobileNumber,
    };

    dynamic response = await _apiService.postApi(data, AppUrl.verify_otp);

    return response;
  }

  // for user ragisteration
  Future<dynamic> registerUser({
    required String name,
    required String email,
    required String password,
    required String verificationId,
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
    Map<String, dynamic> data = {
      "fullName": name,
      "emailAddress": email,
      "password": password,
      "gender": gender ?? '',
      "alternateNumber": alternateNumber ?? '',
      "alternateName": alternateName ?? '',
      "occupation": occupation ?? '',
      "maritalStatus": maritalStatus ?? '',
      "dateOfBirth": dateOfBirth ?? '',
      "address": address ?? '',
      "country": country ?? '1',
      "state": state ?? '1',
      "city": city ?? '1',
      "mobileNumber": phone,
      "verificationId": verificationId,
    };

    dynamic response = await _apiService.postApi(data, AppUrl.register_user);

    return response;
  }
}
