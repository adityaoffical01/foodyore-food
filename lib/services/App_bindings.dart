import 'package:foodyore/Auth/Controller/Auth_Controller.dart'; 
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
