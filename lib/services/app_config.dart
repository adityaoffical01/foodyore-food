import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/shared_preference_util.dart';

class AuthService {}

String authToken = '';
String userId = '';
// SharedPreferences? localStorage;

/// set auth token for the later user
void storeAuthToken(String authToken) async {
  // localStorage ??= await SharedPreferences.getInstance();
  print("========================Storetoken $authToken");
  SharedPreferenceUtil.putString(tokenKey, authToken);
  getAuthToken();
}

String getAuthToken() {
  fetchAuthInfo();
  getUserId();
  print("========================token_value$authToken");
  return authToken;
}

/// set user id for later use
void storeUserId(String userIdValue) async {
  SharedPreferenceUtil.putString('userId', userIdValue);
  getUserId();
}

String getUserId() {
  fetchUserInfo();
  return userId;
}

Future logout() async {
  SharedPreferenceUtil.putBool(isLoginKey, false);
  storeUserId('');
  // storeAuthToken('');
  return storeAuthToken('');
}

Future fetchAuthInfo() async {
  // localStorage ??= await SharedPreferences.getInstance();
  authToken = SharedPreferenceUtil.getString(tokenKey);

  // }
  return authToken;
}

Future fetchUserInfo() async {
  userId = SharedPreferenceUtil.getString('userId');
  return userId;
}
