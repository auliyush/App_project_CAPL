// import 'package:flutter/cupertino.dart';
//
// class LoginProvider with ChangeNotifier {
//   LoginResponse? _loginResponse;
//
//   LoginResponse? get loginResponse => _loginResponse;
//
//   void setLoginResponse(LoginResponse loginResponse) {
//     _loginResponse = loginResponse;
//     notifyListeners();
//   }
// }




class LoginResponse {
  final String creatorId;
  final String role;

  LoginResponse({required this.creatorId, required this.role});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      creatorId: json["loggedId"],
      role: json["userRole"],
    );
  }
}