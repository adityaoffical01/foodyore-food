import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/shared_preference_util.dart';

class AuthService {}

String authToken = '';
var userInfo = {};
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
  print("========================token_value$authToken");
  return authToken;
}

Future logout() async {
  SharedPreferenceUtil.putBool(isLoginKey, false);
  // storeAuthToken('');
  return storeAuthToken('');
}

Future fetchAuthInfo() async {
  // localStorage ??= await SharedPreferences.getInstance();
  authToken = SharedPreferenceUtil.getString(tokenKey);

  // }
  return authToken;
}
