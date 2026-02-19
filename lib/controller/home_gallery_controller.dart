// lib/controllers/order_summary_controller.dart


import 'package:flutter/material.dart';
import 'package:foodyore/data/response/api_response.dart';
import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/model/home_gallery_model.dart';
import 'package:foodyore/repository/home_gallery_repo.dart';
import 'package:foodyore/res/app_urls.dart';
import 'package:foodyore/utils/app_utils.dart';
import 'package:get/get.dart';

class HomeGalleryController extends GetxController {
  final _api = HomeGalleryRepo();
  final rxRequestStatus = Status.LOADING.obs;
  RxBool isLoading = false.obs;
  Rx<ApiResponse<HomeGalleryModel>> homdeGalleryData =
      ApiResponse<HomeGalleryModel>.loading().obs;

  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  setOrderListData(ApiResponse<HomeGalleryModel> response) {
    homdeGalleryData.value = response;
    update();
  }

  void fetchGalleryData(BuildContext context) async {
    isLoading.value = true;

    setRxRequestStatus(Status.LOADING);
    update();
    await _api
        .getData(AppUrl.homeGalleryUrls)
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
}
