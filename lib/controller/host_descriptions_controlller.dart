// lib/controllers/order_summary_controller.dart

import 'package:flutter/material.dart';
import 'package:foodyore/data/response/api_response.dart';
import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/model/amenities_list_model.dart';
import 'package:foodyore/model/host_descripetions_model.dart';
import 'package:foodyore/repository/host_repo.dart';
import 'package:foodyore/res/app_urls.dart';
import 'package:foodyore/utils/app_utils.dart';
import 'package:get/get.dart';

class HostDescriptionsControlller extends GetxController {
  final _api = HostRepo();
  final rxRequestStatus = Status.LOADING.obs;
  RxBool isLoading = false.obs;
  Rx<ApiResponse<HostDescripetionsModel>> hostDescripetionsModel =
      ApiResponse<HostDescripetionsModel>.loading().obs;

  Rx<ApiResponse<AmenitiesListModel>> animatesListModel =
      ApiResponse<AmenitiesListModel>.loading().obs;

  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  setOrderListData(ApiResponse<HostDescripetionsModel> response) {
    hostDescripetionsModel.value = response;
    update();
  }
   setAniListData(ApiResponse<AmenitiesListModel> response) {
    animatesListModel.value = response;
    update();
  }

  void fetchHostData(BuildContext context, String hostId) async {
    isLoading.value = true;

    setRxRequestStatus(Status.LOADING);
    update();
    await _api
        .getData(AppUrl.getHostDecyUrls+hostId)
        .then((value) {
          setRxRequestStatus(Status.COMPLETED);
          setOrderListData(ApiResponse.completed(value));
          isLoading.value = false;
          update();
        })
        .onError((error, stackTrace) {
          isLoading.value = false;
          print("DashBoard");
          print("order summerry  $error");
          setRxRequestStatus(Status.ERROR);
          AppUtils.instance.snackBar("Error", error.toString(), true);
          update();
        });
  }
  void fetcAnimatesData(BuildContext context, String catId, String subCatId, String hostId, String locationId ) async {
    isLoading.value = true;
    setRxRequestStatus(Status.LOADING);
    update();
      final url =
      '${AppUrl.getAmenitiesyUrls}'
      '?categoryId=$catId'
      '&subCategoryId=$subCatId'
      '&hostId=$hostId'
      '&locationId=$locationId'
      '&limit=10';
    await _api
        .getAniData(url)
        .then((value) {
          setRxRequestStatus(Status.COMPLETED);
          setAniListData(ApiResponse.completed(value));
          isLoading.value = false;
          update();
        })
        .onError((error, stackTrace) {
          isLoading.value = false;
          print("DashBoard");
          print("order summerry  $error");
          setRxRequestStatus(Status.ERROR);
          AppUtils.instance.snackBar("Error", error.toString(), true);
          update();
        });
  }


}
