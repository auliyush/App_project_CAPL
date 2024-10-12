class PlayerDataModel {
  final String playerPhotoUrl;
  final String playerName;
  final String playerNickName;
  final String playerMobNumber;
  final String playerEmail;
  final String address;
  final String playerType;
  final String playerSubType;
  final String playerPassword;

  PlayerDataModel({
    required this.playerPhotoUrl,
    required this.playerName,
    required this.playerNickName,
    required this.playerMobNumber,
    required this.playerEmail,
    required this.address,
    required this.playerType,
    required this.playerSubType,
    required this.playerPassword,
  });

  factory PlayerDataModel.fromJson(Map<String, dynamic> json) {
    return PlayerDataModel(
      playerPhotoUrl: json['playerProfilePhotoUrl'],
      playerName: json['playerName'],
      playerNickName: json['playerNickName'],
      playerMobNumber: json['playerPhone'],
      playerEmail: json['playerEmail'],
      address: json['playerAddress'],
      playerType: json['playerType'],
      playerSubType: json['playerSubType'],
      playerPassword: json['playerPassword'],
    );
  }

}


class PlayerAccountUpdateModel {
  final String playerPhotoUrl;
  final String playerName;
  final String playerNickName;
  final String playerMobNumber;
  final String playerEmail;
  final String address;
  final String playerType;
  final String playerSubType;

  PlayerAccountUpdateModel({
    required this.playerPhotoUrl,
    required this.playerName,
    required this.playerNickName,
    required this.playerMobNumber,
    required this.playerEmail,
    required this.address,
    required this.playerType,
    required this.playerSubType,
  });

  factory PlayerAccountUpdateModel.fromJson(Map<String, dynamic> json) {
    return PlayerAccountUpdateModel(
      playerPhotoUrl: json['playerProfilePhotoUrl'],
      playerName: json['playerName'],
      playerNickName: json['playerNickName'],
      playerMobNumber: json['playerPhone'],
      playerEmail: json['playerEmail'],
      address: json['playerAddress'],
      playerType: json['playerType'],
      playerSubType: json['playerSubType'],
    );
  }
}