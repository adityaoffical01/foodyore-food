import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:foodyore/data/response/api_response.dart';
import 'package:foodyore/data/response/api_status.dart';

import 'package:foodyore/model/category_model.dart';
import 'package:foodyore/model/sub_cate_model.dart';
import 'package:foodyore/model/farm_land_subCate_model.dart';
import 'package:foodyore/model/PDP_model.dart';
import 'package:foodyore/model/amenities_list_model.dart';
import 'package:foodyore/model/host_descripetions_model.dart';

import 'package:foodyore/repository/category_repo.dart';
import 'package:foodyore/repository/host_repo.dart';

import 'package:foodyore/res/app_urls.dart';
import 'package:foodyore/utils/app_utils.dart';

class CategoryController extends GetxController {
  final CategoryRepo _repo = CategoryRepo();
  final HostRepo _hostRepo = HostRepo();

  Rx<Status> pdpStatus = Status.LOADING.obs;
  RxBool isPdpLoading = false.obs;

  Rx<PdpCommonModel> pdpData = const PdpCommonModel().obs;

  PdpCommonModel _mapToCommonModel(HostDescription host, Location? location) {
    return PdpCommonModel(
      title: host.descriptionTitle,
      description: host.description,
      categoryName: host.categoryName,
      subCategoryName: host.subCategoryName,
      hostName: host.hostName,
      mobile: host.hostMobile,
      email: host.hostEmail,
      address:
          host.hostAddress ?? ((host.address1 ?? '') + (host.address2 ?? '')),
      images: host.imageUploads,
      city: location?.cityName ?? host.cityName,
      state: location?.stateName ?? host.stateName,
      country: location?.countryName ?? host.countryName,
      pinCode: location?.pinCode ?? host.pinCode,
      latitude: location?.latitude ?? host.latitude.toString(),
      longitude: location?.longitude ?? host.longitude.toString(),
      locationId: location?.locationId ?? host.locationId.toString(),
    );
  }

  /* =========================================================
      CATEGORY LIST
  ========================================================== */

  Rx<ApiResponse<CategoryResponseModel>> categoryData =
      ApiResponse<CategoryResponseModel>.loading().obs;

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

  /* =========================================================
      SUB CATEGORY LIST (WITH PAGINATION)
  ========================================================== */

  Rx<ApiResponse<SubCategoryResponseModel>> subCategoryData =
      ApiResponse<SubCategoryResponseModel>.loading().obs;

  final RxBool isSubCategoryLoadingMore = false.obs;
  final RxBool hasMoreSubCategories = true.obs;
  final RxString nextSubCategoryCursor = ''.obs;
  final RxString selectedCategoryId = ''.obs;

  Future<void> fetchSubCategories(
    BuildContext context,
    String categoryId, {
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (isSubCategoryLoadingMore.value ||
          !hasMoreSubCategories.value ||
          nextSubCategoryCursor.value.trim().isEmpty) {
        return;
      }
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

        final incoming = response.data ?? [];

        for (final item in incoming) {
          if (!existing.any((e) => e.subCategoryID == item.subCategoryID)) {
            existing.add(item);
          }
        }

        subCategoryData.value = ApiResponse.completed(
          SubCategoryResponseModel(
            success: response.success,
            data: existing,
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
    final categoryId = selectedCategoryId.value.trim();
    if (categoryId.isEmpty) return;

    await fetchSubCategories(context, categoryId, loadMore: true);
  }

  /* =========================================================
      FARM LAND SUB CATEGORY
  ========================================================== */

  Rx<ApiResponse<FarmLandSubCategoryResponse>> farmLandSubcate =
      ApiResponse<FarmLandSubCategoryResponse>.loading().obs;

  Future fetchFarmlandSubCate({
    required BuildContext context,
    required String subCateID,
    required String cateID,
    required String hostId,
  }) async {
    try {
      farmLandSubcate.value = ApiResponse.loading();

      final response = await _repo.getFarmlandCateData(
        AppUrl.sub_sub_category(cateID, subCateID, hostId),
      );

      farmLandSubcate.value = ApiResponse.completed(response);
      if (response.data.isNotEmpty) {
        final host = response.data.first;

        pdpData.value = _mapToCommonModel(host, null);
      }
      return true;
    } catch (e) {
      farmLandSubcate.value = ApiResponse.error(e.toString());
      AppUtils.instance.snackBar("Error", e.toString(), true);
    }
  }

  /* =========================================================
      PRODUCT DETAILS PAGE (PDP)
  ========================================================== */

  Future<bool> fetchDescriptionData(BuildContext context, String discId) async {
    try {
      isPdpLoading.value = true;
      pdpStatus.value = Status.LOADING;

      final value = await _hostRepo.getData(AppUrl.getHostDecyUrls + discId);

      final host = value.data?.hostDescription;
      final location = value.data?.location;

      if (host != null) {
        pdpData.value = _mapToCommonModel(host, location);
      }

      pdpStatus.value = Status.COMPLETED;
      isPdpLoading.value = false;

      return true;
    } catch (error) {
      isPdpLoading.value = false;
      pdpStatus.value = Status.ERROR;

      AppUtils.instance.snackBar("Error", error.toString(), true);

      return false;
    }
  }

  /* =========================================================
      AMENITIES LIST
  ========================================================== */

  Rx<ApiResponse<AmenitiesListModel>> amenitiesData =
      ApiResponse<AmenitiesListModel>.loading().obs;
  final RxBool isCheckingAvailability = false.obs;

  Future<void> fetchAmenitiesData({
    required BuildContext context,
    required String catId,
    required String subCatId,
    required String hostId,
    String? locationId = '',
  }) async {
    try {
      amenitiesData.value = ApiResponse.loading();

      final url =
          '${AppUrl.getAmenitiesyUrls}'
          '?categoryId=$catId'
          '&subCategoryId=$subCatId'
          '&hostId=$hostId'
          '&locationId=$locationId'
          '&limit=10';

      final response = await _hostRepo.getAniData(url);

      amenitiesData.value = ApiResponse.completed(response);
    } catch (error) {
      amenitiesData.value = ApiResponse.error(error.toString());

      AppUtils.instance.snackBar("Error", error.toString(), true);
    }
  }

  Future<bool> checkAvailability({
    required String locationId,
    required String checkDate,
    required String fromTime,
    required String toTime,
  }) async {
    if (locationId.trim().isEmpty) {
      AppUtils.instance.snackBar("Error", "Location id is missing", true);
      return false;
    }

    try {
      isCheckingAvailability.value = true;
      final response = await _hostRepo.checkAvailability(
        AppUrl.checkAvailabilityUrl(
          locationId: locationId,
          checkDate: checkDate,
          fromTime: fromTime,
          toTime: toTime,
        ),
      );

      final bool success = response['success'] == true;
      final bool isAvailable = response['data']?['isAvailable'] == true;
      final String message =
          response['data']?['message']?.toString() ??
          response['message']?.toString() ??
          '';

      if (success && isAvailable) {
        return true;
      }

      AppUtils.instance.snackBar(
        "Info",
        message.isNotEmpty ? message : "Selected slot is not available",
        true,
      );
      return false;
    } catch (error) {
      AppUtils.instance.snackBar("Error", error.toString(), true);
      return false;
    } finally {
      isCheckingAvailability.value = false;
    }
  }
}
