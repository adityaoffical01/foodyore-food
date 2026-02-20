import 'dart:io';

import 'package:foodyore/data/network/network_api_services.dart';
import 'package:foodyore/model/home_gallery_model.dart';

class HomeGalleryRepo {
  final _apiService = NetworkApiServices();

  Future<HomeGalleryModel> getData(String urls) async {
    dynamic response = await _apiService.getApi(urls);
    return HomeGalleryModel.fromJson(response);
  }

  Future<dynamic> postData(String urls, var data) async {
    dynamic response = await _apiService.postApi(data, urls);
    return response;
  }

  Future<dynamic> postWithImage(
    String urls,
    File imageFile,
    var data,
    String imageTag,
  ) async {
    dynamic response = await _apiService.postApiWithImage(
      imageFile,
      data,
      urls,
      imageTag,
    );
    return response;
  }
}
