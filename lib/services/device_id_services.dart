import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<String> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo =
            await _deviceInfo.androidInfo;

        return androidInfo.id; 

      }

      if (Platform.isIOS) {
        IosDeviceInfo iosInfo =
            await _deviceInfo.iosInfo;

        return iosInfo.identifierForVendor ?? '';
      }

      return "unknown_device";
    } catch (e) {
      return "unknown_device";
    }
  }
}