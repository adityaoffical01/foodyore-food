import 'package:foodyore/data/network/network_api_services.dart';

class ContactRepo {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<dynamic> postData(String url, var body) async {
    try {
      final response = await _apiServices.postApi(body, url);
      return response;
    } catch (e) {
      throw Exception('Failed to submit contact form: $e');
    }
  }
}
