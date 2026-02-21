import 'package:foodyore/data/network/network_api_services.dart';
import 'package:foodyore/model/category_model.dart';
import 'package:foodyore/model/sub_cate_model.dart';

class CategoryRepo {
  final _apiService = NetworkApiServices();

  Future<CategoryResponseModel> getData(String urls) async {
    dynamic response = await _apiService.getApi(urls);
    return CategoryResponseModel.fromJson(response);
  }

   Future<SubCategoryResponseModel> getSubCateData(String urls) async {
    dynamic response = await _apiService.getApi(urls);
    return SubCategoryResponseModel.fromJson(response);
  }

  Future<dynamic> postData(String urls, var data) async {
    dynamic response = await _apiService.postApi(data, urls);
    return response;
  }
}
