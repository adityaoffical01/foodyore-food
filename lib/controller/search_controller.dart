import 'package:foodyore/data/response/api_response.dart';
import 'package:foodyore/model/search_responce_model.dart';
import 'package:foodyore/model/sub_category_search_responce.dart';
import 'package:foodyore/repository/search_repo.dart';
import 'package:foodyore/res/app_urls.dart';
import 'package:get/get.dart';

class SearchCityController extends GetxController {
  final SearchRepo _searchRepo = SearchRepo();

  RxBool isSearchLoading = false.obs;
  RxBool isSubCategorySearchLoading = false.obs;
  Rx<ApiResponse<SearchResponseModel>> searchData =
      ApiResponse<SearchResponseModel>.loading().obs;
  Rx<ApiResponse<SubCategorySearchResponseModel>> subCategorySearchData =
      ApiResponse<SubCategorySearchResponseModel>.loading().obs;

  Future<void> searchCity(String city) async {
    final String query = city.trim();

    if (query.isEmpty) {
      searchData.value = ApiResponse.error('City is required');
      return;
    }

    isSearchLoading.value = true;
    searchData.value = ApiResponse.loading();

    try {
      final response = await _searchRepo.getSearchResults(
        AppUrl.search_city_URL(query),
      );
      searchData.value = ApiResponse.completed(response);
    } catch (e) {
      searchData.value = ApiResponse.error(e.toString());
    } finally {
      isSearchLoading.value = false;
    }
  }

  Future fetchCitySubcategories(String cityId) async {
    final String id = cityId.trim();

    if (id.isEmpty) {
      subCategorySearchData.value = ApiResponse.error('City ID is required');
      return;
    }

    isSubCategorySearchLoading.value = true;
    subCategorySearchData.value = ApiResponse.loading();

    try {
      final response = await _searchRepo.getCitySubcategories(
        AppUrl.city_subcategories_URL(id),
      );
      subCategorySearchData.value = ApiResponse.completed(response);
      
    } catch (e) {
      subCategorySearchData.value = ApiResponse.error(e.toString());
    } finally {
      isSubCategorySearchLoading.value = false;
    }
  }
}
