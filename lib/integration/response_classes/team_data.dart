import 'package:merge_capl/integration/response_classes/player_data.dart';
class TeamData {
  String teamId;
  String teamName;
  String teamNickName;
  String teamProfileUrl;
  String teamCreatorId;
  bool inTournament;
  List<FetchedPlayerData> players;

  TeamData({
    required this.teamId,
    required this.teamName,
    required this.teamNickName,
    required this.teamProfileUrl,
    required this.teamCreatorId,
    required this.inTournament,
    required this.players,
  });
  factory TeamData.fromJson(Map<String, dynamic> jsonData) {
    List<FetchedPlayerData> players = (jsonData['playerList'] as List<dynamic>).map((playerJson) => FetchedPlayerData.fromJson(playerJson)).toList().cast<FetchedPlayerData>();
    return TeamData(
      teamId: jsonData["teamId"],
      teamProfileUrl: jsonData["teamProfilePhotoUrl"],
      teamName: jsonData["teamName"],
      teamNickName: jsonData["teamNickName"],
      teamCreatorId: jsonData["teamCreatorId"],
      inTournament: jsonData["inTournament"],
      players: players,
    );
  }
}
