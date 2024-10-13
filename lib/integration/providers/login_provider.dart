
import 'package:flutter/cupertino.dart';

import '../response_classes/admin_get_response.dart';
import '../response_classes/login_response.dart';

class LoginProvider with ChangeNotifier{
  LoginResponse? _loginResponse;

  LoginResponse? get loginResponse => _loginResponse;

  void updateLoginResponse(LoginResponse response) {
    _loginResponse = response;
    notifyListeners();
  }

  // for admin account detail access...
  AdminGetResponse? _adminGetResponse;
  AdminGetResponse? get adminResponse => _adminGetResponse;

  void updateAdminAccount (AdminGetResponse adminResponse) {
    _adminGetResponse = adminResponse;
    notifyListeners();
  }

}