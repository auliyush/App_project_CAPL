class PlayerRoleResponse {
  List<PlayerDataByRole> playerRoles;

  PlayerRoleResponse({required this.playerRoles});

  factory PlayerRoleResponse.fromJsonList(List json) {
    return PlayerRoleResponse(
      playerRoles: json.map((e) => PlayerDataByRole.fromJson(e)).toList(),
    );
  }
}
class PlayerDataByRole {
  String playerId;
  String playerName;
  String playerNickname;
  String playerProfilePhotoUrl;
  String playerType;
  String playerSubType;
  bool inTeam;

  PlayerDataByRole({
    required this.playerId,
    required this.playerName,
    required this.playerNickname,
    required this.playerProfilePhotoUrl,
    required this.playerType,
    required this.playerSubType,
    required this.inTeam,
  });


  factory PlayerDataByRole.fromJson(Map<String, dynamic> json) {
    return PlayerDataByRole(
      playerId: json["playerId"],
      playerName: json["playerName"],
      playerNickname: json["playerNickName"],
      playerProfilePhotoUrl: json["playerProfilePhotoUrl"],
      playerType: json["playerType"],
      playerSubType: json["playerSubType"],
      inTeam: json["inTeam"],
    );
  }
}
