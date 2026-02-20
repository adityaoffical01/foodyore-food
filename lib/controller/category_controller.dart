import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodyore/data/response/api_response.dart';
import 'package:foodyore/model/category_model.dart';
import 'package:foodyore/repository/category_repo.dart';
import 'package:foodyore/res/app_urls.dart';
import 'package:foodyore/utils/app_utils.dart';

class CategoryController extends GetxController {
  final CategoryRepo _repo = CategoryRepo();

  Rx<ApiResponse<CategoryResponseModel>> categoryData =
      ApiResponse<CategoryResponseModel>.loading().obs;

  /// Fetch Category List
  Future<void> fetchCategories(BuildContext context) async {
    try {
      categoryData.value = ApiResponse.loading();

      final response = await _repo.getData(AppUrl.categroryUrls);

      categoryData.value = ApiResponse.completed(response);
    } catch (e) {
      categoryData.value = ApiResponse.error(e.toString());

      AppUtils.instance.snackBar("Error", e.toString(), true);
    }
  }
}
