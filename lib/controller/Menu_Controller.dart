import 'package:flutter/cupertino.dart';
import 'package:foodyore/Screens/Home/Menu/Menu_Item_Widget.dart';
import 'package:foodyore/data/response/api_response.dart';
import 'package:foodyore/model/Menu_Model.dart';
import 'package:foodyore/repository/menu_repo.dart';
import 'package:foodyore/res/app_urls.dart';
import 'package:foodyore/utils/app_utils.dart';
import 'package:get/get.dart';

class MenuItemController extends GetxController {
  final MenuRepo _menuRepo = MenuRepo();

  RxBool isLoading = false.obs;

  Rx<ApiResponse<MenuResponceModel>> menuItemData =
      ApiResponse<MenuResponceModel>.loading().obs;

  Future fetchAllMenuItems({
    required BuildContext context,
    required String categoryId,
    required String subCategoryId,
    required String hostId,
    required String locationId,
  }) async {
    try {
      menuItemData.value = ApiResponse.loading();

      final response = await _menuRepo.getMenuData(
        AppUrl.get_menu_urls(categoryId, subCategoryId, hostId, locationId),
      );

      menuItemData.value = ApiResponse.completed(response);
      Get.to(MenuItemWidget());
    } catch (e) {
      menuItemData.value = ApiResponse.error(e.toString());
      AppUtils.instance.snackBar("Error", e.toString(), true);
    }
  }
}
