class AdminGetResponse {
  String username;
  String password;
  String phone;
  String email;
  String profilePhoto;

  AdminGetResponse({required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.profilePhoto});


  factory AdminGetResponse.fromJson(Map<String, dynamic> json) {
    return AdminGetResponse(
        username: json["adminName"],
        password: json["adminPassword"],
        email: json["adminEmail"],
        phone: json["adminPhone"],
        profilePhoto: json["adminProfilePhotoUrl"]
    );
  }

}
