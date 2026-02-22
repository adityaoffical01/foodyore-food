
import 'package:foodyore/data/network/network_api_services.dart';
import 'package:foodyore/model/amenities_list_model.dart';
import 'package:foodyore/model/host_descripetions_model.dart';

class HostRepo {
  final _apiService = NetworkApiServices();

  Future<HostDescripetionsModel> getData(String urls) async {
    dynamic response = await _apiService.getApi(urls);
    return HostDescripetionsModel.fromJson(response);
  }
   Future<AmenitiesListModel> getAniData(String urls) async {
    dynamic response = await _apiService.getApi(urls);
    return AmenitiesListModel.fromJson(response);
  }

  Future<dynamic> postData(String urls, var data) async {
    dynamic response = await _apiService.postApi(data, urls);
    return response;
  }


}
