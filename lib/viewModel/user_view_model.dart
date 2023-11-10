import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_login_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserLoginModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", user.token.toString());
    notifyListeners();

    return true;
  }

  Future<bool> removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("token");
    notifyListeners();
    return true;
  }

  Future<UserLoginModel?> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString("token");
    return UserLoginModel(token: token.toString());
  }
}
