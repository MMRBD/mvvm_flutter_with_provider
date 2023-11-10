import 'package:flutter/material.dart';
import 'package:mvvm_provider_flutter/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../models/user_login_model.dart';
import '../../repository/auth_repository.dart';
import '../../utils/routes/routes_names.dart';
import '../../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _auth = AuthRepository();

  bool _loginLoading = false;
  bool _signupLoading = false;

  get loading => _loginLoading;

  get signupLoading => _signupLoading;

  void setLoginLoading(bool value) {
    _loginLoading = value;
    notifyListeners();
  }

  void setSignUpLoading(bool value) {
    _signupLoading = value;
    notifyListeners();
  }

  Future<void> login(dynamic data, BuildContext context) async {
    setLoginLoading(true);
    _auth.apiLogin(data).then((value) {
      setLoginLoading(false);

      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(UserLoginModel(token: value['token'].toString()));

      Utils.flushBarErrorMessage("Login Successful!", context);

      Navigator.pushNamed(context, RouteNames.home);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      setLoginLoading(false);
    });
  }

  Future<void> apiSignUp(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _auth.signUp(data).then((value) {
      Utils.flushBarErrorMessage("Sign Up Successful!", context);

      Navigator.pushNamed(context, RouteNames.home);
      setSignUpLoading(false);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      setSignUpLoading(false);
    });
  }
}
