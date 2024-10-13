
class LoginResponse {
  final String signInId;
  final String role;

  LoginResponse({required this.signInId, required this.role});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      signInId: json["loggedId"],
      role: json["userRole"],
    );
  }
}