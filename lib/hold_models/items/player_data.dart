import 'package:flutter/cupertino.dart';

// class PlayerDataResponse {
//  List <PlayerData> playerData;
//   PlayerDataResponse({required this.playerData});
//
//   factory PlayerDataResponse.fromJsonList(List json) {
//     return PlayerDataResponse(
//       playerData : json.map((e) => PlayerData.fromJson(e)).toList(),
//     );
//   }
// }

class FetchedPlayerData {
  String playerPhotoUrl;
  String? playerName;
  String? playerNickName;
  String? playerPhone;
  String? playerEmail;

  FetchedPlayerData({
    required this.playerPhotoUrl,
    required this.playerName,
    required this.playerNickName,
    required this.playerPhone,
    required this.playerEmail,
  });

  factory FetchedPlayerData.fromJson(Map<String, dynamic> jsonData) {
    return FetchedPlayerData(
      playerPhotoUrl: jsonData["playerProfilePhotoUrl"],
      playerName: jsonData["playerName"],
      playerNickName: jsonData["playerNickName"],
      playerPhone: jsonData["playerPhone"],
      playerEmail: jsonData["playerEmail"],
    );
  }
}

class PlayerData {
  String playerPhotoUrl;
  String? playerName;
  String? playerNickName;

  PlayerData({
    required this.playerPhotoUrl,
    required this.playerName,
    required this.playerNickName,
  });


}
