import 'package:flutter/material.dart';
import 'package:mvvm_provider_flutter/models/users_model.dart';

import '../../data/response/api_response.dart';
import '../../repository/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final _homeRepository = HomeRepository();

  ApiResponse<UserModel> userList = ApiResponse.loading();

  setUserList(ApiResponse<UserModel> response) {
    userList = response;
    notifyListeners();
  }

  void fetchMoviesListApi() async {
    setUserList(ApiResponse.loading());

    _homeRepository.fetchUserList().then((data) {
      setUserList(ApiResponse.completed(data));
    }).onError((error, stackTrace) {
      setUserList(ApiResponse.error(error.toString()));
    });
  }
}
