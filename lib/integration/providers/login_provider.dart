import 'package:flutter/cupertino.dart';
import 'package:merge_capl/integration/data_classes/login_response.dart';

class LoginProvider with ChangeNotifier{
  LoginResponse? _loginResponse;

  LoginResponse? get loginResponse => _loginResponse;

  void updateLoginResponse(LoginResponse response) {
    _loginResponse = response;
    notifyListeners();
  }
}