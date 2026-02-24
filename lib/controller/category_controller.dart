import 'package:flutter/material.dart';
import 'package:foodyore/model/farm_land_subCate_model.dart';
import 'package:foodyore/model/sub_cate_model.dart';
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
  // fro sub category list
  Rx<ApiResponse<SubCategoryResponseModel>> subCategoryData =
      ApiResponse<SubCategoryResponseModel>.loading().obs;
  final RxBool isSubCategoryLoadingMore = false.obs;
  final RxBool hasMoreSubCategories = true.obs;
  final RxString nextSubCategoryCursor = ''.obs;
  final RxString selectedCategoryId = ''.obs;
  Rx<ApiResponse<FarmLandSubCategoryResponse>> farmLandSubcate =
      ApiResponse<FarmLandSubCategoryResponse>.loading().obs;

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

  // for sub category list
  Future<void> fetchSubCategories(
    BuildContext context,
    String categoryId, {
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (isSubCategoryLoadingMore.value || !hasMoreSubCategories.value) return;
      if (nextSubCategoryCursor.value.trim().isEmpty) return;
    } else {
      selectedCategoryId.value = categoryId;
      nextSubCategoryCursor.value = '';
      hasMoreSubCategories.value = true;
      subCategoryData.value = ApiResponse.loading();
    }

    try {
      if (loadMore) {
        isSubCategoryLoadingMore.value = true;
      }

      final response = await _repo.getSubCateData(
        AppUrl.subCategoryUrls(categoryId, nextSubCategoryCursor.value),
      );

      hasMoreSubCategories.value = response.pagination?.hasMore == true;
      nextSubCategoryCursor.value = response.pagination?.nextCursor ?? '';

      if (loadMore && subCategoryData.value.data?.data != null) {
        final existing = List<SubCategoryItem>.from(
          subCategoryData.value.data!.data!,
        );
        final incoming = response.data ?? <SubCategoryItem>[];
        final merged = <SubCategoryItem>[...existing];
        for (final item in incoming) {
          final alreadyExists = merged.any(
            (e) => e.subCategoryID == item.subCategoryID,
          );
          if (!alreadyExists) {
            merged.add(item);
          }
        }

        subCategoryData.value = ApiResponse.completed(
          SubCategoryResponseModel(
            success: response.success,
            data: merged,
            pagination: response.pagination,
          ),
        );
      } else {
        subCategoryData.value = ApiResponse.completed(response);
      }
    } catch (e) {
      if (!loadMore) {
        subCategoryData.value = ApiResponse.error(e.toString());
      }
      AppUtils.instance.snackBar("Error", e.toString(), true);
    } finally {
      if (loadMore) {
        isSubCategoryLoadingMore.value = false;
      }
    }
  }

  Future<void> fetchMoreSubCategories(BuildContext context) async {
    final String categoryId = selectedCategoryId.value.trim();
    if (categoryId.isEmpty) return;
    await fetchSubCategories(context, categoryId, loadMore: true);
  }

  // form land category data list
  Future<void> fetchFarmlandSubCate(
    BuildContext context,
    String cateID,
    subCateID,
    hostId,
  ) async {
    try {
      farmLandSubcate.value = ApiResponse.loading();

      final response = await _repo.getFarmlandCateData(
        AppUrl.sub_sub_category(cateID, subCateID, hostId),
      );

      farmLandSubcate.value = ApiResponse.completed(response);
    } catch (e) {
      farmLandSubcate.value = ApiResponse.error(e.toString());

      AppUtils.instance.snackBar("Error", e.toString(), true);
    }
  }
}
