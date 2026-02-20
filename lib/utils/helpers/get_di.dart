import 'package:foodyore/Auth/Controller/Auth_Controller.dart';
import 'package:foodyore/controller/category_controller.dart';
import 'package:foodyore/controller/home_gallery_controller.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => CategoryController());
  Get.lazyPut(() => HomeGalleryController());

  Map<String, Map<String, String>> language = {};
  return language;
}
