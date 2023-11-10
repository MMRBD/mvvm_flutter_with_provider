import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../data/network/api_urls.dart';
import '../models/users_model.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<UserModel> fetchUserList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(ApiUrls.usersEndPoint);
      return response = UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
