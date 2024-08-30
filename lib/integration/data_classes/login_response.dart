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