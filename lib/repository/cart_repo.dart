
import 'package:foodyore/data/network/network_api_services.dart';
import 'package:foodyore/model/cart_model.dart';

class CartRepo {
  final _apiService = NetworkApiServices();

  Future<CartResponseModel> getCartItems(String urls) async {
    dynamic response = await _apiService.getApi(urls);
    return CartResponseModel.fromJson(response);
  }

  // Future<AmenitiesListModel> getAniData(String urls) async {
  //   dynamic response = await _apiService.getApi(urls);
  //   return AmenitiesListModel.fromJson(response);
  // }

  Future<dynamic> postData(String urls, var data) async {
    dynamic response = await _apiService.postApi(data, urls);
    return response;
  }

   Future<dynamic> putData(String urls, var data) async {

    dynamic response = await _apiService.putApi(data, urls);
    return response;
  }
  Future<dynamic> deleteData(String urls, ) async {
    
    dynamic response = await _apiService.deleteApi(urls);
    return response;
  }
}
