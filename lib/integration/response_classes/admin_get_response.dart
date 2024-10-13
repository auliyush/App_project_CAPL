class AdminGetResponse {
  String username;
  String password;
  String phone;
  String email;

  AdminGetResponse({required this.username,
    required this.password,
    required this.email,
    required this.phone,});


  factory AdminGetResponse.fromJson(Map<String, dynamic> json) {
    return AdminGetResponse(
        username: json["adminName"],
        password: json["adminPassword"],
        email: json["adminEmail"],
        phone: json["adminPhone"],
    );
  }
}

class UserGetResponse {
  String username;
  String password;
  String phone;
  String email;

  UserGetResponse({required this.username,
    required this.password,
    required this.email,
    required this.phone,});


  factory UserGetResponse.fromJson(Map<String, dynamic> json) {
    return UserGetResponse(
      username: json["userName"],
      password: json["userPassword"],
      email: json["userEmail"],
      phone: json["userPhone"],
    );
  }
}
