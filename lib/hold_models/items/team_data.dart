import 'package:merge_capl/hold_models/items/player_data.dart';

class TeamData {
  String teamId;
  String teamName;
  String teamNickName;
  String teamProfileUrl;
  List<FetchedPlayerData> players;

  TeamData({
    required this.teamId,
    required this.teamName,
    required this.teamNickName,
    required this.teamProfileUrl,
     required this.players,
  });
  factory TeamData.fromJson(Map<String, dynamic> jsonData) {
    List<FetchedPlayerData> players = (jsonData['playerList'] as List<dynamic>).map((playerJson) => FetchedPlayerData.fromJson(playerJson)).toList().cast<FetchedPlayerData>();

    return TeamData(
      teamId: jsonData["teamId"],
      teamProfileUrl: jsonData["teamProfilePhotoUrl"],
      teamName: jsonData["teamName"],
      teamNickName: jsonData["teamNickName"],
      players: players,
    );
  }
}
