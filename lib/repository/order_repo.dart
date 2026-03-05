
import 'package:foodyore/data/network/network_api_services.dart';

class OrderRepo {
  final _apiService = NetworkApiServices();


  

  Future<dynamic> postData(String urls, var data) async {
    dynamic response = await _apiService.postApi(data, urls);
    return response;
  }

}
