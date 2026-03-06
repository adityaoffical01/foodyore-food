import 'package:foodyore/data/network/network_api_services.dart';
import 'package:foodyore/model/Order_details_Model.dart';
import 'package:foodyore/model/order_model.dart';

class OrderRepo {
  final _apiService = NetworkApiServices();

  Future<OrderListResponseModel> getOrderHistory(String urls) async {
    final dynamic response = await _apiService.getApi(urls);
    return OrderListResponseModel.fromJson(response as Map<String, dynamic>);
  }

  Future<OrderDetailsResponseModel> getOrderDetails(String urls) async {
    final dynamic response = await _apiService.getApi(urls);
    return OrderDetailsResponseModel.fromJson(response as Map<String, dynamic>);
  }

  Future<dynamic> postData(String urls, var data) async {
    dynamic response = await _apiService.postApi(data, urls);
    return response;
  }
}
