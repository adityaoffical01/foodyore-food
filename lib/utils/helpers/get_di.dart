

import 'package:foodyore/controller/home_gallery_controller.dart';
import 'package:get/get.dart';

Future<Map <String, Map<String , String >>> init() async{

  Get.lazyPut(()=>HomeGalleryController());
  
  Map <String , Map<String, String >> language = {};
  return language;
}