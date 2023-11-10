import '../data/network/network_api_services.dart';
import '../data/network/api_urls.dart';

class AuthRepository {
  final NetworkApiServices _network = NetworkApiServices();

  Future<dynamic> apiLogin(dynamic data) async {
    try {
      final response =
          await _network.getPostApiResponse(ApiUrls.loginEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUp(dynamic data) async {
    try {
      final response =
          await _network.getPostApiResponse(ApiUrls.registerEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
