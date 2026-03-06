import 'package:foodyore/data/network/network_api_services.dart';
import 'package:foodyore/model/search_responce_model.dart';
import 'package:foodyore/model/sub_category_search_responce.dart';

class SearchRepo {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<SearchResponseModel> getSearchResults(String url) async {
    final dynamic response = await _apiServices.getApi(url);
    return SearchResponseModel.fromJson(response as Map<String, dynamic>);
  }

  Future<SubCategorySearchResponseModel> getCitySubcategories(
    String url,
  ) async {
    final dynamic response = await _apiServices.getApi(url);
    return SubCategorySearchResponseModel.fromJson(
      response as Map<String, dynamic>,
    );
  }
}
